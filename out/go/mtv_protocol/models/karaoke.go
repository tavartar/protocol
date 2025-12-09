package models

type _ = any

// karaoke_song_resumed payload
type KaraokeSongResumedPayload struct {
    Empty bool `json:"empty"`
}

// karaoke_song_completed payload
type KaraokeSongCompletedPayload struct {
    SongId string `json:"song_id"`
}

// karaoke_queue_updated payload
type KaraokeQueueUpdatedPayload struct {
    Queue []map[string]any `json:"queue"`
}

// karaoke_lyric_timeline payload
type KaraokeLyricTimelinePayload struct {
    Timestamp float64 `json:"timestamp"`
    Lyric string `json:"lyric"`
}

// karaoke_scoring_update payload
type KaraokeScoringUpdatePayload struct {
    PitchAccuracy float64 `json:"pitch_accuracy"`
    TimingAccuracy float64 `json:"timing_accuracy"`
    Section string `json:"section"`
    Score float64 `json:"score"`
}

// karaoke_song_selected payload
type KaraokeSongSelectedPayload struct {
    SongId string `json:"song_id"`
    Title string `json:"title"`
    Artist string `json:"artist"`
    Duration float64 `json:"duration"`
}

// karaoke_song_started payload
type KaraokeSongStartedPayload struct {
    SongId string `json:"song_id"`
}

// karaoke_song_paused payload
type KaraokeSongPausedPayload struct {
    Empty bool `json:"empty"`
}

