<script lang="ts" setup>

import {computed, onMounted, ref, watch} from "vue";
import {gameNames} from "./humanBenchmark";

const started = ref(false);
const done = ref(false)

const round = ref(1)
const size = ref(3)

const user_input = ref([] as number[])
const sequence = ref([] as number[])
const show = ref(false)
const shadow_block = ref(false)
const missed = ref([] as number[])


async function showSequence() {
  show.value = true
  await new Promise(resolve => setTimeout(resolve, 1000))
  show.value = false
  shadow_block.value = false
}


function gen(size: number, length: number) {
  size *= size
  const res = new Set<number>()

  while (res.size != length)
    res.add(Math.floor(Math.random() * (size - 1)) + 1)

  return Array.from(res)
}

function nextStep(button?: number) {
  if (!started.value) {
    started.value = true
    sequence.value = gen(size.value, round.value + 2)
    setTimeout(showSequence, 500)
    return
  }

  if (done.value) {
    missed.value = []
    user_input.value = []
    done.value = false
    started.value = false
    round.value = 1
    return
  }


  if (user_input.value.includes(button!) || missed.value.includes(button!))
    return

  if (sequence.value.includes(button!)) {
    user_input.value.push(button!)
    if (user_input.value.length == sequence.value.length) {
      shadow_block.value = true
      setTimeout(() => {
        round.value++
        if (should_increase(round.value))
          size.value++
        user_input.value = []
        missed.value = []
        sequence.value = gen(size.value, round.value + 2)
        setTimeout(showSequence, 500)
      }, 500)
    }
    return
  }

  missed.value.push(button!)
  if (missed.value.length == 3) {
    shadow_block.value = true
    setTimeout(() => done.value = true, 500)
  }

}


function should_increase(n: number) {
  if (n < 10)
    return n % 3 == 0
  if (n < 30)
    return n % 4 == 0
  return n % 7 == 3
}

function pos(i: number, j: number) {
  return size.value * (j - 1) + (i - 1) + 1
}


</script>

<template>


  <div :class="{'!bg-orange-400': show, 'bg-secondary': !show, '!p-1': size >= 6}" class="rounded-t-2xl p-4 flex flex-col justify-center text-white
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

        <div class="w-full">
          <div :class="{'!gap-1': size >= 6}" class="flex flex-row justify-center items-center gap-2">
            <div v-for="i in size" :key="i" :class="{'!gap-1': size >= 6}" class="flex flex-col w-full flex-1 gap-2">
              <v-responsive v-for="j in size" :key="j"
                            :class="{ '!bg-white !opacity-100': user_input.includes(pos(i, j)) || show && sequence.includes(pos(i, j)),
                            '!bg-gray-600 !opacity-70': missed.includes(pos(i, j)) }"
                            aspect-ratio="1" class="rounded-lg bg-gray-300 opacity-40 flex justify-center items-center"
                            @pointerdown="!show && !shadow_block && nextStep(pos(i, j))"
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

