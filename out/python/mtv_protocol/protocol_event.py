from pydantic import BaseModel
from typing import Optional


class ProtocolEvent(BaseModel):
    namespace: str
    event: str
    payload: dict
    direction: str
    phase: str

    def model(self) -> Optional[BaseModel]:
        """Return the Pydantic model matching this event payload (if any)."""
        from .registry import EVENT_MODELS
        key = (self.namespace, self.event)
        Model = EVENT_MODELS.get(key)
        if Model:
            return Model(**self.payload)
        return None
