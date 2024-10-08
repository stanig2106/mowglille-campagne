<script lang="ts" setup>

import Keyboard from 'simple-keyboard';
import "simple-keyboard/build/css/index.css";

import {computed, onMounted, onUnmounted, ref, watch} from "vue";
import {gameNames} from "./humanBenchmark";
import {TransitionPresets, useTimestamp, useTransition} from "@vueuse/core";
import {saveScore} from "@/views/games/Score";

const time_show = 3000 // ms

const round = ref(1)
const started = ref(false);
const show_number = ref(false)
const ask_input = ref(false)
const source_progress = ref(0)
const show_result = ref(false)
const done = ref(false)
const progress = useTransition(source_progress, {
  duration: time_show,
  transition: TransitionPresets.linear,
  onFinished() {
    show_number.value = false
    user_input.value = ""
    ask_input.value = true
    source_progress.value = 0
  },
  delay: 10,
  disabled: computed(() => source_progress.value == 0)
})

const number = ref("")

const timestamp = useTimestamp({interval: 1000})

const user_input = ref("")

watch(user_input, (value) => {
  if (value.length >= round.value + 5)
    user_input.value = value.slice(0, -1)
})

function nextStep(validate = false) {
  if (show_number.value)
    return

  if (validate) {
    ask_input.value = false
    show_result.value = true
    done.value = user_input.value != number.value

    if (done.value) {
      saveScore("human_benchmark_number_memory", round.value - 1,
        {
          title: "Score de " + gameNames['number_memory'],
          message: "Vous avez fait un score de " + (round.value - 1)
        })
    }

    return
  }
  show_result.value = false
  if (!started.value)
    round.value = 1

  started.value = true
  // generate a number with {round} digits
  number.value = Array.from({length: round.value}, () =>
    Math.floor(Math.random() * 10)).join("")
  // if the number starts with 0, replace it with a random number between 1 and 9
  if (number.value[0] == "0")
    number.value = Math.floor(Math.random() * 9 + 1) +
      number.value.slice(1)

  show_number.value = true
  source_progress.value = 100
}

let keyboard: Keyboard | null = null
onMounted(() => {
  keyboard = new Keyboard("keyboard", {
    theme: "hg-theme-default w-full absolute bottom-0 left-0 w-full",
    onKeyPress(button) {
      if (button == "{enter}")
        user_input.value.length > 0 && nextStep(true)
      else if (button == "{bksp}")
        user_input.value = user_input.value.slice(0, -1)
      else
        user_input.value += button
    },
    layout: {
      default: [
        "1 2 3",
        "4 5 6",
        "7 8 9",
        "{bksp} 0 {enter}",
      ],
    },
    display: {
      "{bksp}": "⌫",
      "{enter}": "Valider",
    },
  });
  keyboard.render()
});
onUnmounted(() => keyboard?.destroy())


</script>

