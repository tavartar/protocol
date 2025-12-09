import { z } from "zod";

// Payload models for namespace: edge

export const edge_readyPayload = z.object({
});

export const edge_pair_codePayload = z.object({
  pair_code: z.string(),
});

export const edge_qr_codePayload = z.object({
  qr_svg: z.string(),
});

export const edge_session_startedPayload = z.object({
  session_id: z.string(),
});

export const edge_session_endedPayload = z.object({
});

export const edge_render_updatePayload = z.object({
  screen: z.string(),
  payload: z.record(z.any()),
});

export const edge_mic_audio_chunkPayload = z.object({
  singer_id: z.string(),
  base64_wav: z.string(),
});

