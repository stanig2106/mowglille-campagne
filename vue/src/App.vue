<script lang="ts" setup>
import {ref} from "vue";
import router from "@/router";


const fullpage = ref(router.currentRoute.value.path == "/login");
const density = ref("normal")

const currentTitle = ref<undefined | string>(undefined)

router.beforeEach((to, from, next) => {
  fullpage.value = (to.meta.fullpage ?? false) as boolean
  currentTitle.value = to.meta.title as string | undefined
  density.value = to.meta.density as string | undefined ?? "normal"
  next()
})

</script>

<template>

  <v-app class="bg-transparent">
    <router-view/>
  </v-app>
</template>


<style lang="scss">
@tailwind base;
@tailwind components;
@tailwind utilities;

@font-face {
  font-family: "QuintoAndatTextos-Bold";
  src: url("assets/fonts/QuintoAndarTextos-Bold.woff2") format("woff2");
}

html {
  //@apply bg-primary overflow-hidden;
}

* {
  touch-action: pan-x pan-y;
  user-select: none;
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
  font-weight: bolder;
}

img {
  pointer-events: none;
  -webkit-touch-callout: none;
}

button {
  text-transform: none !important;
}

.text-muted {
  @apply text-gray-500;
}

.one-line {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

</style>

