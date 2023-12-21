<script lang="ts" setup>
import Header from "@/layouts/partials/header.vue";
import Footer from "@/layouts/partials/footer.vue";
import {ref} from "vue";
import Loading from "@/components/Loading.vue";
import router from "@/router";


if (localStorage.getItem("token") == null)
  router.push("/login")

const fullpage = ref(router.currentRoute.value.path == "/login");

router.beforeEach((to, from, next) => {
  fullpage.value = to.path == "/login"
  next()
})
</script>

<template>
  <Loading :time="750"/>

  <v-app v-if="fullpage" class="bg-transparent">
    <router-view/>
  </v-app>
  <v-app v-else>
    <v-main class="z-0 pt-16 bg-primary">
      <Header/>

      <div class="p-4 bg-white h-full rounded-t-3xl overflow-y-auto mt-2">
        <router-view/>
      </div>

      <Footer/>
    </v-main>
  </v-app>
</template>


<style lang="scss">
@tailwind base;
@tailwind components;
@tailwind utilities;

@font-face {
  font-family: "QuintoAndatTextos-Regular";
  src: url("assets/fonts/QuintoAndarTextos-Regular.woff2") format("woff2");
}

@font-face {
  font-family: "QuintoAndatTextos-Bold";
  src: url("assets/fonts/QuintoAndarTextos-Bold.woff2") format("woff2");
}

* {
  font-family: "QuintoAndatTextos-Regular", sans-serif !important;
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

// incognito mode

img, video {
  filter: blur(40px);
}

body {
  background: #065223 !important;
}

h1 {
  filter: blur(40px);
}
</style>

