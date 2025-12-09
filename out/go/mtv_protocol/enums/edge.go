package enums

type EdgeEvent string

const (
    EDGE_EDGE_SESSION_ENDED EdgeEvent = "edge_session_ended"
    EDGE_EDGE_RENDER_UPDATE EdgeEvent = "edge_render_update"
    EDGE_EDGE_MIC_AUDIO_CHUNK EdgeEvent = "edge_mic_audio_chunk"
    EDGE_EDGE_READY EdgeEvent = "edge_ready"
    EDGE_EDGE_PAIR_CODE EdgeEvent = "edge_pair_code"
    EDGE_EDGE_QR_CODE EdgeEvent = "edge_qr_code"
    EDGE_EDGE_SESSION_STARTED EdgeEvent = "edge_session_started"
)
