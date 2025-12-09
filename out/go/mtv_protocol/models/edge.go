package models

type _ = any

// edge_qr_code payload
type EdgeQrCodePayload struct {
    QrSvg string `json:"qr_svg"`
}

// edge_session_started payload
type EdgeSessionStartedPayload struct {
    SessionId string `json:"session_id"`
}

// edge_session_ended payload
type EdgeSessionEndedPayload struct {
    Empty bool `json:"empty"`
}

// edge_render_update payload
type EdgeRenderUpdatePayload struct {
    Screen string `json:"screen"`
    Payload map[string]any `json:"payload"`
}

// edge_mic_audio_chunk payload
type EdgeMicAudioChunkPayload struct {
    Base64Wav string `json:"base64_wav"`
    SingerId string `json:"singer_id"`
}

// edge_ready payload
type EdgeReadyPayload struct {
    Empty bool `json:"empty"`
}

// edge_pair_code payload
type EdgePairCodePayload struct {
    PairCode string `json:"pair_code"`
}

