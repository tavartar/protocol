/// Auto-generated models — Namespace: karaoke
import Foundation
public struct karaoke_song_selectedPayload: Codable {
    public let artist: String
    public let title: String
    public let song_id: String
    public let duration: Double
}

public struct karaoke_lyric_timelinePayload: Codable {
    public let lyric: String
    public let timestamp: Double
}

public struct karaoke_performance_scoredPayload: Codable {
    public let comments: String
    public let user_id: String
    public let song_id: String
    public let score: Double
}

public struct karaoke_song_startedPayload: Codable {
    public let song_id: String
}

public struct karaoke_song_pausedPayload: Codable {
    // No fields
}

public struct karaoke_song_completedPayload: Codable {
    public let song_id: String
}

public struct karaoke_song_registration_acceptedPayload: Codable {
    public let queue_position: Double
    public let song_title: String
    public let member_name: String
    public let song_id: String
}

public struct karaoke_song_registeredPayload: Codable {
    public let song_title: String
    public let youtube_id: String
    public let member_name: String
    public let user_id: String
    public let tone: String
    public let producer: String
}

public struct karaoke_queue_updatedPayload: Codable {
    public let queue: [[String: AnyCodable]]
}

public struct karaoke_scoring_updatePayload: Codable {
    public let section: String
    public let timing_accuracy: Double
    public let pitch_accuracy: Double
    public let score: Double
}

public struct karaoke_song_resumedPayload: Codable {
    // No fields
}

