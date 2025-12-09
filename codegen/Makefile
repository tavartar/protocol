# Makefile for protocol code generation
# Place this in /Users/anhnguyen/mtv/protocol/codegen

SWIFT_GEN=generate_swift.swift
PY_GEN=generate_py.py
JS_GEN=generate_js.js
TS_GEN=generate_ts.js
TS_GEN_V1=generate_ts.js.v1.0
KOTLIN_GEN=generate_kotlin.main.kts

all: swift python js ts kotlin

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

clean:
	@echo "🧹 Cleaning Rust build..."
	@cd rust_codegen && cargo clean

.PHONY: all swift python js ts ts_v1 kotlin rust clean

