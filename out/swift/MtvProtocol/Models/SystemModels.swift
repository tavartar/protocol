/// Auto-generated models — Namespace: system
import Foundation
public struct system_group_registeredPayload: Codable {
    public let group_id: String
    public let group_name: String
}

public struct system_response_statusPayload: Codable {
    public let message: String
    public let ok: Bool
}

public struct system_state_updatePayload: Codable {
    public let active_namespace: String
    public let session_id: String
    public let uptime: Double
}

public struct system_request_statusPayload: Codable {
    // No fields
}

public struct system_session_closedPayload: Codable {
    // No fields
}

public struct system_phase_changedPayload: Codable {
    public let session_id: String
    public let phase: String
}

public struct system_outro_messagePayload: Codable {
    public let message: String
}

public struct system_errorPayload: Codable {
    public let message: String
    public let code: String
}

public struct system_heartbeatPayload: Codable {
    // No fields
}

