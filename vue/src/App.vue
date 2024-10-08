<script lang="ts" setup>
import Header from "@/layouts/partials/header.vue";
import {provide, reactive, ref} from "vue";
import Loading from "@/components/Loading.vue";
import router from "@/router";
import axios from "axios";
import {useOffline} from "@/router/offline";
import {Inform, informKey, informShowKey} from "@/router/keys";


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
  })
})

const {updateOffline} = useOffline()

window.addEventListener("online", () => updateOffline(false))

window.addEventListener("offline", () => updateOffline(true))


const fullpage = ref(router.currentRoute.value.path == "/login");
const density = ref("normal")

const currentTitle = ref<undefined | string>(undefined)

router.beforeEach((to, from, next) => {
  fullpage.value = (to.meta.fullpage ?? false) as boolean
  currentTitle.value = to.meta.title as string | undefined
  density.value = to.meta.density as string | undefined ?? "normal"
  next()
})

const inform = reactive({
  title: "",
  message: "",
  show: false,
  actions: []
} as Inform)

provide(informKey, inform)
provide(informShowKey, (title: string, message: string) => {
  inform.title = title
  inform.message = message
  inform.show = true
  inform.actions = [
    {
      label: "OK",
      callback: () => {
        inform.show = false
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  console.log('beforeEachSw');
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.getRegistrations().then(registrations => {
      registrations.forEach(async registration => {
        registration.addEventListener('updatefound', () => {
          const installingWorker = registration.installing;
          console.log('A new service worker is being installed:', installingWorker);
          if (installingWorker) {
            installingWorker.addEventListener('statechange', () => {
              if (installingWorker.state === 'installed' && navigator.serviceWorker.controller) {
                window.location.reload();
              }
            });
          }
        });

        await registration.update();
      });
    });
  }

  next();
});

</script>

<template>
    <Loading/>
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

      <v-dialog v-model="inform.show" persistent>
        <v-card density="comfortable">
          <v-card-title class="mt-2">
            {{ inform.title }}
          </v-card-title>
          <v-card-text>
            {{ inform.message }}
          </v-card-text>
          <v-card-actions class="flex justify-end">
            <v-btn v-for="(action, index) in inform.actions"
                   :color="index != inform.actions.length ? 'secondary' : ''" @click="action.callback">
              {{ action.label }}
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

    </v-main>


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
  @apply bg-primary overflow-hidden;
}

body {
  @apply bg-primary;
}

* {
  touch-action: pan-x pan-y;
  user-select: none;
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
  font-weight: bolder;
}

input, textarea, select, button {
  user-select: text;
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

