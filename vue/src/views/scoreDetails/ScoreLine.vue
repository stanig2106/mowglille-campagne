<script setup lang="ts">
import profile from "@/assets/fake/profile.jpeg";
import banane from "@/assets/banane.png";

</script>

<template>
  <div class="flex justify-between w-full h-full items-center px-4">
    <div class="flex gap-2 items-center">
      <div class="flex flex-col justify-center">
        <h1 class="text-xl">
          Activité banger
        </h1>
        <div class="text-lg text-gray-500 pr-2">
          Record de vitesse
        </div>
      </div>
    </div>

    <div class="flex flex-col gap-1">
      <div class="bg-gray-400 bg-opacity-40 rounded-lg p-2 flex justify-end gap-2">
        <h1 class="text-xl">
          +10
        </h1>
        <v-img :src="banane" class="h-6 w-6"/>
      </div>
      <div class="text-sm text-gray-500 flex justify-end">
        Aprèm, 14:12
      </div>
    </div>
  </div>
</template>
