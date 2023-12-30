<script lang="ts" setup>
import Loading from "@/components/Loading.vue"

import {onMounted, ref} from "vue";
import LoginImage from "@/views/LoginImage.vue";
import LoginName from "@/views/LoginName.vue";
import axios from "axios";
import router from "@/router";

const first_step = ref(true);

const last_name = ref("");
const first_name = ref("");

const image = ref(null);

if (localStorage.getItem("token") != null)
  router.replace("/")


async function login() {
  const r = await axios.post("/register", {
    first_name: first_name.value,
    last_name: last_name.value,
    image: image.value
  });

  if (r.status != 200 || r.data.token == undefined)
    return alert("Erreur lors de l'inscription")

  localStorage.setItem("token", r.data.token)

  await router.replace("/")
}


onMounted(() => document.querySelector("#downloading-label")?.remove())
</script>

<template>

  <div class="flex flex-col items-center justify-center h-full w-[100vw]">
    <LoginName v-model:first_name="first_name" v-model:last_name="last_name"
               :class="`animation1 ${first_step ? 'on' : 'off'}`"
               class="w-[90%]"
               @continue="() => first_step = false"/>
    <LoginImage v-model="image" :class="`animation2 ${first_step ? 'on' : 'off'}`" class="w-[90%]"
                @back="() => first_step = true" @continue="login"/>
  </div>

</template>

<style lang="scss">

html {
  overflow: hidden;
}

body {
  overflow: hidden;
  background-image: url("@/assets/login_page_background.png");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

.animation1, .animation2 {
  position: absolute;
  transition: transform 0.5s ease-in-out;
  transform: translateX(0);
}

.animation1.off {
  user-select: none;
  transform: translateX(-100vw);
}

.animation2.on {
  visibility: hidden;
  user-select: none;
  transform: translateX(100vw);
}

</style>
