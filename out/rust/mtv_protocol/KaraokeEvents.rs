#[derive(Debug, Clone)]
pub enum KaraokeEvent {
    KaraokeQueueUpdated,
    KaraokeSongPaused,
    KaraokeLyricTimeline,
    KaraokeSongSelected,
    KaraokeSongStarted,
    KaraokeSongResumed,
    KaraokeSongCompleted,
    KaraokeScoringUpdate,
}
