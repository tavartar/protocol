from enum import Enum

class KaraokeEvent(str, Enum):
    karaoke_song_registered = "karaoke_song_registered"
    karaoke_song_registration_accepted = "karaoke_song_registration_accepted"
    karaoke_song_selected = "karaoke_song_selected"
    karaoke_song_started = "karaoke_song_started"
    karaoke_song_paused = "karaoke_song_paused"
    karaoke_song_resumed = "karaoke_song_resumed"
    karaoke_song_completed = "karaoke_song_completed"
    karaoke_queue_updated = "karaoke_queue_updated"
    karaoke_lyric_timeline = "karaoke_lyric_timeline"
    karaoke_scoring_update = "karaoke_scoring_update"
    karaoke_performance_scored = "karaoke_performance_scored"
