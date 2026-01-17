# Enhanced Makefile with original validate.py location and parameters preserved

PYTHON       := python3
TOOLS        := tools
CODEGEN_DIR  := codegen
APP_PROTOCOL := ~/mtv/karaoke-app/protocol/
OUT_DIR      := out
PROTOCOL     := protocol.json

.PHONY: all json compose validate python swift kotlin ts rust port clean

all: json compose validate python swift kotlin ts rust port

json:
	$(PYTHON) $(TOOLS)/yaml_to_json.py

compose:
	$(PYTHON) $(TOOLS)/compose_protocol.py

validate:
	$(PYTHON) validate.py

python:
	$(MAKE) -C $(CODEGEN_DIR) python

swift:
	$(MAKE) -C $(CODEGEN_DIR) swift

kotlin:
	@if [ -f generate_kotlin.main.kts ]; then \
		echo "🧬 Generating Kotlin..."; \
		kotlin generate_kotlin.main.kts ../protocol.json ../out/kotlin; \
	fi


ts:
	$(MAKE) -C $(CODEGEN_DIR) ts

rust:
	$(MAKE) -C $(CODEGEN_DIR) rust

go:
	@$(MAKE) -C $(CODEGEN_DIR) go

port:
	$(MAKE) -C $(CODEGEN_DIR) port

clean:
	rm -rf $(OUT_DIR)/

