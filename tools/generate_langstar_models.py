import subprocess
from pathlib import Path

def generate_models(protocol_json: Path):
    codegen = Path(__file__).parents[1] / "codegen" / "generate_py.py"
    subprocess.run(["python3", str(codegen)], check=True)
    print("🐍 Generated Python protocol models for LangStar")
