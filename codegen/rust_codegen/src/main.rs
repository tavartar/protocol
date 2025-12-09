// ------------------------------------------------------------
// Rust Protocol Code Generator (v2.0-clean)
// Zero warnings, fully compatible with protocol.json v2.0
// ------------------------------------------------------------

use serde::Deserialize;
use serde_json::{Map, Value};
use std::collections::HashMap;
use std::fs;
use std::path::{Path, PathBuf};

// ------------------------------------------------------------
// Protocol structures (fields prefixed with _ to silence warnings)
// ------------------------------------------------------------

#[derive(Debug, Deserialize)]
struct Protocol {
    #[serde(rename = "version")]
    _version: String,

    #[serde(rename = "meta")]
    _meta: Option<Value>,

    namespaces: HashMap<String, Namespace>,
}

#[derive(Debug, Deserialize)]
struct Namespace {
    #[serde(rename = "description")]
    _description: Option<String>,

    events: HashMap<String, Event>,
}

#[derive(Debug, Deserialize)]
struct Event {
    #[serde(rename = "description")]
    _description: Option<String>,

    #[serde(rename = "direction")]
    _direction: String,

    #[serde(rename = "phase")]
    _phase: Option<String>,

    payload: Map<String, Value>,
}

// ------------------------------------------------------------
// Helpers
// ------------------------------------------------------------

fn repo_root() -> PathBuf {
    let mut dir = std::env::current_dir().unwrap();

    for _ in 0..10 {
        let candidate = dir.join("protocol").join("protocol.json");
        if candidate.exists() {
            return dir;
        }
        dir = dir
            .parent()
            .expect("Cannot find repo root")
            .to_path_buf();
    }

    panic!("❌ Repo root not found.");
}

fn load_protocol(root: &Path) -> Protocol {
    let path = root.join("protocol").join("protocol.json");
    let data = fs::read_to_string(&path)
        .unwrap_or_else(|_| panic!("Failed to read {:?}", path));

    serde_json::from_str::<Protocol>(&data)
        .unwrap_or_else(|_| panic!("Failed to parse {:?}", path))
}

fn ensure_dir(path: &Path) {
    fs::create_dir_all(path).unwrap();
}

fn rust_type(json_type: &str) -> String {
    match json_type {
        "string" => "String".into(),
        "number" => "f64".into(),
        "boolean" => "bool".into(),
        x if x.starts_with("array<") => {
            let inner = x.trim_start_matches("array<").trim_end_matches(">");
            format!("Vec<{}>", rust_type(inner))
        }
        "object" => "serde_json::Value".into(),
        _ => "String".into(),
    }
}

// ------------------------------------------------------------
// Enum generator
// ------------------------------------------------------------

fn gen_enum(namespace: &str, events: &HashMap<String, Event>) -> String {
    let mut out = String::new();
    out.push_str("#[derive(Debug, Clone)]\n");
    out.push_str(&format!("pub enum {}Event {{\n", pascal(namespace)));

    for ev in events.keys() {
        out.push_str(&format!("    {},\n", pascal(ev)));
    }

    out.push_str("}\n");
    out
}

// ------------------------------------------------------------
// Model generator (no warning version — _namespace unused)
// ------------------------------------------------------------

fn gen_models(_namespace: &str, events: &HashMap<String, Event>) -> String {
    let mut out = String::new();
    out.push_str("use serde::{Serialize, Deserialize};\n\n");

    for (ev_name, ev) in events {
        let struct_name = format!("{}Payload", pascal(ev_name));

        out.push_str("#[derive(Debug, Clone, Serialize, Deserialize)]\n");
        out.push_str(&format!("pub struct {} {{\n", struct_name));

        if ev.payload.is_empty() {
            out.push_str("    // no payload fields\n");
        } else {
            for (field, typ) in &ev.payload {
                let t = typ.as_str().unwrap();
                out.push_str(&format!("    pub {}: {},\n", field, rust_type(t)));
            }
        }

        out.push_str("}\n\n");
    }

    out
}

// ------------------------------------------------------------
// Utility
// ------------------------------------------------------------

fn pascal(s: &str) -> String {
    s.split('_')
        .map(|p| {
            let mut c = p.chars();
            match c.next() {
                None => String::new(),
                Some(f) => f.to_uppercase().collect::<String>() + c.as_str(),
            }
        })
        .collect()
}

// ------------------------------------------------------------
// Main
// ------------------------------------------------------------

fn main() {
    let root = repo_root();
    println!("📁 Repo root = {:?}", root);

    let protocol = load_protocol(&root);

    let out_dir = root.join("protocol/out/rust/mtv_protocol");
    ensure_dir(&out_dir);

    for (ns, namespace) in &protocol.namespaces {
        let enum_code = gen_enum(ns, &namespace.events);
        let models_code = gen_models(ns, &namespace.events);

        fs::write(out_dir.join(format!("{}Events.rs", pascal(ns))), enum_code).unwrap();
        fs::write(out_dir.join(format!("{}Models.rs", pascal(ns))), models_code).unwrap();
    }

    println!("🎉 Rust protocol code generated at {:?}", out_dir);
}

