from pydantic import BaseModel

# Payload Models for namespace: bccc

class bccc_session_setupPayload(BaseModel):
    session_name: str
    min_bet: float
    max_bet: float
    rounds: float
    currency: str

class bccc_session_configuredPayload(BaseModel):
    session_name: str
    min_bet: float
    max_bet: float
    rounds: float
    currency: str
    host_id: str

class bccc_challenge_startedPayload(BaseModel):
    challenge_id: str

class bccc_challenge_endedPayload(BaseModel):
    pass

class bccc_vote_openedPayload(BaseModel):
    vote_id: str

class bccc_vote_closedPayload(BaseModel):
    vote_id: str

class bccc_vote_resultsPayload(BaseModel):
    vote_id: str
    results: dict

class bccc_prompt_sentPayload(BaseModel):
    prompt_id: str
    text: str
    duration: float

class bccc_user_responsePayload(BaseModel):
    prompt_id: str
    user_id: str
    response_text: str

class bccc_ai_judgementPayload(BaseModel):
    prompt_id: str
    score: float
    explanation: str

class bccc_round_resultPayload(BaseModel):
    round_number: float
    symbol_results: list[str]
    payouts: list[dict]
