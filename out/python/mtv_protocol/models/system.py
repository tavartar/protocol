from pydantic import BaseModel

# Payload Models for namespace: system

class system_group_registeredPayload(BaseModel):
    group_id: str
    group_name: str

class system_phase_changedPayload(BaseModel):
    session_id: str
    phase: str

class system_heartbeatPayload(BaseModel):
    pass

class system_errorPayload(BaseModel):
    message: str
    code: str

class system_state_updatePayload(BaseModel):
    uptime: float
    active_namespace: str
    session_id: str

class system_request_statusPayload(BaseModel):
    pass

class system_response_statusPayload(BaseModel):
    ok: bool
    message: str

class system_session_closedPayload(BaseModel):
    pass

class system_outro_messagePayload(BaseModel):
    message: str
