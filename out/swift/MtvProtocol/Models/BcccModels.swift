/// Auto-generated models — Namespace: bccc
import Foundation
public struct bccc_session_setupPayload: Codable {
    public let max_bet: Double
    public let session_name: String
    public let rounds: Double
    public let currency: String
    public let min_bet: Double
}

public struct bccc_vote_closedPayload: Codable {
    public let vote_id: String
}

public struct bccc_user_responsePayload: Codable {
    public let prompt_id: String
    public let response_text: String
    public let user_id: String
}

public struct bccc_prompt_sentPayload: Codable {
    public let text: String
    public let prompt_id: String
    public let duration: Double
}

public struct bccc_challenge_endedPayload: Codable {
    // No fields
}

public struct bccc_round_resultPayload: Codable {
    public let payouts: [[String: AnyCodable]]
    public let symbol_results: [String]
    public let round_number: Double
}

public struct bccc_session_configuredPayload: Codable {
    public let max_bet: Double
    public let session_name: String
    public let host_id: String
    public let rounds: Double
    public let currency: String
    public let min_bet: Double
}

public struct bccc_ai_judgementPayload: Codable {
    public let prompt_id: String
    public let score: Double
    public let explanation: String
}

public struct bccc_vote_resultsPayload: Codable {
    public let vote_id: String
    public let results: [String: AnyCodable]
}

public struct bccc_vote_openedPayload: Codable {
    public let vote_id: String
}

public struct bccc_challenge_startedPayload: Codable {
    public let challenge_id: String
}

