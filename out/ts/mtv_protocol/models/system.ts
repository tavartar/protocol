import { z } from "zod";

// Payload models for namespace: system

export const system_group_registeredPayload = z.object({
  group_id: z.string(),
  group_name: z.string(),
});

export const system_phase_changedPayload = z.object({
  session_id: z.string(),
  phase: z.string(),
});

export const system_heartbeatPayload = z.object({
});

export const system_errorPayload = z.object({
  message: z.string(),
  code: z.string(),
});

export const system_state_updatePayload = z.object({
  uptime: z.number(),
  active_namespace: z.string(),
  session_id: z.string(),
});

export const system_request_statusPayload = z.object({
});

export const system_response_statusPayload = z.object({
  ok: z.boolean(),
  message: z.string(),
});

export const system_session_closedPayload = z.object({
});

export const system_outro_messagePayload = z.object({
  message: z.string(),
});

