package event

import (
	"encoding/json"
)

type ProtocolEvent struct {
	Namespace string         `json:"namespace"`
	Event     string         `json:"event"`
	Payload   map[string]any `json:"payload"`
	Direction string         `json:"direction"`
	Phase     string         `json:"phase"`
}

// Model maps event → typed payload struct
func (e *ProtocolEvent) Model() (any, error) {
	key := e.Namespace + ":" + e.Event
	ctor, ok := EVENT_REGISTRY[key]
	if !ok {
		return nil, nil
	}
	b, _ := json.Marshal(e.Payload)
	m := ctor()
	err := json.Unmarshal(b, m)
	return m, err
}
