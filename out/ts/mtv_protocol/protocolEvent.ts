import { z } from "zod";
import { EVENT_MODELS } from "./registry";

export const ProtocolEvent = z.object({
  namespace: z.string(),
  event: z.string(),
  direction: z.string(),
  phase: z.string(),
  payload: z.record(z.any())
});

export type ProtocolEvent = z.infer<typeof ProtocolEvent>;

export function parsePayload(evt: ProtocolEvent) {
  const key = `${evt.namespace}::${evt.event}`;
  const schema = EVENT_MODELS[key];
  if (!schema) return null;
  return schema.parse(evt.payload);
}
