from typing import Dict, Tuple, Type
from pydantic import BaseModel

from .models.edge import __placeholder__Payload
from .models.frontend import __placeholder__Payload
from .models.backend import __placeholder__Payload

EVENT_MODELS: Dict[Tuple[str, str], Type[BaseModel]] = {}

EVENT_MODELS[("edge", "__placeholder__")] = __placeholder__Payload
EVENT_MODELS[("frontend", "__placeholder__")] = __placeholder__Payload
EVENT_MODELS[("backend", "__placeholder__")] = __placeholder__Payload