import { z } from "zod";

// Payload models for namespace: karaoke

export const karaoke_song_registeredPayload = z.object({
  user_id: z.string(),
  member_name: z.string(),
  song_title: z.string(),
  youtube_id: z.string(),
  tone: z.string(),
  producer: z.string(),
});

export const karaoke_song_registration_acceptedPayload = z.object({
  song_id: z.string(),
  member_name: z.string(),
  song_title: z.string(),
  queue_position: z.number(),
});

export const karaoke_song_selectedPayload = z.object({
  song_id: z.string(),
  title: z.string(),
  artist: z.string(),
  duration: z.number(),
});

export const karaoke_song_startedPayload = z.object({
  song_id: z.string(),
});

export const karaoke_song_pausedPayload = z.object({
});

export const karaoke_song_resumedPayload = z.object({
});

export const karaoke_song_completedPayload = z.object({
  song_id: z.string(),
});

export const karaoke_queue_updatedPayload = z.object({
  queue: z.array(z.record(z.any())),
});

export const karaoke_lyric_timelinePayload = z.object({
  timestamp: z.number(),
  lyric: z.string(),
});

export const karaoke_scoring_updatePayload = z.object({
  score: z.number(),
  pitch_accuracy: z.number(),
  timing_accuracy: z.number(),
  section: z.string(),
});

export const karaoke_performance_scoredPayload = z.object({
  user_id: z.string(),
  song_id: z.string(),
  score: z.number(),
  comments: z.string(),
});

