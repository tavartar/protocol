import json
from pathlib import Path

def compose_protocol(fragments_dir: Path, out_file: Path):
    protocol = {
        "version": "2.0.0",
        "meta": {"generated": True},
        "namespaces": {}
    }

    for path in fragments_dir.glob("*.json"):
        with open(path) as f:
            protocol["namespaces"][path.stem] = json.load(f)

    with open(out_file, "w") as f:
        json.dump(protocol, f, indent=2)

    print(f"📦 Composed protocol.json with {len(protocol['namespaces'])} namespaces")

if __name__ == "__main__":
    ROOT = Path(__file__).resolve().parents[1]     # ~/mtv/protocol
    FRAGMENTS = ROOT / "namespaces"               # or ROOT if that's where they are
    OUT = ROOT / "protocol.json"

    if not FRAGMENTS.exists():
        raise SystemExit(f"❌ Fragments directory not found: {FRAGMENTS}")

    compose_protocol(FRAGMENTS, OUT)

