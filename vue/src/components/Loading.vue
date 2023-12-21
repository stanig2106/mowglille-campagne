<script setup lang="ts">

import {onMounted, ref} from "vue";

import loading_frame from "@/assets/loading_frame.png";
import loading from "@/assets/loading.mp4";

const props = defineProps<{
  time: number
}>();

const is_loading = ref(document.body.getAttribute("loaded") == null);
const is_loading_frame = ref(true);

const video = ref<HTMLVideoElement>();


onMounted(() => {
  setTimeout(() => {
    is_loading_frame.value = false;
    video.value?.play()
    video.value?.addEventListener("ended", () => {
      is_loading.value = false;
    })
    document.body.setAttribute("loaded", "true")
  }, props.time)
})

</script>

<template>
  <div v-if="is_loading">
    <div class="absolute top-0 left-0 h-screen w-screen z-20" v-if="is_loading_frame">
      <img :src="loading_frame" alt="loading"/>
    </div>

    <video ref="video" muted class="absolute top-0 left-0 h-screen w-screen z-10">
      <source :src="loading" type="video/mp4"/>
    </video>
  </div>

</template>
