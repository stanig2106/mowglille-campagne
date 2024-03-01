<script lang="ts" setup>

defineProps<{
  piece_count: number
  chest_count: number
}>()

const emit = defineEmits<{
  click: [void]
}>()

</script>

<template>
  <div v-ripple :class="{ 'bg-yellow-300': chest_count > 0}"
       class="bg-gray-200 w-full flex gap-2 rounded-lg p-2 items-center"
       @click="emit('click')">
    <v-icon size="48">
      mdi-treasure-chest
    </v-icon>
    <div class="flex flex-col justify-center">
      <h2 class="text-xl font-bold">
        {{ piece_count }} / 20 Pièces trouvées
      </h2>
      <div v-if="chest_count == 0" class="text-muted">
        Ouvre ta collection
      </div>
      <div v-else class="text-muted">
        {{ chest_count }} coffre{{ chest_count > 1 ? "s" : "" }} à ouvrir !
      </div>
    </div>
  </div>

</template>

