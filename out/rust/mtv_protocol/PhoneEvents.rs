#[derive(Debug, Clone)]
pub enum PhoneEvent {
    PhoneJoinRejected,
    PhoneJoinRoom,
    PhoneRequestLeader,
    PhonePing,
    PhoneSingerReady,
    PhoneRoleAssigned,
    PhoneDisconnect,
    PhoneLeaderTransferred,
    PhoneSubmitChoice,
    PhoneSubmitVote,
    PhoneJoinApproved,
}
