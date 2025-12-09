#!/usr/bin/env python3
"""
validate.py
Validate protocol.json against protocol.schema.json using JSON Schema.
This is the single source of truth validator for the MTV protocol.
"""

import json
from pathlib import Path
from jsonschema import validate, Draft202012Validator
from jsonschema.exceptions import ValidationError

ROOT = Path(__file__).resolve().parent
PROTO = ROOT / "protocol.json"
SCHEMA = ROOT / "protocol.schema.json"


def load_json(path: Path):
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def main():
    print(f"📄 Loading schema: {SCHEMA}")
    print(f"📄 Loading protocol: {PROTO}")

    if not PROTO.exists():
        print(f"❌ protocol.json not found at {PROTO}")
        exit(1)

    if not SCHEMA.exists():
        print(f"❌ protocol.schema.json not found at {SCHEMA}")
        exit(1)

    schema = load_json(SCHEMA)
    protocol = load_json(PROTO)

    print("🔍 Validating...")

    try:
        validator = Draft202012Validator(schema)
        validator.validate(protocol)
    except ValidationError as e:
        print("❌ Protocol validation failed")
        print("----------------------------------------------------")
        print("Message:", e.message)
        print("Instance path:", list(e.absolute_path))
        print("Schema path:", list(e.absolute_schema_path))
        print("----------------------------------------------------")
        exit(1)

    print("✅ Protocol.json is VALID according to schema v2.0")


if __name__ == "__main__":
    main()

