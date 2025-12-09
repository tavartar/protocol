use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BcccAiJudgementPayload {
    pub explanation: String,
    pub prompt_id: String,
    pub score: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BcccUserResponsePayload {
    pub prompt_id: String,
    pub response_text: String,
    pub user_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BcccChallengeEndedPayload {
    // no payload fields
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BcccPromptSentPayload {
    pub duration: f64,
    pub prompt_id: String,
    pub text: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BcccVoteClosedPayload {
    pub vote_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BcccVoteOpenedPayload {
    pub vote_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BcccVoteResultsPayload {
    pub results: serde_json::Value,
    pub vote_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BcccChallengeStartedPayload {
    pub challenge_id: String,
}

