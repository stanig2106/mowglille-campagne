<script lang="ts" setup>

const emit = defineEmits<{
  click: [void]
}>()

</script>

<template>
  <div v-ripple class="bg-gray-200 w-full flex gap-2 rounded-lg p-2 items-center"
       @click="emit('click')">
    <v-icon size="48">
      mdi-treasure-chest
    </v-icon>
    <div class="flex flex-col justify-center">
      <h2 class="text-2xl font-bold">
        7 / 24 Pièces trouvées
      </h2>
      <h3 class="text-gray-500">
        Ouvre ta collection
      </h3>
    </div>
  </div>

</template>

