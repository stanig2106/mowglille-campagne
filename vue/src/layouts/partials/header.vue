<script setup lang="ts">


const props = defineProps<{
  back: string | null
}>()
</script>

<template>
  <div class="bg-primary top-0 absolute h-16 w-full
              flex justify-between">

    <h1 class="h-full flex items-center text-3xl italic mt-0.5 ml-4"
        v-if="back == null">
      MOWG'LILLE
    </h1>

    <h1 class="h-full flex items-center text-3xl italic mt-0.5"
        v-else>
      <v-btn icon variant="text" rounded="lg"
             @click="$router.go(-1)">
        <v-icon size="32">
          mdi-arrow-left
        </v-icon>
      </v-btn>
      {{ back }}
    </h1>

    <div class="h-full flex justify-end items-center space-x-6 mr-2"
         v-if="back == null">
      <v-btn icon variant="text" rounded="lg">
        <v-icon size="32">
          mdi-instagram
        </v-icon>
      </v-btn>

      <v-btn icon variant="text" rounded="lg">
        <v-icon size="32">
          mdi-facebook
        </v-icon>
      </v-btn>
    </div>

  </div>
  <div class="bg-primary top-0 z-10 sticky h-1" id="header-clip"/>
</template>

<style lang="scss">
h1 {
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
}
</style>
