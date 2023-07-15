<script lang="ts">
  import { onMount } from "svelte";
  import { tweened } from "svelte/motion";
  import { MessageHandler, DebugData, ReceiveNUI, FetchNUI } from "./utils";
  import { backOut, quadInOut, quadOut, quartOut } from "svelte/easing";
  import { fade, scale } from "svelte/transition";
  import dayjs from "dayjs";
  import relativeTime from "dayjs/plugin/relativeTime";
  import utc from "dayjs/plugin/utc";
  dayjs.extend(relativeTime);
  dayjs.extend(utc);
  let timeLeft: any; //10 seconds
  let format = "00:00";
  function GetFormat(ss: number) {
    if (!timeLeft) return;
    const seconds = Math.floor(ss % 60);
    const minute = Math.floor(ss / 60);
    format = `${minute.toString().padStart(2, "0")}:${seconds
      .toString()
      .padStart(2, "0")}`;
    //if (ss == 0) {
    //  FetchNUI("time-end");
    //}
  }

  let timeropen = false;
  MessageHandler();
  ReceiveNUI("timer", (data: any) => {
    timeropen = true;
    const time = data.timer;
    const init = data.init;
    const currenttime = dayjs(init);
    const dformat = dayjs(time);
    const secondTillTarget = dformat.diff(currenttime, "second");
    timeLeft = tweened(secondTillTarget, { duration: secondTillTarget * 1000 });
    timeLeft.set(0);
  });
  let progress = tweened(0, { easing: quadInOut });
  let popen = false;
  ReceiveNUI("open-progress", (data: any) => {
    progress.set(0);
    popen = data.value;
  });
  ReceiveNUI("stop-time", (data: any) => {
    timeropen = false;
    timeLeft = undefined;
  });
  DebugData([
    {
      action: "timer",
      data: {
        timer: 10,
      },
    },
    {
      action: "progress",
      data: {
        val: 100,
      },
    },
  ]);

  onMount(() => {});
  ReceiveNUI("progress", (data: any) => {
    if (data.val == 0 && $progress == 0) return;
    progress.set(data.val);
  });
  $: $timeLeft, GetFormat($timeLeft);
</script>

<div class="relative w-screen h-screen container mx-auto font-bebas-neue">
  {#if timeropen && timeLeft && $timeLeft}
    <div
      transition:fade
      class="h-full w-full absolute flex justify-end items-end p-3"
    >
      <div class="flex items-center">
        <div
          class="circle w-20 h-20 rounded-full bg-slate-800 grid place-items-center shadow shadow-slate-700"
        >
          <div
            class="w-[80%] h-[80%] rounded-full grid place-items-center outline outline-red-400 outline-[5px] animate-pulse"
          >
            <p class="text-white text-xl">
              {format}
            </p>
          </div>
        </div>
      </div>
    </div>
  {/if}
  {#if popen}
    <div class="flex justify-center items-end w-full h-full p-3">
      <div
        class="progress-wrap relative flex items-center h-10 w-52 bg-transparent outline outline-2 outline-slate-800 rounded-sm shadow shadow-black shadow-md mb-7"
      >
        <p class="z-10 absolute text-center w-full text-white text-xl">
          NOISE {Math.floor($progress)}%
        </p>
        <div
          style="width: {$progress}%;"
          class="progress-inside h-full bg-gradient-to-r from-red-100 to-red-800"
        />
      </div>
    </div>
  {/if}
</div>
