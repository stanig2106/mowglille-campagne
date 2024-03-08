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


* {
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
  font-weight: bolder;
}

#header-clip::before {
  display: none;
  content: "";
  @apply absolute top-0 left-0 h-8 w-8 bg-primary;
}

#header-clip::after {
  display: none;
  content: "";
  @apply absolute top-0 right-0 h-8 w-8 bg-primary;
}

button {
  text-transform: none !important;
}

.text-muted {
  @apply text-gray-500;
}

.one-line, .\>\:one-line > *, .\*\:one-line * {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

.flex-center {
  @apply flex justify-center items-center;
}

.v-card * {
  --v-focus-opacity: 0 !important;
  --v-hover-opacity: 0 !important;
}

h1 {
  @apply text-4xl;
}

h2 {
  @apply text-3xl;
}

h3 {
  @apply text-2xl;
}

h4 {
  @apply text-xl;
}

h5 {
  @apply text-lg;
}

h6 {
  @apply text-base;
}

.square-shadow.elevation-2 {
  box-shadow: 0 50vh white,
  0px 3px 1px -2px var(--v-shadow-key-umbra-opacity, rgba(0, 0, 0, 0.2)),
  0px 2px 2px 0px var(--v-shadow-key-penumbra-opacity, rgba(0, 0, 0, 0.14)),
  0px 1px 5px 0px var(--v-shadow-key-penumbra-opacity, rgba(0, 0, 0, 0.12)) !important;


}

.v-dialog > .v-overlay__content {
  @apply left-0;
}
</style>

