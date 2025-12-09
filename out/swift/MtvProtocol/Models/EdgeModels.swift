/// Auto-generated models — Namespace: edge
import Foundation
public struct edge_session_startedPayload: Codable {
    public let session_id: String
}

public struct edge_readyPayload: Codable {
    // No fields
}

public struct edge_mic_audio_chunkPayload: Codable {
    public let singer_id: String
    public let base64_wav: String
}

public struct edge_qr_codePayload: Codable {
    public let qr_svg: String
}

public struct edge_session_endedPayload: Codable {
    // No fields
}

public struct edge_pair_codePayload: Codable {
    public let pair_code: String
}

public struct edge_render_updatePayload: Codable {
    public let screen: String
    public let payload: [String: AnyCodable]
}

