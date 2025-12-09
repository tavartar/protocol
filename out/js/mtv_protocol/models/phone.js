// Models for namespace: phone

export function phone_user_registeredPayload() {
  return {
    user_id: null, // type: string
    user_name: null, // type: string
    group_id: null, // type: string
  };
}

export function phone_join_roomPayload() {
  return {
    room_code: null, // type: string
    device_id: null, // type: string
    user_name: null, // type: string
  };
}

export function phone_join_approvedPayload() {
  return {
    user_id: null, // type: string
  };
}

export function phone_join_rejectedPayload() {
  return {
    reason: null, // type: string
  };
}

export function phone_role_assignedPayload() {
  return {
    user_id: null, // type: string
    role: null, // type: string
  };
}

export function phone_request_leaderPayload() {
  return {
  };
}

export function phone_leader_transferredPayload() {
  return {
    from_user: null, // type: string
    to_user: null, // type: string
  };
}

export function phone_submit_votePayload() {
  return {
    vote_id: null, // type: string
    value: null, // type: string
  };
}

export function phone_submit_choicePayload() {
  return {
    choice: null, // type: string
  };
}

export function phone_singer_readyPayload() {
  return {
    user_id: null, // type: string
  };
}

export function phone_pingPayload() {
  return {
  };
}

export function phone_disconnectPayload() {
  return {
  };
}
