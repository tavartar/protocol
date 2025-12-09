package enums

type KaraokeEvent string

const (
    KARAOKE_KARAOKE_LYRIC_TIMELINE KaraokeEvent = "karaoke_lyric_timeline"
    KARAOKE_KARAOKE_SCORING_UPDATE KaraokeEvent = "karaoke_scoring_update"
    KARAOKE_KARAOKE_SONG_SELECTED KaraokeEvent = "karaoke_song_selected"
    KARAOKE_KARAOKE_SONG_STARTED KaraokeEvent = "karaoke_song_started"
    KARAOKE_KARAOKE_SONG_PAUSED KaraokeEvent = "karaoke_song_paused"
    KARAOKE_KARAOKE_SONG_RESUMED KaraokeEvent = "karaoke_song_resumed"
    KARAOKE_KARAOKE_SONG_COMPLETED KaraokeEvent = "karaoke_song_completed"
    KARAOKE_KARAOKE_QUEUE_UPDATED KaraokeEvent = "karaoke_queue_updated"
)
