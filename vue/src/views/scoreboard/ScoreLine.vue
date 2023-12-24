<script setup lang="ts">
import profile from "@/assets/fake/profile.jpeg";
import banane from "@/assets/banane.png";

</script>

<template>
  <div class="flex justify-between w-full h-full items-center px-4">
    <div class="flex gap-2 items-center">
      <div class="rounded-full overflow-hidden">
        <v-img :src="profile" width="48" height="48"/>
      </div>

      <div class="flex flex-col gap-1 justify-center">
        <h1 class="text-3xl">
          #145
        </h1>
        <div class="text-lg text-gray-500 pr-2 one-line">
          Arthur Nobrega
        </div>
      </div>
    </div>

    <div class="bg-gray-400 bg-opacity-40 rounded-lg p-2 flex justify-end gap-2">
      <h1 class="text-xl">
        123456
      </h1>
      <v-img :src="banane" class="h-6 w-6" :transition="false"/>
    </div>
  </div>
</template>
