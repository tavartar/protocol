use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SystemResponseStatusPayload {
    pub message: String,
    pub ok: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SystemStateUpdatePayload {
    pub active_namespace: String,
    pub session_id: String,
    pub uptime: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SystemHeartbeatPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SystemRequestStatusPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SystemErrorPayload {
    pub code: String,
    pub message: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SystemSessionClosedPayload {
    // no payload fields
}

