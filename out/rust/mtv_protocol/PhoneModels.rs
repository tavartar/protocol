use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneJoinRejectedPayload {
    pub reason: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneJoinRoomPayload {
    pub device_id: String,
    pub room_code: String,
    pub user_name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneRequestLeaderPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhonePingPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneSingerReadyPayload {
    pub user_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneRoleAssignedPayload {
    pub role: String,
    pub user_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneDisconnectPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneLeaderTransferredPayload {
    pub from_user: String,
    pub to_user: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneSubmitChoicePayload {
    pub choice: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneSubmitVotePayload {
    pub value: String,
    pub vote_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhoneJoinApprovedPayload {
    pub user_id: String,
}

