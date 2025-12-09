package models

type _ = any

// system_response_status payload
type SystemResponseStatusPayload struct {
    Ok bool `json:"ok"`
    Message string `json:"message"`
}

// system_session_closed payload
type SystemSessionClosedPayload struct {
    Empty bool `json:"empty"`
}

// system_heartbeat payload
type SystemHeartbeatPayload struct {
    Empty bool `json:"empty"`
}

// system_error payload
type SystemErrorPayload struct {
    Code string `json:"code"`
    Message string `json:"message"`
}

// system_state_update payload
type SystemStateUpdatePayload struct {
    SessionId string `json:"session_id"`
    Uptime float64 `json:"uptime"`
    ActiveNamespace string `json:"active_namespace"`
}

// system_request_status payload
type SystemRequestStatusPayload struct {
    Empty bool `json:"empty"`
}

