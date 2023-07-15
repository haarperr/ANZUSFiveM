import { onDestroy, onMount } from "svelte";
import { timer } from "../store/timer";

interface nuiMessage {
  data: {
    action: string;
    [key: string]: any;
  }
}

export function MessageHandler() {
  function Event(event: nuiMessage) {
    const data = event.data?.data
    switch (event.data.action) {
    }
  }
  onMount(() => window.addEventListener('message', Event))
  onDestroy(() => window.removeEventListener('message', Event))
}
