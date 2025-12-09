Here’s your **enhanced and summarized README** for the protocol system — based on what you’ve built and refined up to Phase II:

---

# 📡 `protocol` System — Unified Event Model for Multi-Modal Demos

The **protocol** defines a single shared event vocabulary for all frontends (Swift, JS) and backends (FastAPI, Django, LangChain) to communicate using structured WebSocket events.

---

## ✅ What the Protocol System Provides

| Layer                    | Purpose                                                     |
| ------------------------ | ----------------------------------------------------------- |
| `protocol.json`          | 📋 Defines all namespaces, events, directions, and payloads |
| `protocol.schema.json`   | 🔒 Enforces schema rules — validates shape and types        |
| Code Generators          | 🧬 Generate idiomatic models for Swift, TS, Python, Kotlin… |
| Central Validator        | ✅ Validates `protocol.json` before generating any code      |
| Generated Enums + Models | 📦 Used across FE/BE to guarantee consistent behavior       |

---

## 📦 Contents of `protocol.json`

| Field       | Meaning                                                                |
| ----------- | ---------------------------------------------------------------------- |
| `namespace` | Logical domain (e.g. `system`, `karaoke`, `bccc`, `phone`)             |
| `event`     | Named trigger (e.g. `karaoke_song_registered`, `system_phase_changed`) |
| `direction` | Which side initiated the event (`client→server`, `server→client`)      |
| `phase`     | Session phase (`pre_session`, `in_session`, `post_session`, `meta`, …) |
| `payload`   | Structured fields using primitive types                                |

---

## 🧠 Why This Approach Works

✅ **One canonical protocol dialect** shared across all:

* 📱 Swift clients (iOS)
* 🌐 React / TS clients (future)
* 🧠 LangChain agents (session controller)
* 🐍 Python / FastAPI / Django backends

✅ Allows **flexible orchestration** — new phases, new modes, AI agents — with no per-language rewrites.

✅ Eliminates drift by using **codegen from validated schema**.

---

## 🛠 Codegen and Enforcement

| Task       | Tool/Script                                 |
| ---------- | ------------------------------------------- |
| Validate   | `python tools/validate.py` (or Node, AJV)   |
| Generate   | `generate_swift.swift`, `generate_py.py`, … |
| Use models | Swift: `ProtocolEvent`, enums, payloads     |
| Add events | Edit `protocol.json` → re-validate → re-gen |

---

## ✅ What You’ve Implemented So Far

* Phase I: Pre-session support for Karaoke and Bầu Cua
* Phase II: In-session scaffolds, live sockets, payload dispatch
* Unified front-end state (`ViewModel.swift`, `ContentView.swift`)
* Role and mode-specific views (Leader vs. Member)
* Typed event handling end-to-end (send + receive)

---

## 🔜 What's Next (Phase III)

* Feedback, scoring, results — modeled as new protocol events
* Session lifecycle orchestration (e.g. via `system_phase_changed`)
* Archive/replay support (if needed)
* UI polish and runtime orchestration hooks

---

## ✨ Best Practices

* Only modify `protocol.json`
* Validate before generating code
* Avoid `.env`/hardcoded routes for events
* Think declaratively: define what the system should do, not how

---

Let me know if you’d like me to generate:

* ✅ `validate.py` (universal JSON validator)
* ✅ `HOWTO: Add Events`
* ✅ `protocol.schema.json` v2 for future event types
* ✅ GitHub Action to auto-check protocol consistency

Just say: `"Generate HOWTO"` or `"Generate validator"` etc.

Here’s a concise yet complete **`HOWTO: Add Events to the Protocol System`** — tailored to your architecture:

---

# 🛠 HOWTO: Add Events to `protocol.json`

This guide shows how to safely add new events and regenerate your FE/BE code from `protocol.json`.

---

## 🔁 Step 1: Open `protocol.json`

Located at:

```bash
/your_repo_root/protocol/protocol.json
```

Use a JSON-aware editor (VS Code, IntelliJ, etc.) for syntax safety.

---

## 🧱 Step 2: Find the Correct `namespace`

Each event belongs in a **namespace**, such as:

* `"system"` — global events (phase control, error, heartbeat)
* `"phone"` — device/user identity events
* `"karaoke"` — music flow: song registration, scoring
* `"bccc"` — Bầu Cua setup, bets, results

If a namespace doesn’t exist, define it like:

```json
"mygame": {
  "description": "Mini-game session control",
  "events": {
    ...
  }
}
```

---

## ➕ Step 3: Add New Event Definition

Each event block has:

| Field       | Example                                              |
| ----------- | ---------------------------------------------------- |
| `event`     | `"karaoke_song_registered"`                          |
| `direction` | `"client→server"`                                    |
| `phase`     | `"pre_session"`                                      |
| `payload`   | Schema with `"string"`, `"number"`, `"boolean"` etc. |

Example:

```json
"karaoke_song_registered": {
  "direction": "client→server",
  "phase": "pre_session",
  "description": "A user registers a song for karaoke before the session begins.",
  "payload": {
    "user_id": "string",
    "song_title": "string",
    "youtube_id": "string?",
    "tone": "string",
    "producer": "string"
  }
}
```

Notes:

* Use `string?` to indicate **optional** fields.
* Use **snake_case** for all keys.
* Set `direction` as `client→server` or `server→client`.

---

## ✅ Step 4: Validate

Use a validator script:

```bash
python validate.py protocol.json protocol.schema.json
```

Or a JSON Schema validator (e.g. [AJV](https://ajv.js.org/)).

This checks:

* Required fields present
* Valid types (`string`, `number`, etc.)
* No duplicates or typos

---

## 🧬 Step 5: Generate Code

From `/protocol/codegen`, run:

```bash
swift generate_swift.swift      # For iOS
python generate_py.py           # For Python BE
js generate_ts.js               # For TS (if used)
```

This outputs updated:

* `ProtocolEvent.swift` (Swift)
* `ProtocolEvent.ts` (TypeScript)
* `protocol_models.py` (Python)

---

## 📲 Step 6: Use New Event

In Swift FE:

```swift
let payload = karaoke_song_registeredPayload(
    user_id: "abc",
    song_title: "My Song",
    youtube_id: "xyz123",
    tone: "Male",
    producer: "John"
)

let event = ProtocolEvent(
    namespace: "karaoke",
    event: KaraokeEvent.karaoke_song_registered.rawValue,
    direction: "c→s",
    phase: "pre_session",
    payload: try! AnyCodable(payload)
)
```

Then send with `ws?.send(data: ...)`.

---

## 🧠 Best Practices

* Keep payloads flat (no nested JSON unless necessary)
* Always validate before codegen
* Use `description` in each event for docs
* Don’t hardcode strings — use generated enums

---

Let me know if you want this added to a `/docs/` folder as `HOWTO_add_protocol_events.md`.

