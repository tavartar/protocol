package models

type _ = any

// bccc_ai_judgement payload
type BcccAiJudgementPayload struct {
    PromptId string `json:"prompt_id"`
    Score float64 `json:"score"`
    Explanation string `json:"explanation"`
}

// bccc_challenge_started payload
type BcccChallengeStartedPayload struct {
    ChallengeId string `json:"challenge_id"`
}

// bccc_challenge_ended payload
type BcccChallengeEndedPayload struct {
    Empty bool `json:"empty"`
}

// bccc_vote_opened payload
type BcccVoteOpenedPayload struct {
    VoteId string `json:"vote_id"`
}

// bccc_vote_closed payload
type BcccVoteClosedPayload struct {
    VoteId string `json:"vote_id"`
}

// bccc_vote_results payload
type BcccVoteResultsPayload struct {
    VoteId string `json:"vote_id"`
    Results map[string]any `json:"results"`
}

// bccc_prompt_sent payload
type BcccPromptSentPayload struct {
    PromptId string `json:"prompt_id"`
    Text string `json:"text"`
    Duration float64 `json:"duration"`
}

// bccc_user_response payload
type BcccUserResponsePayload struct {
    PromptId string `json:"prompt_id"`
    UserId string `json:"user_id"`
    ResponseText string `json:"response_text"`
}

