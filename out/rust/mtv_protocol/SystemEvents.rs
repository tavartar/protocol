#[derive(Debug, Clone)]
pub enum SystemEvent {
    SystemResponseStatus,
    SystemStateUpdate,
    SystemHeartbeat,
    SystemRequestStatus,
    SystemError,
    SystemSessionClosed,
}
