<script lang="ts" setup>

import {computed, onMounted, ref, watch} from "vue";
import {gameNames} from "./humanBenchmark";

const started = ref(false);
const done = ref(false)
const sequence = ref([] as number[])
const current_input = ref([] as number[])
const show = ref(false)
const show_btn = ref(-1)

const clicked = ref(-1)
const round = computed(() => sequence.value.length)

const bad = ref(false)
const shadow_block = ref(false)

function gen_next() {
  let res = -1;
  do {
    res = Math.floor(Math.random() * 9) + 1
  } while (sequence.value.length != 0 && res == sequence.value[sequence.value.length - 1])
  return res
}

function nextStep(button?: number) {
  if (show.value)
    return

  if (done.value) {
    done.value = false
    started.value = false
    sequence.value = []
    current_input.value = []
    return
  }

  if (!started.value) {
    started.value = true
    sequence.value.push(gen_next())
    show.value = true
    return
  }


  if (button! != sequence.value[current_input.value.length]) {
    bad.value = true
    done.value = true
    setTimeout(() => bad.value = false, 200)
    return
  }
  current_input.value.push(button!)

  if (current_input.value.length == sequence.value.length) {
    shadow_block.value = true
    setTimeout(() => {
      current_input.value = []
      sequence.value.push(gen_next())
      show.value = true
      shadow_block.value = false
    }, 500)
  }
}

watch(show, (value) => {
  if (!value)
    return
  clicked.value = -1

  async function show_next() {
    await new Promise(resolve => setTimeout(resolve, 500))
    for await (const i of sequence.value) {
      show_btn.value = i
      await new Promise(resolve => setTimeout(resolve, 900))
    }
    show_btn.value = -1
    show.value = false
  }

  show_next()

})

function pos(i: number, j: number) {
  return 3 * (j - 1) + (i - 1) + 1
}

let resetClickTimeout: NodeJS.Timeout | null = null

function resetClick() {
  if (resetClickTimeout)
    clearTimeout(resetClickTimeout)
  resetClickTimeout = setTimeout(() => clicked.value = -1, 100)
}

</script>

<template>


  <div :class="{'!bg-orange-400': show, '!bg-orange-700': bad, 'bg-secondary': !bad && !show}" class="rounded-t-2xl p-4 flex flex-col justify-center text-white
          items-center elevation-2 h-full gap-4 relative">
    <template v-if="!started">
      <svg class="pulse-faint hero-icon" color="white" fill="none" height="128" viewBox="0 0 128 128" width="128" xmlns="http://www.w3.org/2000/svg">
        <rect fill="currentcolor" height="58" rx="10" width="58"></rect>
        <rect fill="currentcolor" height="58" rx="10" width="58" x="70"></rect>
        <rect fill="currentcolor" height="58" rx="10" width="58" y="70"></rect>
        <path clip-rule="evenodd" d="M118 80H80L80 118H118V80ZM80 70C74.4772 70 70 74.4772 70 80V118C70 123.523 74.4772 128 80 128H118C123.523 128 128 123.523 128 118V80C128 74.4772 123.523 70 118 70H80Z"
              fill="currentcolor"
              fill-rule="evenodd"></path>
      </svg>
      <h3 class="text-2xl text-center relative mb-4">
        {{ gameNames['sequence_memory'] }}
      </h3>

      <h4 class="text-xl p-2 text-center">
        Mémorisez le pattern.
      </h4>

      <div class="mt-4">
        <v-btn class="w-full" color="primary" @click="nextStep">
          Commencer
        </v-btn>
      </div>
    </template>
    <template v-else-if="!done">
      <div class="flex flex-col justify-center items-center gap-4 h-full w-full relative">

        <div class="text-xl text-white px-4 text-center w-full absolute top-0 left-0">
          round: {{ round }}
        </div>

        <div>
          <div class="flex flex-row justify-center items-center gap-4">
            <div v-for="i in 3" :key="i" class="flex flex-col justify-center items-center gap-4">
              <div v-for="j in 3" :key="j"
                   :class="{ '!bg-white !opacity-100': (pos(i, j) == clicked) || (pos(i, j) == show_btn) }"
                   class="rounded-lg h-[25vw] w-[25vw] bg-gray-300 opacity-40 flex justify-center items-center"
                   @pointerdown="() => {if (!show && !shadow_block) { nextStep(pos(i, j)); clicked = pos(i, j) }}"
                   @pointerleave="resetClick"
              />
            </div>
          </div>

        </div>

      </div>
    </template>
    <template v-else>
      <!--      done, show score and restart -->
      <div class="flex flex-col justify-center items-center gap-4 h-full w-full">

        <div class="text-3xl text-white px-4 text-center items-center
                flex flex-col mb-6">
          Votre score: {{ round }}
        </div>

        <div class="text-lg text-white px-4 text-center items-center
                flex flex-col mb-6">
          Votre score a été enregistré.
        </div>

        <div class="flex gap-4 w-full justify-center">
          <v-btn color="primary" @click="nextStep()">
            Recommencer
          </v-btn>
        </div>


      </div>
    </template>
  </div>
</template>

