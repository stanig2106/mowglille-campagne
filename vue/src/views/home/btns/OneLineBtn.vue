<script lang="ts" setup>

import {withDefaults} from "vue"

const props = withDefaults(defineProps<{
  title: string
  icon: string
  iconSize: number
  disabled?: boolean
}>(), {
  disabled: false
})

const emit = defineEmits<{
  click: [void]
}>()

</script>

<template>
  <div v-ripple="!disabled" :class="disabled ? 'opacity-40' : ''"
       class="bg-gray-200 flex gap-2 rounded-lg p-2 items-center"
       @click="emit('click')">
    <v-icon :size="props.iconSize">
      {{ props.icon }}
    </v-icon>
    <h2 class="text-xl font-bold one-line">
      {{ props.title }}
    </h2>
  </div>

</template>

