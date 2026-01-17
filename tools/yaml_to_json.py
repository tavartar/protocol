import yaml
import json
from pathlib import Path

def yaml_to_fragments(map_path: Path, out_dir: Path):
    with open(map_path) as f:
        data = yaml.safe_load(f)

    namespaces = data.get("participants", {}).keys()
    out_dir.mkdir(parents=True, exist_ok=True)

    for ns in namespaces:
        fragment = {
		    "description": f"Auto-generated fragment for {ns}",
		    "events": {
		        "__placeholder__": {
		            "direction": "server→client",
		            "phase": "system",
		            "payload": {
		                "note": "string"
		            },
		            "description": "Placeholder event. Replace with real events."
		        }
		    }
		}

        with open(out_dir / f"{ns}.json", "w") as f:
            json.dump(fragment, f, indent=2)
        print(f"🧩 Generated fragment: {ns}.json")

if __name__ == "__main__":
    ROOT = Path(__file__).resolve().parents[1]
    MAP = ROOT / "communication_map.yaml"
    OUT = ROOT / "namespaces"

    if not MAP.exists():
        raise SystemExit(f"❌ communication_map.yaml not found at {MAP}")

    yaml_to_fragments(MAP, OUT)

