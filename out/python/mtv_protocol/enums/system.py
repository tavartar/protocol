from enum import Enum

class SystemEvent(str, Enum):
    system_group_registered = "system_group_registered"
    system_phase_changed = "system_phase_changed"
    system_heartbeat = "system_heartbeat"
    system_error = "system_error"
    system_state_update = "system_state_update"
    system_request_status = "system_request_status"
    system_response_status = "system_response_status"
    system_session_closed = "system_session_closed"
    system_outro_message = "system_outro_message"
