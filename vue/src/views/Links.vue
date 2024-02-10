<script lang="ts" setup>

import {ref} from "vue";

const instagram = ref("https://www.instagram.com/mowglille/")
const facebook = ref("https://www.facebook.com/mowglille/")
const mailto = ref("mailto:contact@mowglille.fr")

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col
        justify-center elevation-2 h-full gap-6 relative">
    <a :href="instagram" class="text-center text-blue-500 text-xl flex
            items-center justify-center gap-2" target="_blank">
      <v-icon>mdi-instagram</v-icon>
      Instagram
    </a>
    <a :href="facebook" class="text-center text-blue-500 text-xl flex
            items-center justify-center gap-2" target="_blank">
      <v-icon>mdi-facebook</v-icon>
      Facebook
    </a>
    <a :href="mailto" class="text-center text-blue-500 text-xl flex
            items-center justify-center gap-2" target="_blank">
      <v-icon>mdi-email</v-icon>
      Mail
    </a>

    <!--    copyright -->
    <div class="absolute bottom-4 left-0 px-8 flex justify-center w-full">
      <div class="text-center text-gray-500 text-sm">
        © Mowg'Lille, 2024. <br> Tous droits réservés. <br>
        <span>
          Réalisé avec <v-icon class="text-red-500" size="16">mdi-heart</v-icon> par
          <a class="underline" href="https://www.linkedin.com/in/stani-gam/" target="_blank">
            Stani GAM
          </a>
        </span> <br>
        <span>
          Illustrations et vidéos par
          <a class="underline" href="https://www.linkedin.com/in/arthurnbga/" target="_blank">
            Arthur NOBREGA
          </a>
        </span>
        <div class="flex flex-center mt-2">
        <img src="https://wakatime.com/badge/user/cdd131f0-023c-4810-898a-52d5ac48e036/project/018c84ad-22cb-445e-84ca-13025beb24a4.svg" alt="wakatime">
        </div>
      </div>

    </div>

  </div>

</template>

