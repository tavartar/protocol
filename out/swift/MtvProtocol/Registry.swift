/// Auto-generated payload registry (v2.0)
import Foundation

public enum PayloadRegistry {
    public static func decode(namespace: String, event: String, payload: [String: Any]) -> Any? {
        switch (namespace, event) {
        case ("frontend", "__placeholder__"):
            return try? JSONDecoder().decode(
                __placeholder__Payload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("edge", "__placeholder__"):
            return try? JSONDecoder().decode(
                __placeholder__Payload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("backend", "__placeholder__"):
            return try? JSONDecoder().decode(
                __placeholder__Payload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        default:
            return nil
        }
    }
}