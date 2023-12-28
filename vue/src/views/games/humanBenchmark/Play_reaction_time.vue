<script setup lang="ts">

import {ref} from "vue";

const todo = 5;
const started = ref(false);
const last_result = ref(0);
const results = ref([] as number[])
const done = ref(false)

const current_state = ref("pause" as "pause" | "waiting" | "click")
const start = ref(0)
let timeout: NodeJS.Timeout | null = null

function launch() {
  current_state.value = "waiting"
  timeout = setTimeout(() => {
    if (current_state.value !== "waiting")
      return
    current_state.value = "click"
    start.value = Date.now()
  }, Math.random() * 2000 + 1000)
}

function nextStep() {
  if (done.value) {
    done.value = false
    started.value = false
    results.value = []
    return
  }

  if (results.value.length >= todo) {
    done.value = true
    return
  }

  if (current_state.value === "pause") {
    if (last_result.value < 0) {
      last_result.value = 0
      started.value = false
      results.value = []
      return
    }
    started.value = true;
    return launch()
  }
  if (current_state.value === "waiting") {
    timeout && clearTimeout(timeout)
    timeout = null
    current_state.value = "pause"
    last_result.value = -1
    return
  }
  if (current_state.value === "click") {
    const result = Date.now() - start.value
    last_result.value = result
    results.value.push(result)
    current_state.value = "pause"
  }
}

</script>

<template>


  <div class="rounded-t-2xl p-4 flex flex-col justify-center
          items-center elevation-2 h-full gap-4 relative"
       :class="{
      'bg-red-500': current_state === 'waiting',
      'bg-green-500': current_state === 'click',
      'bg-secondary': current_state === 'pause' && last_result >= 0,
      'bg-gray-600': current_state === 'pause' && last_result < 0,
    }" @pointerdown="nextStep">
    <div v-if="!done">
      <div class="text-4xl text-white px-4 text-center items-center flex flex-col gap-6">
        <svg v-if="!started"
             width="100" height="128" viewBox="0 0 100 128" fill="currentcolor" xmlns="http://www.w3.org/2000/svg" class="text-white hero-icon pulse-faint">
          <path
            d="M0.719527 59.616L32.8399 2.79148C33.8149 1.06655 35.6429 0 37.6243 0H94.4947C98.9119 0 101.524 4.94729 99.0334 8.59532L71.201 49.357C68.7101 53.0051 71.3225 57.9524 75.7397 57.9524H82.2118C87.3625 57.9524 89.6835 64.4017 85.7139 67.6841L14.34 126.703C9.85287 130.413 3.43339 125.513 5.82845 120.206L25.9709 75.5735C27.6125 71.936 24.9522 67.8166 20.9615 67.8166H5.50391C1.29539 67.8166 -1.35146 63.2798 0.719527 59.616Z"
            fill="currentcolor"></path>
        </svg>
        <div v-if="!started" class="flex">
          Test de temps de réaction
        </div>
        <span v-if="!started" class="flex text-xl">
        Quand l'écran devient vert, cliquez aussi vite que possible ! <br>
        Réalisez {{ todo }} essais pour obtenir votre temps de réaction moyen. <br> <br>
        Cliquer pour commencer.
      </span>

        <div v-if="started && current_state === 'pause' && last_result < 0" class="flex">
          Trop tôt ! <br>
          Attendez que l'écran devienne vert. <br><br>

          Cliquer pour recommencer.
        </div>

        <div v-if="started && current_state === 'waiting'" class="flex">
          Attendez...
        </div>

        <div v-if="started && current_state === 'click'" class="flex">
          Cliquez !
        </div>

        <div v-if="started && current_state === 'pause' && last_result >= 0" class="flex">
          <div class="flex gap-4 flex-col">
            <div class="absolute top-4 left-0 w-full text-center">
              {{ results.length }}/{{ todo }}
            </div>
            <div>
              {{ last_result }} ms
            </div>
            <div class="mt-4">
              Cliquer pour continuer
            </div>
          </div>
        </div>
      </div>
    </div>
    <div v-else>
      <div class="flex gap-4 flex-col text-3xl text-white px-4 text-center items-center">
        <div>
          Score moyen : <br>
          {{
            Math.round(
              results.reduce((a, b) => a + b, 0) / results.length
            )
          }} ms
        </div>
        <div class="mt-4">
          Votre score à été enregistré !
        </div>
        <div class="mt-4">
          Cliquer pour recommencer
        </div>
      </div>
    </div>
  </div>

</template>

