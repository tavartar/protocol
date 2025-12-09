// Models for namespace: karaoke

export function karaoke_song_registeredPayload() {
  return {
    user_id: null, // type: string
    member_name: null, // type: string
    song_title: null, // type: string
    youtube_id: null, // type: string
    tone: null, // type: string
    producer: null, // type: string
  };
}

export function karaoke_song_registration_acceptedPayload() {
  return {
    song_id: null, // type: string
    member_name: null, // type: string
    song_title: null, // type: string
    queue_position: null, // type: number
  };
}

export function karaoke_song_selectedPayload() {
  return {
    song_id: null, // type: string
    title: null, // type: string
    artist: null, // type: string
    duration: null, // type: number
  };
}

export function karaoke_song_startedPayload() {
  return {
    song_id: null, // type: string
  };
}

export function karaoke_song_pausedPayload() {
  return {
  };
}

export function karaoke_song_resumedPayload() {
  return {
  };
}

export function karaoke_song_completedPayload() {
  return {
    song_id: null, // type: string
  };
}

export function karaoke_queue_updatedPayload() {
  return {
    queue: null, // type: array<object>
  };
}

export function karaoke_lyric_timelinePayload() {
  return {
    timestamp: null, // type: number
    lyric: null, // type: string
  };
}

export function karaoke_scoring_updatePayload() {
  return {
    score: null, // type: number
    pitch_accuracy: null, // type: number
    timing_accuracy: null, // type: number
    section: null, // type: string
  };
}

export function karaoke_performance_scoredPayload() {
  return {
    user_id: null, // type: string
    song_id: null, // type: string
    score: null, // type: number
    comments: null, // type: string
  };
}
