# ~/mtv/protocol/codegen/Makefile

SWIFT_GEN=generate_swift.swift
PY_GEN=generate_py.py
JS_GEN=generate_js.js
TS_GEN=generate_ts.js
TS_GEN_V1=generate_ts.js.v1.0
KOTLIN_GEN=generate_kotlin.main.kts

.PHONY: all swift python js ts ts_v1 kotlin rust clean

all: swift python js ts kotlin rust

swift:
	@echo "▶️  Generating Swift..."
	@swift $(SWIFT_GEN)

python:
	@echo "🐍 Generating Python..."
	@python3 $(PY_GEN)

js:
	@echo "🟨 Generating JavaScript..."
	@node $(JS_GEN)

ts:
	@echo "🟦 Generating TypeScript (latest)..."
	@node $(TS_GEN)

ts_v1:
	@echo "🟦 Generating TypeScript v1.0..."
	@node $(TS_GEN_V1)

kotlin:
	@echo "🧬 Generating Kotlin..."
	@kotlinc -script $(KOTLIN_GEN)

rust:
	@echo "🦀 Building Rust codegen..."
	@cd rust_codegen && cargo build --release

go:
	@echo "🐹 Generating Go code..."
	@if [ -f generate_go.go ]; then go run generate_go.go $(PROTOCOL_JSON) $(OUT_DIR)/go; else echo "⚠️  Skipping Go: generate_go.go not found."; fi


clean:
	@echo "🧹 Cleaning Rust build..."
	@cd rust_codegen && cargo clean

port:
	mkdir -p ~/mtv/karaoke-app/protocol/
	cp -r ../out/python  ~/mtv/karaoke-app/protocol/ 2>/dev/null || true
	cp -r ../out/swift   ~/mtv/karaoke-app/protocol/ 2>/dev/null || true
	cp -r ../out/kotlin  ~/mtv/karaoke-app/protocol/ 2>/dev/null || true
	cp -r ../out/ts      ~/mtv/karaoke-app/protocol/ 2>/dev/null || true
	cp -r ../out/go      ~/mtv/karaoke-app/protocol/ 2>/dev/null || true
	cp -r ../out/rust    ~/mtv/karaoke-app/protocol/ 2>/dev/null || true