<template>


  <div class="rounded-t-2xl p-4 flex flex-col justify-center text-white
          items-center elevation-2 h-full gap-4 relative bg-secondary">
    <template v-if="!started">
      <svg color="white" fill="none" height="128" viewBox="0 0 128 128" width="128" xmlns="http://www.w3.org/2000/svg">
        <path clip-rule="evenodd"
              d="M20 0C8.95431 0 0 8.95431 0 20V108C0 119.046 8.95431 128 20 128H108C119.046 128 128 119.046 128 108V20C128 8.95431 119.046 0 108 0H20ZM76.9347 58.1152C77.6244 58.8068 78.4359 59.1525 79.3691 59.1525H102.922C103.856 59.1525 104.647 58.8068 105.296 58.1152C105.986 57.4237 106.331 56.6102 106.331 55.6746V54.2712C106.331 53.3356 105.986 52.522 105.296 51.8305C104.647 51.139 103.856 50.7932 102.922 50.7932H89.5938C89.5532 50.7932 89.5329 50.7729 89.5329 50.7322C89.5329 50.6915 89.5532 50.6508 89.5938 50.6102C96.1262 45.078 100.508 40.7051 102.74 37.4915C105.012 34.2373 106.148 30.8203 106.148 27.2407C106.148 23.0915 104.809 19.8576 102.131 17.539C99.4938 15.1797 95.7204 14 90.811 14C87.4028 14 83.8525 14.4881 80.1603 15.4644C79.146 15.7491 78.3345 16.3186 77.7259 17.1729C77.1173 17.9864 76.813 18.922 76.813 19.9797V22.5424C76.813 23.3559 77.1578 23.9864 77.8476 24.4339C78.5374 24.8814 79.2677 24.9627 80.0386 24.678C83.6903 23.2949 86.7739 22.6034 89.2895 22.6034C93.428 22.6034 95.4973 24.4746 95.4973 28.2169C95.4973 30.9017 94.3815 33.6475 92.1499 36.4542C89.9589 39.261 85.4552 43.3491 78.6388 48.7186C76.813 50.1424 75.9 51.9932 75.9 54.2712V55.6746C75.9 56.6102 76.2449 57.4237 76.9347 58.1152ZM22.4066 32.6712C23.0557 32.9966 23.6643 32.9356 24.2324 32.4882L33.1181 26.0204H33.2398V55.6746C33.2398 56.6102 33.5847 57.4237 34.2744 58.1153C34.9642 58.8068 35.7757 59.1526 36.7089 59.1526H40.5431C41.4763 59.1526 42.2878 58.8068 42.9776 58.1153C43.6673 57.4237 44.0122 56.6102 44.0122 55.6746V18.0882C44.0122 17.1526 43.6673 16.339 42.9776 15.6475C42.2878 14.956 41.4763 14.6102 40.5431 14.6102H36.7089C34.3556 14.6102 32.266 15.2814 30.4402 16.6238L24.2932 21.139C22.4268 22.4814 21.4936 24.3119 21.4936 26.6305V31.0848C21.4936 31.817 21.7979 32.3458 22.4066 32.6712ZM24.4691 77.2068C23.5359 77.2068 22.7244 76.861 22.0346 76.1695C21.3449 75.478 21 74.6644 21 73.7288V72.3254C21 71.3898 21.3449 70.5763 22.0346 69.8848C22.7244 69.1932 23.5359 68.8475 24.4691 68.8475H47.1702C48.1034 68.8475 48.9149 69.1932 49.6047 69.8848C50.2944 70.5763 50.6393 71.3898 50.6393 72.3254V73.7288C50.6393 76.0475 49.7467 77.939 47.9614 79.4034L38.7714 87.0305V87.0915C38.7714 87.1322 38.7917 87.1526 38.8323 87.1526H39.5626C43.0925 87.1526 45.9124 88.2509 48.0223 90.4475C50.1727 92.6441 51.2479 95.6136 51.2479 99.3559C51.2479 104.075 49.8075 107.695 46.9268 110.217C44.046 112.739 39.9075 114 34.5111 114C31.2652 114 27.9787 113.614 24.6517 112.841C23.6779 112.597 22.8664 112.068 22.2172 111.254C21.6086 110.4 21.3043 109.444 21.3043 108.386V106.312C21.3043 105.498 21.6289 104.868 22.2781 104.42C22.9678 103.932 23.7185 103.81 24.5299 104.054C28.0193 105.193 31.0624 105.763 33.6591 105.763C36.0124 105.763 37.8382 105.214 39.1366 104.115C40.4349 103.017 41.0841 101.492 41.0841 99.539C41.0841 97.5458 40.3335 96.1424 38.8323 95.3288C37.331 94.5153 34.5314 94.0881 30.4335 94.0475C29.5003 94.0475 28.6888 93.722 27.999 93.0712C27.3093 92.3797 26.9644 91.5661 26.9644 90.6305V90.5085C26.9644 88.2305 27.8367 86.339 29.5814 84.8339L38.2237 77.3288V77.2678C38.2237 77.2271 38.2034 77.2068 38.1628 77.2068H24.4691ZM76.813 77.4508C77.5027 77.939 78.2533 78.0813 79.0648 77.8779C82.8788 76.9017 86.3884 76.4135 89.5938 76.4135C93.9757 76.4135 96.1667 77.7559 96.1667 80.4407C96.1667 81.2135 95.9233 81.9661 95.4364 82.6983C94.9495 83.4305 94.4221 84.0407 93.854 84.5288C93.3266 85.0169 92.5151 85.6678 91.4196 86.4813C90.0401 87.4983 88.9852 88.3322 88.2548 88.983C87.5245 89.5932 86.6927 90.5491 85.7595 91.8508C84.8263 93.1118 84.1771 94.4339 83.812 95.8169C83.5685 96.7118 83.7714 97.5051 84.4206 98.1966C85.0698 98.8881 85.8812 99.2339 86.855 99.2339H89.472C91.2167 99.2339 92.6571 98.1356 93.7932 95.939C94.1583 95.2474 94.6858 94.5559 95.3756 93.8644C96.0653 93.1322 96.6536 92.6034 97.1405 92.2779C97.6274 91.9118 98.3983 91.3424 99.4532 90.5695C100.711 89.7152 101.644 89.044 102.253 88.5559C102.902 88.0271 103.653 87.2746 104.505 86.2983C105.397 85.322 106.026 84.244 106.391 83.0644C106.797 81.8847 107 80.5424 107 79.0373C107 75.8237 105.6 73.2203 102.801 71.2271C100.001 69.2339 96.1059 68.2373 91.1153 68.2373C87.3013 68.2373 83.3048 68.6237 79.1257 69.3966C78.1519 69.5593 77.3404 70.0474 76.6912 70.861C76.0826 71.6339 75.7783 72.5288 75.7783 73.5457V75.3763C75.7783 76.2305 76.1232 76.922 76.813 77.4508ZM89.9589 104.237H86.3073C85.3741 104.237 84.5626 104.583 83.8728 105.275C83.2236 105.966 82.899 106.78 82.899 107.715V109.912C82.899 110.847 83.2236 111.661 83.8728 112.353C84.5626 113.044 85.3741 113.39 86.3073 113.39H89.9589C90.8921 113.39 91.7036 113.044 92.3934 112.353C93.0831 111.661 93.428 110.847 93.428 109.912V107.715C93.428 106.78 93.0831 105.966 92.3934 105.275C91.7036 104.583 90.8921 104.237 89.9589 104.237Z"
              fill="currentcolor"
              fill-rule="evenodd"></path>
      </svg>
      <h1 class="text-4xl text-center">
        {{ gameNames['number_memory'] }}
      </h1>

      <div class="text-lg text-center">
        Mémorisez les nombres et réécrivez-les.
      </div>

      <div>
        <v-btn class="w-full" color="primary" @click="() => nextStep(false)">
          Jouer
        </v-btn>
      </div>
    </template>

    <div v-else-if="show_number" class="flex flex-col items-center gap-4 w-full mb-12">
      <div class="text-xl">
        Mémorisez le nombre
      </div>
      <div class="text-4xl">
        {{ number }}
      </div>
      <div class="w-3/4">
        <v-progress-linear :model-value="progress"/>
      </div>
    </div>

    <div v-else-if="ask_input" class="flex flex-col items-center gap-4 w-full mb-16">
      <div class="text-xl">
        Réécrivez le nombre
      </div>
      <div :class="{'pl-6': user_input.length > 0}"
           class="bg-white rounded-2xl p-4 text-black
          elevation-2 h-full gap-4 max-w-[95vw] text-4xl overflow-hidden" style="overflow-wrap: anywhere">
        {{ user_input }}<span :class="{'text-white': timestamp % 2000 < 1000}" class="font-thin mb-2"
                              style="font-family: sans-serif !important">&#124;</span>
      </div>
    </div>
    <div :class="{'*:!text-black': ask_input}" class="text-transparent">
      <div v-show="started && (ask_input || show_number)" class="keyboard"/>
    </div>

    <div v-if="show_result" class="flex flex-col items-center gap-2 w-full mb-16 >:text-center">
      <h2 class="text-4xl absolute top-4 left-0 w-full text-center">
        Round {{ round }}
      </h2>

      <div class="text-4xl mb-8">
        {{ done ? "Incorrect" : "Correct" }}
      </div>
      <div class="text-xl">
        Nombre:
      </div>
      <div class="text-2xl">
        {{ number }}
      </div>
      <div class="w-3/4">
        <v-progress-linear :model-value="progress"/>
      </div>
      <div class="text-xl">
        Votre réponse:
      </div>
      <div class="text-2xl">
        <span v-for="(c, index) in user_input" :key="index"
              :class="{'line-through text-black': c != number[index]}"
        >{{ c }}</span><span v-for="index in Math.max(number.length - user_input.length, 0)"
                             :key="index" class="line-through text-black">?</span>
      </div>
      <span v-if="done" class="text-lg mt-6">
        Votre score à été enregistré.
      </span>

      <div>
        <v-btn v-if="done" class="w-full mt-4" color="primary"
               @click="() => {started = false; show_result = false}">
          Recommencer
        </v-btn>
        <v-btn v-else class="w-full mt-4" color="primary"
               @click="() => {round++; nextStep(false)}">
          Suivant
        </v-btn>
      </div>
    </div>


  </div>

</template>

<style>
.hg-theme-default .hg-button {
  height: 55px;
  flex: 1 1 0;
}

.v-progress-linear {
  transition: none !important;
}
</style>
