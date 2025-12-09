
export class ProtocolEvent {
  constructor({ namespace, event, payload, direction }) {
    this.namespace = namespace;
    this.event = event;
    this.payload = payload || {};
    this.direction = direction;
  }

  // convert to model instance
  model() {
    try {
      const { EVENT_MODELS } = require("./registry.js");
      const key = `${this.namespace}::${this.event}`;
      const ctor = EVENT_MODELS[key];
      return ctor ? ctor() : null;
    } catch {
      return null;
    }
  }
}
