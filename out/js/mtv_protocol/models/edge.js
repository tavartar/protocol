// Models for namespace: edge

export function edge_readyPayload() {
  return {
  };
}

export function edge_pair_codePayload() {
  return {
    pair_code: null, // type: string
  };
}

export function edge_qr_codePayload() {
  return {
    qr_svg: null, // type: string
  };
}

export function edge_session_startedPayload() {
  return {
    session_id: null, // type: string
  };
}

export function edge_session_endedPayload() {
  return {
  };
}

export function edge_render_updatePayload() {
  return {
    screen: null, // type: string
    payload: null, // type: object
  };
}

export function edge_mic_audio_chunkPayload() {
  return {
    singer_id: null, // type: string
    base64_wav: null, // type: string
  };
}
