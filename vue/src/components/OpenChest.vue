<script lang="ts" setup>


import {onMounted, ref} from "vue";
import honey_white from "@/assets/honey_white.webp";
import {chestColors} from "@/views/collection/chest";
import {ChestRewards} from "@/stores/chests_store";

const props = defineProps<{
  rarity: "rare" | "epic" | "legendary"
  reward: ChestRewards
}>()

const emit = defineEmits<{
  done: []
}>()

const start_timer = 1.80 as const
const end_timer = 5.16 as const
const end_end_timer = 5.70 as const

const shake = ref(false)

const show = ref(false)

onMounted(() => {
  const video = document.getElementById("video") as HTMLVideoElement
  video.currentTime = 0
  video.play()

  const hint = document.getElementById("hint") as HTMLDivElement
  //
  const clickTimeout = setTimeout(() => {
    hint.style.display = "flex"
    shake.value = true
  }, start_timer * 1000 + 2700)

  const shakeInterval = setInterval(() => {
    shake.value = true
  }, 2500)
  //
  hint.addEventListener("animationend", () => {
    shake.value = false
  })
  //
  let clicked = false
  video.addEventListener("timeupdate", () => {
    console.log(video.currentTime)
    if (video.currentTime >= 9.5) {
      video.pause()
      show.value = true
      document.addEventListener("click", () => emit("done"),
        {once: true})

    }

    if (clicked)
      return
    if (video.currentTime >= end_timer)
      video.currentTime = start_timer
  })

  setTimeout(() => document.addEventListener("click", () => {
    clicked = true
    clearInterval(shakeInterval)
    clearTimeout(clickTimeout)
    hint.style.display = "none"

    video.currentTime = end_end_timer
  }, {once: true}), start_timer * 1000)
})


</script>

<template>
  <div id="hint" :class="{ 'apply-shake': shake }" class="hidden fixed top-0 left-0 z-50
                        h-full w-full justify-end items-end pb-[10vh] pr-[5vw]">
    <v-icon class="text-white" size="124" style="rotate: -20deg">
      mdi-gesture-tap
    </v-icon>
  </div>

  <video id="video" autoplay class="fixed top-0 left-0 z-40 h-full w-full object-cover bg-black"
         playsinline :src="`/chest/${props.rarity}.mp4`" type="video/mp4"/>

  <div v-if="show" class="fixed top-0 left-0 z-40 h-full w-full flex justify-center
             items-center gap-12 flex-col text-white">
    <h2>
      Vous avez gagné :
    </h2>
    <div class="flex gap-12 ">
      <div v-for="reward in props.reward" class="flex gap-2 items-center flex-col">
        <img v-if="reward.type == 'score'" :src="honey_white" alt="Miel"
             class="w-[48px] h-[48px] object-contain"/>
        <v-icon v-else :color="chestColors[reward.rarity]" size="48">mdi-puzzle</v-icon>

        <div class="text-center">
          <span>{{ reward.type == "piece" ? "Pièce" : "Miel" }}</span>
          <span v-if="reward.type == 'piece'"> n°{{ reward.id }}</span>
          <span v-else> x{{ reward.amount }}</span>
          <div v-if="reward.type == 'piece' && reward.new">Nouvelle pièce !</div>
        </div>
      </div>
    </div>
    <h4>
      Appuyez pour continuer
    </h4>
  </div>

</template>

<style lang="scss" scoped>

@keyframes shake {
  10%,
  90% {
    transform: translate3d(-1px, 0, 0);
  }

  20%,
  80% {
    transform: translate3d(2px, 0, 0);
  }

  30%,
  50%,
  70% {
    transform: translate3d(-4px, 0, 0);
  }

  40%,
  60% {
    transform: translate3d(4px, 0, 0);
  }
}

.apply-shake {
  animation: shake 0.82s cubic-bezier(0.36, 0.07, 0.19, 0.97) both;
}

</style>
