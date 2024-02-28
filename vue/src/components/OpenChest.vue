<script lang="ts" setup>


import {onMounted, ref} from "vue";
import {chestColors} from "@/views/collection/chest";

const props = defineProps<{
  rarity: "rare" | "epic" | "legendary"
  reward: ({
    type: "piece"
    rarity: "rare" | "epic" | "legendary"
    id: number
    new?: boolean
  } | {
    type: "score"
    amount: number
  })[]
}>()

const emit = defineEmits<{
  done: []
}>()

const shake = ref(false)
console.log("foo")

const show = ref(false)

onMounted(() => {
  const open = document.getElementById("open") as HTMLVideoElement
  open.play()
  console.log("playing")

  open.addEventListener("ended", () => {
    console.log("ended")
    open.style.display = "none"

    const loop = document.getElementById("loop") as HTMLVideoElement
    const hint = document.getElementById("hint") as HTMLDivElement

    loop.style.display = "block"
    loop.play()

    const clickTimeout = setTimeout(() => {
      hint.style.display = "flex"
      shake.value = true

    }, 2700)

    const shakeInterval = setInterval(() => {
      shake.value = true
    }, 2500)

    hint.addEventListener("animationend", () => {
      shake.value = false
    })

    document.addEventListener("click", () => {
      clearInterval(shakeInterval)
      clearTimeout(clickTimeout)
      hint.style.display = "none"

      loop.style.display = "none"
      loop.pause()
      const opening = document.getElementById("opening") as HTMLVideoElement
      opening.style.display = "block"
      opening.play()


      opening.addEventListener("ended", () => {
        show.value = true
        document.addEventListener("click", () => emit("done"),
          {once: true})
      })
    }, {once: true})
  })
})


</script>

<template>
  <div id="hint" :class="{ 'apply-shake': shake }" class="hidden fixed top-0 left-0 z-50
                        h-full w-full justify-end items-end pb-[22vh] pr-[5vw]">
    <v-icon class="text-white" size="124" style="rotate: -20deg">
      mdi-gesture-tap
    </v-icon>
  </div>

  <video id="opening" class="fixed top-0 left-0 z-40 h-full w-full object-cover bg-black"
         playsinline>
    <source :src="`/chest/${props.rarity}.mp4`" type="video/mp4"/>
  </video>
  <video id="loop" class="fixed top-0 left-0 z-40 h-full w-full object-cover bg-black"
         loop playsinline>
    <source src="/chest/loop.mp4" type="video/mp4"/>
  </video>
  <video id="open" autoplay class="fixed top-0 left-0 z-40 h-full w-full object-cover bg-black"
         playsinline src="/chest/intro.mp4" type="video/mp4">
  </video>

  <div v-if="show" class="fixed top-0 left-0 z-40 h-full w-full flex justify-center
             items-center gap-12 flex-col text-white">
    <h2>
      Vous avez gagné :
    </h2>
    <div class="flex gap-12 ">
      <div v-for="reward in props.reward" class="flex gap-2 items-center flex-col">
        <v-icon v-if="reward.type == 'score'" size="48">mdi-star</v-icon>
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
