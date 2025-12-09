// Models for namespace: system

export function system_group_registeredPayload() {
  return {
    group_id: null, // type: string
    group_name: null, // type: string
  };
}

export function system_phase_changedPayload() {
  return {
    session_id: null, // type: string
    phase: null, // type: string
  };
}

export function system_heartbeatPayload() {
  return {
  };
}

export function system_errorPayload() {
  return {
    message: null, // type: string
    code: null, // type: string
  };
}

export function system_state_updatePayload() {
  return {
    uptime: null, // type: number
    active_namespace: null, // type: string
    session_id: null, // type: string
  };
}

export function system_request_statusPayload() {
  return {
  };
}

export function system_response_statusPayload() {
  return {
    ok: null, // type: boolean
    message: null, // type: string
  };
}

export function system_session_closedPayload() {
  return {
  };
}

export function system_outro_messagePayload() {
  return {
    message: null, // type: string
  };
}
