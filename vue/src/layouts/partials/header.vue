<script setup lang="ts">
</script>

<template>
  <div class="bg-primary top-0 absolute h-16 w-full
              flex p-4 !pb-1 justify-between">

    <h1 class=" h-full flex items-center font-extrabold text-3xl italic mt-0.5">
      MOWG'LILLE
    </h1>

    <div class="h-full flex justify-end items-center space-x-6">
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
