#!/usr/bin/env swift

/**
 Swift Code Generator (Protocol v2.0)
 -----------------------------------
 Reads:
    mtv/protocol/protocol.json

 Generates:
    • Enums per namespace
    • Codable payload structs
    • ProtocolEvent wrapper (v2.0)
    • Payload Registry
    • Swift Package

 Output:
    mtv/protocol/out/swift/MtvProtocol/
*/

import Foundation

// ----------------------------------
// Resolve repo root
// ----------------------------------

let scriptURL = URL(fileURLWithPath: CommandLine.arguments[0])
let repoRoot = scriptURL
    .deletingLastPathComponent()   // codegen/
    .deletingLastPathComponent()   // protocol/
    .deletingLastPathComponent()   // mtv/

let protocolFile = repoRoot
    .appendingPathComponent("protocol")
    .appendingPathComponent("protocol.json")

let outRoot = repoRoot
    .appendingPathComponent("protocol/out/swift/MtvProtocol")

let enumsDir  = outRoot.appendingPathComponent("Enums")
let modelsDir = outRoot.appendingPathComponent("Models")

// ----------------------------------
// Helpers
// ----------------------------------

func ensureDir(_ url: URL) {
    try? FileManager.default.createDirectory(
        at: url,
        withIntermediateDirectories: true,
        attributes: nil
    )
}

// maps protocol v2.0 types → Swift
func swiftType(_ t: String) -> String {
    switch t {
    case "string": return "String"
    case "number": return "Double"
    case "boolean": return "Bool"
    case "object": return "[String: AnyCodable]"
    default:
        break
    }

    if t.starts(with: "array<") && t.hasSuffix(">") {
        let inner = String(t.dropFirst(6).dropLast(1))
        return "[\(swiftType(inner))]"
    }

    return "String"   // fallback
}

// ----------------------------------
// Load protocol.json
// ----------------------------------

let raw = try Data(contentsOf: protocolFile)
guard let protocolJSON = try JSONSerialization.jsonObject(with: raw) as? [String: Any] else {
    fatalError("protocol.json is not valid JSON")
}

guard let namespaces = protocolJSON["namespaces"] as? [String: Any] else {
    fatalError("protocol.json missing .namespaces")
}

// ----------------------------------
// Create directories
// ----------------------------------

ensureDir(outRoot)
ensureDir(enumsDir)
ensureDir(modelsDir)

// ----------------------------------
// Iterate namespaces
// ----------------------------------

for (ns, nsValueAny) in namespaces {
    guard let nsValue = nsValueAny as? [String: Any] else { continue }
    guard let events = nsValue["events"] as? [String: Any] else { continue }

    // -----------------------------
    // Generate ENUM
    // -----------------------------
    var enumSrc = """
    /// Auto-generated — Namespace: \(ns)
    public enum \(ns.capitalized)Event: String, Codable, CaseIterable {
    """

    for evt in events.keys.sorted() {
        enumSrc += "\n    case \(evt) = \"\(evt)\""
    }
    enumSrc += "\n}\n"

    let enumFile = enumsDir.appendingPathComponent("\(ns.capitalized)Event.swift")
    try enumSrc.write(to: enumFile, atomically: true, encoding: .utf8)


    // -----------------------------
    // Generate Payload Models
    // -----------------------------
    var modelSrc = """
    /// Auto-generated models — Namespace: \(ns)
    import Foundation

    """

    for (evt, evtDataAny) in events {
        guard let evtData = evtDataAny as? [String: Any] else { continue }
        let payload = evtData["payload"] as? [String: String] ?? [:]

        modelSrc += "public struct \(evt)Payload: Codable {\n"

        if payload.isEmpty {
            modelSrc += "    // No fields\n"
        } else {
            for (field, t) in payload {
                modelSrc += "    public let \(field): \(swiftType(t))\n"
            }
        }
        modelSrc += "}\n\n"
    }

    let modelFile = modelsDir.appendingPathComponent("\(ns.capitalized)Models.swift")
    try modelSrc.write(to: modelFile, atomically: true, encoding: .utf8)
}

// ----------------------------------
// Write ProtocolEvent.swift
// ----------------------------------

let protoEventSrc = """
/// Auto-generated ProtocolEvent (v2.0)
import Foundation

public struct ProtocolEvent: Codable {
    public let namespace: String
    public let event: String
    public let direction: String
    public let phase: String
    public let payload: [String: AnyCodable]

    enum CodingKeys: String, CodingKey {
        case namespace, event, direction, phase, payload
    }
}

/// Codable wrapper supporting arbitrary JSON
public struct AnyCodable: Codable {
    public let value: Any

    public init(_ value: Any) { self.value = value }

    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()

        if let v = try? c.decode(String.self) { value = v; return }
        if let v = try? c.decode(Double.self) { value = v; return }
        if let v = try? c.decode(Bool.self) { value = v; return }
        if let v = try? c.decode([String: AnyCodable].self) { value = v; return }
        if let v = try? c.decode([AnyCodable].self) { value = v; return }

        value = ""
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        switch value {
        case let v as String: try c.encode(v)
        case let v as Double: try c.encode(v)
        case let v as Bool: try c.encode(v)
        case let v as [String: AnyCodable]: try c.encode(v)
        case let v as [AnyCodable]: try c.encode(v)
        default: try c.encodeNil()
        }
    }
}
"""

try protoEventSrc.write(
    to: outRoot.appendingPathComponent("ProtocolEvent.swift"),
    atomically: true,
    encoding: .utf8
)

// ----------------------------------
// Registry.swift
// ----------------------------------

var reg = """
/// Auto-generated payload registry (v2.0)
import Foundation

public enum PayloadRegistry {
    public static func decode(namespace: String, event: String, payload: [String: Any]) -> Any? {
        switch (namespace, event) {

"""

for (ns, nsValueAny) in namespaces {
    guard let nsValue = nsValueAny as? [String: Any] else { continue }
    guard let events = nsValue["events"] as? [String: Any] else { continue }

    for (evt, evtDataAny) in events {
        let evtData = evtDataAny as! [String: Any]
        let payloadFields = evtData["payload"] as? [String: String] ?? [:]

        reg += "        case (\"\(ns)\", \"\(evt)\"):\n"

        if payloadFields.isEmpty {
            reg += "            return \(evt)Payload()\n"
        } else {
            reg += """
                        return try? JSONDecoder().decode(
                            \(evt)Payload.self,
                            from: JSONSerialization.data(withJSONObject: payload)
                        )

            """
        }
    }
}

reg += """
        default:
            return nil
        }
    }
}
"""

try reg.write(
    to: outRoot.appendingPathComponent("Registry.swift"),
    atomically: true,
    encoding: .utf8
)

// ----------------------------------
// Package.swift
// ----------------------------------

let pkg = """
// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "MtvProtocol",
    products: [
        .library(name: "MtvProtocol", targets: ["MtvProtocol"]),
    ],
    targets: [
        .target(name: "MtvProtocol"),
    ]
)
"""

try pkg.write(
    to: outRoot.appendingPathComponent("Package.swift"),
    atomically: true,
    encoding: .utf8
)

print("✅ [swift-codegen] Output:", outRoot.path)

