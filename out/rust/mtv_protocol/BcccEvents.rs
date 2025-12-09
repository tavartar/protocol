#[derive(Debug, Clone)]
pub enum BcccEvent {
    BcccAiJudgement,
    BcccUserResponse,
    BcccChallengeEnded,
    BcccPromptSent,
    BcccVoteClosed,
    BcccVoteOpened,
    BcccVoteResults,
    BcccChallengeStarted,
}
