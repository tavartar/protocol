// Models for namespace: bccc

export function bccc_session_setupPayload() {
  return {
    session_name: null, // type: string
    min_bet: null, // type: number
    max_bet: null, // type: number
    rounds: null, // type: number
    currency: null, // type: string
  };
}

export function bccc_session_configuredPayload() {
  return {
    session_name: null, // type: string
    min_bet: null, // type: number
    max_bet: null, // type: number
    rounds: null, // type: number
    currency: null, // type: string
    host_id: null, // type: string
  };
}

export function bccc_challenge_startedPayload() {
  return {
    challenge_id: null, // type: string
  };
}

export function bccc_challenge_endedPayload() {
  return {
  };
}

export function bccc_vote_openedPayload() {
  return {
    vote_id: null, // type: string
  };
}

export function bccc_vote_closedPayload() {
  return {
    vote_id: null, // type: string
  };
}

export function bccc_vote_resultsPayload() {
  return {
    vote_id: null, // type: string
    results: null, // type: object
  };
}

export function bccc_prompt_sentPayload() {
  return {
    prompt_id: null, // type: string
    text: null, // type: string
    duration: null, // type: number
  };
}

export function bccc_user_responsePayload() {
  return {
    prompt_id: null, // type: string
    user_id: null, // type: string
    response_text: null, // type: string
  };
}

export function bccc_ai_judgementPayload() {
  return {
    prompt_id: null, // type: string
    score: null, // type: number
    explanation: null, // type: string
  };
}

export function bccc_round_resultPayload() {
  return {
    round_number: null, // type: number
    symbol_results: null, // type: array<string>
    payouts: null, // type: array<object>
  };
}
