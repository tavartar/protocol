#!/usr/bin/env node
/**
 * TypeScript code generator for mtv_protocol (schema v2.0).
 *
 * Reads mtv/protocol.json and generates:
 *   - Enums per namespace
 *   - Zod payload schemas per event
 *   - ProtocolEvent wrapper
 *   - Registry for namespace/event → Zod schema
 */

const fs = require("fs");
const path = require("path");

// ---------------------------
// Paths
// ---------------------------
const REPO_ROOT = path.resolve(__dirname, "../..");
const PROTOCOL_FILE = path.join(REPO_ROOT, "protocol/protocol.json");
const OUT_ROOT = path.join(REPO_ROOT, "protocol/out/ts/mtv_protocol");

// ---------------------------
// Helpers
// ---------------------------
function ensureDir(p) {
  if (!fs.existsSync(p)) fs.mkdirSync(p, { recursive: true });
}

function zodType(t) {
  if (t === "string") return "z.string()";
  if (t === "number") return "z.number()";
  if (t === "boolean") return "z.boolean()";

  if (t.startsWith("array<") && t.endsWith(">")) {
    const inner = t.slice(6, -1);
    return `z.array(${zodType(inner)})`;
  }

  if (t === "object") return "z.record(z.any())";

  return "z.any()";
}

function capitalize(s) {
  return s.charAt(0).toUpperCase() + s.slice(1);
}

// ---------------------------
// Enum generator
// ---------------------------
function genEnum(namespace, events) {
  let out = `export enum ${capitalize(namespace)}Event {\n`;
  for (const eventName of Object.keys(events)) {
    out += `  ${eventName} = "${eventName}",\n`;
  }
  out += "}\n";
  return out;
}

// ---------------------------
// Zod payload models
// ---------------------------
function genZodModels(namespace, events) {
  let out = `import { z } from "zod";\n\n`;
  out += `// Payload models for namespace: ${namespace}\n\n`;

  for (const [eventName, eventData] of Object.entries(events)) {
    const payload = eventData.payload ?? {};

    out += `export const ${eventName}Payload = z.object({\n`;
    for (const [field, type] of Object.entries(payload)) {
      out += `  ${field}: ${zodType(type)},\n`;
    }
    out += "});\n\n";
  }

  return out;
}

// ---------------------------
// ProtocolEvent wrapper
// ---------------------------
function genProtocolEvent() {
  return `\
import { z } from "zod";
import { EVENT_MODELS } from "./registry";

export const ProtocolEvent = z.object({
  namespace: z.string(),
  event: z.string(),
  direction: z.string(),
  phase: z.string(),
  payload: z.record(z.any())
});

export type ProtocolEvent = z.infer<typeof ProtocolEvent>;

export function parsePayload(evt: ProtocolEvent) {
  const key = \`\${evt.namespace}::\${evt.event}\`;
  const schema = EVENT_MODELS[key];
  if (!schema) return null;
  return schema.parse(evt.payload);
}
`;
}

// ---------------------------
// Registry
// ---------------------------
function genRegistry(namespaces) {
  let out = `import { z } from "zod";\n`;

  // imports
  for (const ns of Object.keys(namespaces)) {
    out += `import * as ${ns}Models from "./models/${ns}";\n`;
  }

  out += `\nexport const EVENT_MODELS = {} as Record<string, z.ZodSchema>;\n\n`;

  for (const [ns, nsData] of Object.entries(namespaces)) {
    const events = nsData.events;
    for (const evt of Object.keys(events)) {
      out += `EVENT_MODELS["${ns}::${evt}"] = ${ns}Models.${evt}Payload;\n`;
    }
  }

  return out;
}

// ---------------------------
// Main
// ---------------------------
function main() {
  console.log("[codegen-ts] reading protocol:", PROTOCOL_FILE);

  const protocol = JSON.parse(fs.readFileSync(PROTOCOL_FILE, "utf8"));
  const namespaces = protocol.namespaces;

  ensureDir(OUT_ROOT);
  ensureDir(path.join(OUT_ROOT, "enums"));
  ensureDir(path.join(OUT_ROOT, "models"));

  // per-namespace output
  for (const [ns, nsData] of Object.entries(namespaces)) {
    const events = nsData.events;

    fs.writeFileSync(
      path.join(OUT_ROOT, "enums", `${ns}.ts`),
      genEnum(ns, events)
    );

    fs.writeFileSync(
      path.join(OUT_ROOT, "models", `${ns}.ts`),
      genZodModels(ns, events)
    );
  }

  // ProtocolEvent wrapper
  fs.writeFileSync(
    path.join(OUT_ROOT, "protocolEvent.ts"),
    genProtocolEvent()
  );

  // Registry
  fs.writeFileSync(
    path.join(OUT_ROOT, "registry.ts"),
    genRegistry(namespaces)
  );

  // index barrel file
  fs.writeFileSync(
    path.join(OUT_ROOT, "index.ts"),
    `export * from "./protocolEvent";\nexport * from "./registry";\n`
  );

  console.log("[done] TS code generated at:", OUT_ROOT);
}

main();

