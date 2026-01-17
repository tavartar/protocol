package event

import "mtv_protocol/models"

var EVENT_REGISTRY = map[string]func() any{
    "edge:__placeholder__": func() any { return &models.PlaceholderPayload{} },
    "frontend:__placeholder__": func() any { return &models.PlaceholderPayload{} },
    "backend:__placeholder__": func() any { return &models.PlaceholderPayload{} },
}
