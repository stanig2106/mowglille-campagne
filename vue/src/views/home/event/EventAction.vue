<script lang="ts" setup>

const props = defineProps<{
  title: string
  subtitle: string
  icon: string
}>()

const emit = defineEmits<{
  click: [void]
}>()

</script>

<template>
  <div class="flex gap-2 items-stretch">
    <div v-ripple
         class="bg-white rounded-lg elevation-2 p-2 flex justify-center items-center h-16 w-16"
         @click="emit('click')">
      <v-icon size="48">
        {{ props.icon }}
      </v-icon>
    </div>

    <div v-ripple
         class="bg-white rounded-lg elevation-2 flex flex-col justify-center px-2 w-full h-16"
         @click="emit('click')">
      <h2 class="text-2xl font-bold">
        {{ props.title }}
      </h2>
      <h3 class="text-gray-500">
        {{ props.subtitle }}
      </h3>
    </div>
  </div>

</template>
