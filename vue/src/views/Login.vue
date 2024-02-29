<script lang="ts" setup>
import {onMounted, ref} from "vue";
import router from "@/router";

const cla_url = "https://centralelilleassos.fr" as const
const cla_id = "mowglille" as const

if (localStorage.getItem("token") != null)
  router.replace("/")

function login() {
  window.location.href = cla_url + "/authentification/" + cla_id
}

onMounted(() => document.querySelector("#downloading-label")?.remove())
</script>

<template>

  <div class="flex flex-col items-center justify-center h-full w-[100vw] px-2">
    <v-card elevation="10" rounded="xl">
      <div class="p-8">
        <v-img class="w-[45vw] mx-[15vw] -mt-2 mb-6" contain src="@/assets/logo_text.png"/>


        <div class="text-center mt-8 bt-4">
          <h3 class="text-xl font-extrabold text-center mb-4">
            Connectez vous pour continuer
          </h3>
          <v-btn color="#BE3E1D" size="x-large" @click="login">
            Connexion avec CLA
          </v-btn>
        </div>

      </div>

    </v-card>
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
