#!/usr/bin/env node
/**
 * JS code generator (Protocol v2.0)
 *
 * Input:
 *   protocol/protocol.json   (validated with schema v2.0)
 *
 * Output:
 *   out/js/mtv_protocol/
 *     enums/*.js
 *     models/*.js
 *     protocolEvent.js
 *     registry.js
 */

const fs = require("fs");
const path = require("path");

const ROOT = path.resolve(__dirname, "../../");
const PROTOCOL_FILE = path.join(ROOT, "protocol", "protocol.json");
const OUT_ROOT = path.join(ROOT, "protocol", "out", "js", "mtv_protocol");

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function ensureDir(p) {
  fs.mkdirSync(p, { recursive: true });
}

function jsType(t) {
  if (t === "string") return "string";
  if (t === "number") return "number";
  if (t === "boolean") return "boolean";
  if (t === "object") return "object";
  if (t.startsWith("array<") && t.endsWith(">")) return "array";
  return "any";
}

// ---------------------------------------------------------------------------
// Enum generator
// ---------------------------------------------------------------------------

function genEnum(namespace, events) {
  const lines = [];
  lines.push(`// Enum for namespace: ${namespace}`);
  lines.push(`export const ${namespace}Events = Object.freeze({`);
  for (const ev of Object.keys(events)) {
    lines.push(`  ${ev}: "${ev}",`);
  }
  lines.push(`});`);
  return lines.join("\n");
}

// ---------------------------------------------------------------------------
// Model generator
// ---------------------------------------------------------------------------

function genModels(namespace, events) {
  const lines = [];
  lines.push(`// Models for namespace: ${namespace}`);
  lines.push("");

  for (const [eventName, def] of Object.entries(events)) {
    const payload = def.payload || {};
    lines.push(`export function ${eventName}Payload() {`);
    lines.push(`  return {`);

    for (const [field, t] of Object.entries(payload)) {
      lines.push(`    ${field}: null, // type: ${t}`);
    }

    lines.push(`  };`);
    lines.push(`}`);
    lines.push("");
  }

  return lines.join("\n");
}

// ---------------------------------------------------------------------------
// ProtocolEvent wrapper
// ---------------------------------------------------------------------------

function genProtocolEvent() {
  return `
export class ProtocolEvent {
  constructor({ namespace, event, payload, direction }) {
    this.namespace = namespace;
    this.event = event;
    this.payload = payload || {};
    this.direction = direction;
  }

  // convert to model instance
  model() {
    try {
      const { EVENT_MODELS } = require("./registry.js");
      const key = \`\${this.namespace}::\${this.event}\`;
      const ctor = EVENT_MODELS[key];
      return ctor ? ctor() : null;
    } catch {
      return null;
    }
  }
}
`;
}

// ---------------------------------------------------------------------------
// Registry
// ---------------------------------------------------------------------------

function genRegistry(namespaces) {
  const lines = [];
  lines.push(`// Auto-generated registry`);
  lines.push(`export const EVENT_MODELS = {};`);
  lines.push("");

  // Imports
  for (const ns of Object.keys(namespaces)) {
    lines.push(`import * as ${ns}Models from "./models/${ns}.js";`);
  }
  lines.push("");

  // Populate mapping
  for (const [ns, entry] of Object.entries(namespaces)) {
    for (const ev of Object.keys(entry.events)) {
      lines.push(
        `EVENT_MODELS["${ns}::${ev}"] = ${ns}Models.${ev}Payload;`
      );
    }
  }
  lines.push("");

  return lines.join("\n");
}

// ---------------------------------------------------------------------------
// MAIN
// ---------------------------------------------------------------------------

console.log("[codegen-js] reading protocol:", PROTOCOL_FILE);

const protocol = JSON.parse(fs.readFileSync(PROTOCOL_FILE, "utf-8"));
const namespaces = protocol.namespaces;

// Create directories
ensureDir(OUT_ROOT);
ensureDir(path.join(OUT_ROOT, "enums"));
ensureDir(path.join(OUT_ROOT, "models"));

// Generate files
for (const [ns, entry] of Object.entries(namespaces)) {
  const enumPath = path.join(OUT_ROOT, "enums", `${ns}.js`);
  const modelPath = path.join(OUT_ROOT, "models", `${ns}.js`);

  fs.writeFileSync(enumPath, genEnum(ns, entry.events));
  fs.writeFileSync(modelPath, genModels(ns, entry.events));
}

// ProtocolEvent + registry
fs.writeFileSync(path.join(OUT_ROOT, "protocolEvent.js"), genProtocolEvent());
fs.writeFileSync(path.join(OUT_ROOT, "registry.js"), genRegistry(namespaces));

console.log("[done] JS code generated at:", OUT_ROOT);

