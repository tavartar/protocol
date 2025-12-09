package enums

type SystemEvent string

const (
    SYSTEM_SYSTEM_ERROR SystemEvent = "system_error"
    SYSTEM_SYSTEM_STATE_UPDATE SystemEvent = "system_state_update"
    SYSTEM_SYSTEM_REQUEST_STATUS SystemEvent = "system_request_status"
    SYSTEM_SYSTEM_RESPONSE_STATUS SystemEvent = "system_response_status"
    SYSTEM_SYSTEM_SESSION_CLOSED SystemEvent = "system_session_closed"
    SYSTEM_SYSTEM_HEARTBEAT SystemEvent = "system_heartbeat"
)
