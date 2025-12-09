package enums

type BcccEvent string

const (
    BCCC_BCCC_VOTE_CLOSED BcccEvent = "bccc_vote_closed"
    BCCC_BCCC_VOTE_RESULTS BcccEvent = "bccc_vote_results"
    BCCC_BCCC_PROMPT_SENT BcccEvent = "bccc_prompt_sent"
    BCCC_BCCC_USER_RESPONSE BcccEvent = "bccc_user_response"
    BCCC_BCCC_AI_JUDGEMENT BcccEvent = "bccc_ai_judgement"
    BCCC_BCCC_CHALLENGE_STARTED BcccEvent = "bccc_challenge_started"
    BCCC_BCCC_CHALLENGE_ENDED BcccEvent = "bccc_challenge_ended"
    BCCC_BCCC_VOTE_OPENED BcccEvent = "bccc_vote_opened"
)
