import { z } from "zod";

// Payload models for namespace: phone

export const phone_user_registeredPayload = z.object({
  user_id: z.string(),
  user_name: z.string(),
  group_id: z.string(),
});

export const phone_join_roomPayload = z.object({
  room_code: z.string(),
  device_id: z.string(),
  user_name: z.string(),
});

export const phone_join_approvedPayload = z.object({
  user_id: z.string(),
});

export const phone_join_rejectedPayload = z.object({
  reason: z.string(),
});

export const phone_role_assignedPayload = z.object({
  user_id: z.string(),
  role: z.string(),
});

export const phone_request_leaderPayload = z.object({
});

export const phone_leader_transferredPayload = z.object({
  from_user: z.string(),
  to_user: z.string(),
});

export const phone_submit_votePayload = z.object({
  vote_id: z.string(),
  value: z.string(),
});

export const phone_submit_choicePayload = z.object({
  choice: z.string(),
});

export const phone_singer_readyPayload = z.object({
  user_id: z.string(),
});

export const phone_pingPayload = z.object({
});

export const phone_disconnectPayload = z.object({
});

