<script lang="ts" setup>
import Header from "@/layouts/partials/header.vue";
import {onMounted, provide, ref} from "vue";
import Loading from "@/components/Loading.vue";
import router from "@/router";
import axios, {AxiosError} from "axios";
import {offlineKey} from "@/router/keys";
import { useScreenSafeArea } from '@vueuse/core'


router.afterEach(() => {
  if (router.currentRoute.value.path == "/login" || router.currentRoute.value.path == "/cla_login")
    return

  if (localStorage.getItem("token") == null)
    return router.replace("/login")

  axios.get("/check_token").then(({data}) => {
    if (!data.ok) {
      localStorage.removeItem("token")
      window.location.reload()
    }
  }).catch((reason: AxiosError) => {
    if (reason.code == "ERR_NETWORK")
      offline.value = true
  })
})

const offline = ref(false)
provide(offlineKey, {offline, updateOffline: (value: boolean) => offline.value = value})

window.addEventListener("online", () => offline.value = false)

window.addEventListener("offline", () => offline.value = true)


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
  <Loading/>
  <useScreenSafeArea bottom top>
    <v-app v-if="fullpage" class="bg-transparent">
      <router-view/>
    </v-app>
    <v-app v-else>
      <v-main :class="{'pt-16': density == 'normal', 'pt-12': density == 'compact'}"
              class="z-0 bg-primary h-screen"
      >
        <Header :back="currentTitle" :density="density as any"/>

        <div :class="{'px-2': density == 'normal'}"
             class="h-full rounded-t-3xl !overflow-y-auto">
          <router-view/>
        </div>


      </v-main>
    </v-app>
  </useScreenSafeArea>
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
  @apply bg-primary overflow-hidden;
}

* {
  touch-action: pan-x pan-y;
  user-select: none;
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
  font-weight: bolder;
}

img {
  pointer-events: none !important;
  -webkit-touch-callout: none !important;
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

.one-line {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

</style>

