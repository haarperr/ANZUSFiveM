import { isEnvBrowser } from "./utils";

interface NuiMessage<T = unknown> {
  action: string;
  data: T;
}

export function DebugData<P>(events: NuiMessage<P>[], timer = 1000) {
  if (isEnvBrowser()) {
    for (const event of events) {
      setTimeout(() => {
        window.dispatchEvent(
          new MessageEvent("message", {
            data: {
              action: event.action,
              data: event.data,
            },
          })
        );
      }, timer);
    }
  }
}
