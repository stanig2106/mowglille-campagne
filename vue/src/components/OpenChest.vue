<script lang="ts" setup>

import intro_video from "@/assets/chest/intro.mp4"
import loop_video from "@/assets/chest/loop.mp4"
import epic_video from "@/assets/chest/epic.mp4"

import p5 from "p5"
import {onMounted, onUnmounted, ref, watch} from "vue";
import router from "@/router";

const props = defineProps<{
  rarity: "rare" | "epic" | "legendary"
}>()

const done = ref(false)

let click = {
  first: document.body.hasAttribute("interacted")
}
onMounted(() => {

  let sketch : p5 | undefined = new p5((p: p5) => {
    let video_intro: p5.MediaElement
    let video_loop: p5.MediaElement
    let video_opening: p5.MediaElement
    let video_width: number
    let video_height: number
    let played_first = false
    let playing = "intro"
    let open = false


    p.preload = () => {
      video_intro = p.createVideo(intro_video)
      video_loop = p.createVideo(loop_video)
      video_opening = p.createVideo(epic_video)
    }

    p.setup = () => {
      p.createCanvas(p.windowWidth, p.windowHeight, document.getElementById("canvas") as HTMLElement)
      video_width = p.windowWidth
      video_height = p.windowHeight
    }

    p.remove = () => {
      video_intro.remove()
      video_loop.remove()
      video_opening.remove()
    }

    p.draw = () => {
      p.background(0)

      if (playing == "none")
        return

      if (playing == "intro")
        p.image(video_intro, 0, 0, video_width, video_height)
      if (click.first && !played_first) {
        played_first = true
        video_intro.play()
      }
      video_intro.onended(() => {
        playing = "loop"
        video_loop.play()
        video_intro.hide()
      })

      if (video_loop.time() > video_loop.duration() - 0.2)
        video_loop.time(0)

      if (playing == "loop") {
        p.image(video_loop, 0, 0, video_width, video_height)
        if (p.mouseIsPressed)
          open = true
      }

      if (open && playing != "opening") {
        playing = "opening"
        video_loop.stop()
        video_loop.hide()
        video_opening.play()
      }

      if (playing == "opening")
        p.image(video_opening, 0, 0, video_width, video_height)

      video_opening.onended(() => {
        playing = "none"
        video_opening.hide()
        done.value = true
      })


    }

  })

  onUnmounted(() => {
    sketch?.remove()
    sketch = undefined
  })

  watch(done, (value) => {
    if (value) {
      sketch?.remove()
      sketch = undefined
    }
  })
})

</script>

<template>
  <canvas id="canvas" class="fixed top-0 left-0 z-50 transform"
          v-if="!done" @click="() => click.first = true"/>
</template>

<style lang="scss" scoped>

</style>
