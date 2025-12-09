import { z } from "zod";

// Payload models for namespace: bccc

export const bccc_session_setupPayload = z.object({
  session_name: z.string(),
  min_bet: z.number(),
  max_bet: z.number(),
  rounds: z.number(),
  currency: z.string(),
});

export const bccc_session_configuredPayload = z.object({
  session_name: z.string(),
  min_bet: z.number(),
  max_bet: z.number(),
  rounds: z.number(),
  currency: z.string(),
  host_id: z.string(),
});

export const bccc_challenge_startedPayload = z.object({
  challenge_id: z.string(),
});

export const bccc_challenge_endedPayload = z.object({
});

export const bccc_vote_openedPayload = z.object({
  vote_id: z.string(),
});

export const bccc_vote_closedPayload = z.object({
  vote_id: z.string(),
});

export const bccc_vote_resultsPayload = z.object({
  vote_id: z.string(),
  results: z.record(z.any()),
});

export const bccc_prompt_sentPayload = z.object({
  prompt_id: z.string(),
  text: z.string(),
  duration: z.number(),
});

export const bccc_user_responsePayload = z.object({
  prompt_id: z.string(),
  user_id: z.string(),
  response_text: z.string(),
});

export const bccc_ai_judgementPayload = z.object({
  prompt_id: z.string(),
  score: z.number(),
  explanation: z.string(),
});

export const bccc_round_resultPayload = z.object({
  round_number: z.number(),
  symbol_results: z.array(z.string()),
  payouts: z.array(z.record(z.any())),
});

