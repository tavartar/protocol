#[derive(Debug, Clone)]
pub enum EdgeEvent {
    EdgePairCode,
    EdgeSessionStarted,
    EdgeMicAudioChunk,
    EdgeReady,
    EdgeRenderUpdate,
    EdgeSessionEnded,
    EdgeQrCode,
}
