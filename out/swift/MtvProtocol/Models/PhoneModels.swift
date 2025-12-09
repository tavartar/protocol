/// Auto-generated models — Namespace: phone
import Foundation
public struct phone_leader_transferredPayload: Codable {
    public let to_user: String
    public let from_user: String
}

public struct phone_request_leaderPayload: Codable {
    // No fields
}

public struct phone_disconnectPayload: Codable {
    // No fields
}

public struct phone_join_approvedPayload: Codable {
    public let user_id: String
}

public struct phone_join_rejectedPayload: Codable {
    public let reason: String
}

public struct phone_pingPayload: Codable {
    // No fields
}

public struct phone_role_assignedPayload: Codable {
    public let role: String
    public let user_id: String
}

public struct phone_submit_votePayload: Codable {
    public let value: String
    public let vote_id: String
}

public struct phone_submit_choicePayload: Codable {
    public let choice: String
}

public struct phone_singer_readyPayload: Codable {
    public let user_id: String
}

public struct phone_user_registeredPayload: Codable {
    public let group_id: String
    public let user_name: String
    public let user_id: String
}

public struct phone_join_roomPayload: Codable {
    public let device_id: String
    public let room_code: String
    public let user_name: String
}

