from pydantic import BaseModel

# Payload Models for namespace: karaoke

class karaoke_song_registeredPayload(BaseModel):
    user_id: str
    member_name: str
    song_title: str
    youtube_id: str
    tone: str
    producer: str

class karaoke_song_registration_acceptedPayload(BaseModel):
    song_id: str
    member_name: str
    song_title: str
    queue_position: float

class karaoke_song_selectedPayload(BaseModel):
    song_id: str
    title: str
    artist: str
    duration: float

class karaoke_song_startedPayload(BaseModel):
    song_id: str

class karaoke_song_pausedPayload(BaseModel):
    pass

class karaoke_song_resumedPayload(BaseModel):
    pass

class karaoke_song_completedPayload(BaseModel):
    song_id: str

class karaoke_queue_updatedPayload(BaseModel):
    queue: list[dict]

class karaoke_lyric_timelinePayload(BaseModel):
    timestamp: float
    lyric: str

class karaoke_scoring_updatePayload(BaseModel):
    score: float
    pitch_accuracy: float
    timing_accuracy: float
    section: str

class karaoke_performance_scoredPayload(BaseModel):
    user_id: str
    song_id: str
    score: float
    comments: str
