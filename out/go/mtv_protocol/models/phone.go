package models

type _ = any

// phone_role_assigned payload
type PhoneRoleAssignedPayload struct {
    UserId string `json:"user_id"`
    Role string `json:"role"`
}

// phone_request_leader payload
type PhoneRequestLeaderPayload struct {
    Empty bool `json:"empty"`
}

// phone_disconnect payload
type PhoneDisconnectPayload struct {
    Empty bool `json:"empty"`
}

// phone_join_rejected payload
type PhoneJoinRejectedPayload struct {
    Reason string `json:"reason"`
}

// phone_leader_transferred payload
type PhoneLeaderTransferredPayload struct {
    FromUser string `json:"from_user"`
    ToUser string `json:"to_user"`
}

// phone_submit_vote payload
type PhoneSubmitVotePayload struct {
    VoteId string `json:"vote_id"`
    Value string `json:"value"`
}

// phone_submit_choice payload
type PhoneSubmitChoicePayload struct {
    Choice string `json:"choice"`
}

// phone_singer_ready payload
type PhoneSingerReadyPayload struct {
    UserId string `json:"user_id"`
}

// phone_ping payload
type PhonePingPayload struct {
    Empty bool `json:"empty"`
}

// phone_join_room payload
type PhoneJoinRoomPayload struct {
    DeviceId string `json:"device_id"`
    UserName string `json:"user_name"`
    RoomCode string `json:"room_code"`
}

// phone_join_approved payload
type PhoneJoinApprovedPayload struct {
    UserId string `json:"user_id"`
}

