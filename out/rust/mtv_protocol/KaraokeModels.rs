use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KaraokeQueueUpdatedPayload {
    pub queue: Vec<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KaraokeSongPausedPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KaraokeLyricTimelinePayload {
    pub lyric: String,
    pub timestamp: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KaraokeSongSelectedPayload {
    pub artist: String,
    pub duration: f64,
    pub song_id: String,
    pub title: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KaraokeSongStartedPayload {
    pub song_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KaraokeSongResumedPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KaraokeSongCompletedPayload {
    pub song_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KaraokeScoringUpdatePayload {
    pub pitch_accuracy: f64,
    pub score: f64,
    pub section: String,
    pub timing_accuracy: f64,
}

