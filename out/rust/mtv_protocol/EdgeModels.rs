use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgePairCodePayload {
    pub pair_code: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgeSessionStartedPayload {
    pub session_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgeMicAudioChunkPayload {
    pub base64_wav: String,
    pub singer_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgeReadyPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgeRenderUpdatePayload {
    pub payload: serde_json::Value,
    pub screen: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgeSessionEndedPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgeQrCodePayload {
    pub qr_svg: String,
}

