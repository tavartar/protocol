import { z } from "zod";
import * as edgeModels from "./models/edge";
import * as frontendModels from "./models/frontend";
import * as backendModels from "./models/backend";

export const EVENT_MODELS = {} as Record<string, z.ZodSchema>;

EVENT_MODELS["edge::__placeholder__"] = edgeModels.__placeholder__Payload;
EVENT_MODELS["frontend::__placeholder__"] = frontendModels.__placeholder__Payload;
EVENT_MODELS["backend::__placeholder__"] = backendModels.__placeholder__Payload;
