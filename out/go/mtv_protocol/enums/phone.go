package enums

type PhoneEvent string

const (
    PHONE_PHONE_PING PhoneEvent = "phone_ping"
    PHONE_PHONE_JOIN_ROOM PhoneEvent = "phone_join_room"
    PHONE_PHONE_JOIN_APPROVED PhoneEvent = "phone_join_approved"
    PHONE_PHONE_ROLE_ASSIGNED PhoneEvent = "phone_role_assigned"
    PHONE_PHONE_REQUEST_LEADER PhoneEvent = "phone_request_leader"
    PHONE_PHONE_DISCONNECT PhoneEvent = "phone_disconnect"
    PHONE_PHONE_JOIN_REJECTED PhoneEvent = "phone_join_rejected"
    PHONE_PHONE_LEADER_TRANSFERRED PhoneEvent = "phone_leader_transferred"
    PHONE_PHONE_SUBMIT_VOTE PhoneEvent = "phone_submit_vote"
    PHONE_PHONE_SUBMIT_CHOICE PhoneEvent = "phone_submit_choice"
    PHONE_PHONE_SINGER_READY PhoneEvent = "phone_singer_ready"
)
