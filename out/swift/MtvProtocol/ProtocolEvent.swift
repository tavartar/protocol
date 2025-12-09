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