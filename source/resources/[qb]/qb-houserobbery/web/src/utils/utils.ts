import { onDestroy, onMount } from "svelte";

export const isEnvBrowser = (): boolean => !(window as any).invokeNative 


interface NuiMessage<T = unknown> {
    action: string;
    data: T;
  }
  

export function ReceiveNUI<T = unknown>(
    action: string,
    handler: (data: T) => void
  ) {
    const eventlistener = (event: MessageEvent<NuiMessage<T>>) => {
      const { action: eventAction, data } = event.data;
      eventAction === action && handler(data);
    };
    onMount(() => window.addEventListener("message", eventlistener));
    onDestroy(() => window.removeEventListener("message", eventlistener));
}
  
export async function FetchNUI<T = any>(
    eventName: string,
    data: unknown = {}
  ): Promise<T> {
    const options = {
      method: "post",
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify(data),
    };
    const resourceName = (window as any).GetParentResourceName
      ? (window as any).GetParentResourceName()
      : "qb-houserobbery";
    const resp = await fetch(`https://${resourceName}/${eventName}`, options);
    return await resp.json();
  }