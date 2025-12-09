package main

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

// ------------------------------------------------------------
// Protocol structures (must match protocol v2.0)
// ------------------------------------------------------------

type Protocol struct {
	Version    string                         `json:"version"`
	Meta       map[string]any                 `json:"meta"`
	Namespaces map[string]NamespaceDefinition `json:"namespaces"`
}

type NamespaceDefinition struct {
	Description string                      `json:"description"`
	Events      map[string]EventDefinition  `json:"events"`
}

type EventDefinition struct {
	Description string            `json:"description"`
	Direction   string            `json:"direction"`
	Phase       string            `json:"phase"`
	Payload     map[string]string `json:"payload"`
}

// ------------------------------------------------------------
// Type mapping
// ------------------------------------------------------------
func goType(t string) string {
	switch {
	case t == "string":
		return "string"
	case t == "number":
		return "float64"
	case t == "boolean":
		return "bool"
	case t == "object":
		return "map[string]any"
	case strings.HasPrefix(t, "array<") && strings.HasSuffix(t, ">"):
		inner := t[6 : len(t)-1]
		return "[]" + goType(inner)
	default:
		return "any"
	}
}

// ------------------------------------------------------------
// Helpers
// ------------------------------------------------------------
func writeFile(path string, content string) {
	os.MkdirAll(filepath.Dir(path), 0o755)
	os.WriteFile(path, []byte(content), 0o644)
}

func pascal(s string) string {
	parts := strings.Split(s, "_")
	for i := range parts {
		if len(parts[i]) > 0 {
			parts[i] = strings.ToUpper(parts[i][:1]) + parts[i][1:]
		}
	}
	return strings.Join(parts, "")
}

// ------------------------------------------------------------
// Generate enums
// ------------------------------------------------------------
func genEnum(namespace string, events map[string]EventDefinition) string {
	sb := strings.Builder{}

	sb.WriteString("package enums\n\n")
	sb.WriteString("type " + pascal(namespace) + "Event string\n\n")
	sb.WriteString("const (\n")

	for ev := range events {
		sb.WriteString(fmt.Sprintf(
			"    %s_%s %sEvent = \"%s\"\n",
			strings.ToUpper(namespace),
			strings.ToUpper(ev),
			pascal(namespace),
			ev,
		))
	}

	sb.WriteString(")\n")
	return sb.String()
}

// ------------------------------------------------------------
// Generate payload models
// ------------------------------------------------------------
func genModels(namespace string, events map[string]EventDefinition) string {
	sb := strings.Builder{}
	sb.WriteString("package models\n\n")
	sb.WriteString("type _ = any\n\n")

	for ev, spec := range events {
		sb.WriteString(fmt.Sprintf("// %s payload\n", ev))
		sb.WriteString(fmt.Sprintf("type %sPayload struct {\n", pascal(ev)))

		if len(spec.Payload) == 0 {
			sb.WriteString("    Empty bool `json:\"empty\"`\n")
		} else {
			for field, t := range spec.Payload {
				sb.WriteString(fmt.Sprintf(
					"    %s %s `json:\"%s\"`\n",
					pascal(field),
					goType(t),
					field,
				))
			}
		}

		sb.WriteString("}\n\n")
	}

	return sb.String()
}

// ------------------------------------------------------------
// ProtocolEvent wrapper
// ------------------------------------------------------------
func genProtocolEvent() string {
	return `package event

import (
	"encoding/json"
)

type ProtocolEvent struct {
	Namespace string         ` + "`json:\"namespace\"`" + `
	Event     string         ` + "`json:\"event\"`" + `
	Payload   map[string]any ` + "`json:\"payload\"`" + `
	Direction string         ` + "`json:\"direction\"`" + `
	Phase     string         ` + "`json:\"phase\"`" + `
}

// Model maps event → typed payload struct
func (e *ProtocolEvent) Model() (any, error) {
	key := e.Namespace + ":" + e.Event
	ctor, ok := EVENT_REGISTRY[key]
	if !ok {
		return nil, nil
	}
	b, _ := json.Marshal(e.Payload)
	m := ctor()
	err := json.Unmarshal(b, m)
	return m, err
}
`
}

// ------------------------------------------------------------
// Registry
// ------------------------------------------------------------
func genRegistry(protocol Protocol) string {
	sb := strings.Builder{}
	sb.WriteString("package event\n\n")
	sb.WriteString("import \"mtv_protocol/models\"\n\n")

	sb.WriteString("var EVENT_REGISTRY = map[string]func() any{\n")

	for ns, nsdef := range protocol.Namespaces {
		for ev := range nsdef.Events {
			key := ns + ":" + ev
			sb.WriteString(fmt.Sprintf(
				"    \"%s\": func() any { return &models.%sPayload{} },\n",
				key,
				pascal(ev),
			))
		}
	}

	sb.WriteString("}\n")
	return sb.String()
}

// ------------------------------------------------------------
// Main
// ------------------------------------------------------------
func main() {
	// Find repo root
	cwd, _ := os.Getwd()
	repo := cwd
	for {
		if _, err := os.Stat(filepath.Join(repo, "protocol.json")); err == nil {
			break
		}
		if repo == "/" {
			fmt.Println("❌ Could not locate protocol.json")
			return
		}
		repo = filepath.Dir(repo)
	}

	path := filepath.Join(repo, "protocol.json")
	fmt.Println("📄 Using protocol:", path)

	data, err := os.ReadFile(path)
	if err != nil {
		panic(err)
	}

	var protocol Protocol
	if err := json.Unmarshal(data, &protocol); err != nil {
		panic(err)
	}

	out := filepath.Join(repo, "out", "go", "mtv_protocol")
	os.MkdirAll(out, 0o755)

	// Generate per-namespace
	for ns, nsdef := range protocol.Namespaces {
		writeFile(filepath.Join(out, "enums", ns+".go"), genEnum(ns, nsdef.Events))
		writeFile(filepath.Join(out, "models", ns+".go"), genModels(ns, nsdef.Events))
	}

	// Runtime layer
	writeFile(filepath.Join(out, "event", "protocol_event.go"), genProtocolEvent())
	writeFile(filepath.Join(out, "event", "registry.go"), genRegistry(protocol))

	fmt.Println("🎉 Go code generated at:", out)
}

