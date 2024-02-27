<script lang="ts" setup>


import {onMounted, ref} from "vue";

const props = defineProps<{
  rarity: "rare" | "epic" | "legendary"
}>()

const emit = defineEmits<{
  done: []
}>()

const shake = ref(false)
console.log("foo")

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

      opening.addEventListener("ended", () => emit("done"))
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

  <video id="opening" class="fixed top-0 left-0 z-40 h-full w-full object-cover"
         playsinline>
    <source :src="`/chest/${props.rarity}.mp4`" type="video/mp4"/>
  </video>
  <video id="loop" class="fixed top-0 left-0 z-40 h-full w-full object-cover"
         loop playsinline>
    <source src="/chest/loop.mp4" type="video/mp4"/>
  </video>
  <video id="open" autoplay class="fixed top-0 left-0 z-40 h-full w-full object-cover"
         src="/chest/intro.mp4" type="video/mp4" playsinline>
  </video>

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
