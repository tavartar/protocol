from pydantic import BaseModel

# Payload Models for namespace: phone

class phone_user_registeredPayload(BaseModel):
    user_id: str
    user_name: str
    group_id: str

class phone_join_roomPayload(BaseModel):
    room_code: str
    device_id: str
    user_name: str

class phone_join_approvedPayload(BaseModel):
    user_id: str

class phone_join_rejectedPayload(BaseModel):
    reason: str

class phone_role_assignedPayload(BaseModel):
    user_id: str
    role: str

class phone_request_leaderPayload(BaseModel):
    pass

class phone_leader_transferredPayload(BaseModel):
    from_user: str
    to_user: str

class phone_submit_votePayload(BaseModel):
    vote_id: str
    value: str

class phone_submit_choicePayload(BaseModel):
    choice: str

class phone_singer_readyPayload(BaseModel):
    user_id: str

class phone_pingPayload(BaseModel):
    pass

class phone_disconnectPayload(BaseModel):
    pass
