from pydantic import BaseModel

# Payload Models for namespace: edge

class edge_readyPayload(BaseModel):
    pass

class edge_pair_codePayload(BaseModel):
    pair_code: str

class edge_qr_codePayload(BaseModel):
    qr_svg: str

class edge_session_startedPayload(BaseModel):
    session_id: str

class edge_session_endedPayload(BaseModel):
    pass

class edge_render_updatePayload(BaseModel):
    screen: str
    payload: dict

class edge_mic_audio_chunkPayload(BaseModel):
    singer_id: str
    base64_wav: str
