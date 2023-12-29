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
      <svg class="pulse-faint hero-icon" color="white" fill="none" height="131" viewBox="0 0 100 131" width="100" xmlns="http://www.w3.org/2000/svg">
        <path clip-rule="evenodd"
              d="M100 5C100 2.23857 97.7614 0 95 0H5C2.23858 0 0 2.23858 0 5V126C0 128.761 2.23858 131 5 131H96C98.2091 131 100 129.209 100 127C100 124.791 98.2091 123 96 123H14.5477C11.7863 123 9.54774 120.761 9.54774 118V106C9.54774 103.239 11.7863 101 14.5477 101H95C97.7614 101 100 98.7614 100 96V5ZM75.1237 80C78.2046 80 80.5524 77.2406 80.0592 74.1995L72.1114 25.1995C71.7188 22.7787 69.6283 21 67.1759 21H61.5314C59.8921 21 58.3568 21.8036 57.4227 23.1508L23.4431 72.1507C21.1437 75.4666 23.5168 80 27.5519 80H28.7769C30.4488 80 32.0101 79.1644 32.9374 77.7732L39.8159 67.4536C40.7432 66.0624 42.3045 65.2268 43.9764 65.2268H62.5724C65.082 65.2268 67.2028 67.0871 67.5298 69.5752L68.3284 75.6516C68.6554 78.1397 70.7762 80 73.2858 80H75.1237ZM55.2419 58.4441C51.2439 58.4441 48.8629 53.9845 51.0871 50.6624L55.3569 44.285C57.9299 40.4418 63.8931 41.852 64.4723 46.4405L65.2773 52.818C65.6542 55.8042 63.3265 58.4441 60.3166 58.4441H55.2419Z"
              fill="currentcolor"
              fill-rule="evenodd"></path>
        <rect fill="currentcolor" height="8" rx="4" width="78" x="16" y="108"></rect>
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

