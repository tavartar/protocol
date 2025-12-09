#!/usr/bin/env python3
"""
generate_py.py
Python protocol generator for protocol v2.0

This version:
 - Reads protocol/protocol.json (v2.0 format)
 - Supports new structure:
     {
       "version": "2.0.0",
       "meta": {...},
       "namespaces": {
           "<ns>": {
              "description": "...",
              "events": {
                  "<event>": {
                      "direction": "...",
                      "phase": "...",
                      "payload": {...}
                  }
              }
           }
       }
     }
 - Outputs:
      mtv_protocol/
         enums/
         models/
         protocol_event.py
         registry.py
"""

import json
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
PROTO_PATH = REPO_ROOT / "protocol" / "protocol.json"
OUT_ROOT = REPO_ROOT / "protocol" / "out" / "python" / "mtv_protocol"


# -----------------------------------------------------------
# Directory helpers
# -----------------------------------------------------------

def ensure_dir(p: Path):
    p.mkdir(parents=True, exist_ok=True)


# -----------------------------------------------------------
# Type mapping
# -----------------------------------------------------------

def py_type(t: str) -> str:
    """Map protocol scalar/complex type → Python type string."""
    if t == "string":
        return "str"
    if t == "number":
        return "float"
    if t == "boolean":
        return "bool"
    if t == "object":
        return "dict"

    if t.startswith("array<") and t.endswith(">"):
        inner = t[6:-1]
        return f"list[{py_type(inner)}]"

    return "str"  # fallback


# -----------------------------------------------------------
# ENUM generator
# -----------------------------------------------------------

def gen_enum(namespace: str, events: dict) -> str:
    lines = [
        "from enum import Enum",
        "",
        f"class {namespace.capitalize()}Event(str, Enum):",
    ]
    for event in events.keys():
        lines.append(f"    {event} = \"{event}\"")
    return "\n".join(lines) + "\n"


# -----------------------------------------------------------
# Pydantic models generator
# -----------------------------------------------------------

def gen_models(namespace: str, events: dict) -> str:
    lines = [
        "from pydantic import BaseModel",
        "",
        f"# Payload Models for namespace: {namespace}",
        "",
    ]

    for ev_name, ev_def in events.items():
        payload = ev_def.get("payload", {})
        class_name = f"{ev_name}Payload"

        lines.append(f"class {class_name}(BaseModel):")

        if not payload:
            lines.append("    pass")
            lines.append("")
            continue

        for field, type_ in payload.items():
            lines.append(f"    {field}: {py_type(type_)}")

        lines.append("")

    return "\n".join(lines)


# -----------------------------------------------------------
# ProtocolEvent wrapper
# -----------------------------------------------------------

def gen_protocol_event() -> str:
    return """from pydantic import BaseModel
from typing import Optional


class ProtocolEvent(BaseModel):
    namespace: str
    event: str
    payload: dict
    direction: str
    phase: str

    def model(self) -> Optional[BaseModel]:
        \"\"\"Return the Pydantic model matching this event payload (if any).\"\"\"
        from .registry import EVENT_MODELS
        key = (self.namespace, self.event)
        Model = EVENT_MODELS.get(key)
        if Model:
            return Model(**self.payload)
        return None
"""


# -----------------------------------------------------------
# Registry builder
# -----------------------------------------------------------

def gen_registry(namespaces: dict) -> str:
    lines = [
        "from typing import Dict, Tuple, Type",
        "from pydantic import BaseModel",
        "",
    ]

    # imports
    for ns, ns_def in namespaces.items():
        for ev in ns_def["events"].keys():
            lines.append(f"from .models.{ns} import {ev}Payload")

    lines.append("")
    lines.append("EVENT_MODELS: Dict[Tuple[str, str], Type[BaseModel]] = {}")
    lines.append("")

    # registry entries
    for ns, ns_def in namespaces.items():
        for ev in ns_def["events"].keys():
            lines.append(f"EVENT_MODELS[(\"{ns}\", \"{ev}\")] = {ev}Payload")

    return "\n".join(lines)


# -----------------------------------------------------------
# Main
# -----------------------------------------------------------

def main():
    print("📄 Loading protocol:", PROTO_PATH)

    with open(PROTO_PATH, "r", encoding="utf-8") as f:
        proto = json.load(f)

    namespaces = proto["namespaces"]

    # Prepare directories
    ensure_dir(OUT_ROOT)
    ensure_dir(OUT_ROOT / "enums")
    ensure_dir(OUT_ROOT / "models")

    (OUT_ROOT / "__init__.py").write_text("# mtv_protocol package\n")

    # Generate files per namespace
    for ns, ns_def in namespaces.items():
        events = ns_def["events"]

        enum_file = OUT_ROOT / "enums" / f"{ns}.py"
        model_file = OUT_ROOT / "models" / f"{ns}.py"

        enum_file.write_text(gen_enum(ns, events))
        model_file.write_text(gen_models(ns, events))

    # Write ProtocolEvent wrapper
    (OUT_ROOT / "protocol_event.py").write_text(gen_protocol_event())

    # Write central registry
    (OUT_ROOT / "registry.py").write_text(gen_registry(namespaces))

    print("🎉 Python protocol code generated at:", OUT_ROOT)


if __name__ == "__main__":
    main()

