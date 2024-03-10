<script lang="ts" setup>

const props = defineProps<{
  title: string
  subtitle: string
  icon: string
  disabled?: boolean
  link?: string
}>()

const emit = defineEmits<{
  click: [void]
}>()

</script>

<template>
  <div class="flex gap-2 items-stretch">
    <v-card :disabled="disabled" class="h-16 w-16 shrink-0"
            elevation="2" @click="emit('click')">
      <div class="bg-white rounded-lg p-2 flex justify-center items-center">
        <v-icon size="48">
          {{ props.icon }}
        </v-icon>
      </div>
    </v-card>

    <v-card :disabled="disabled" class="w-full" v-if="!link"
            elevation="2" @click="emit('click')">
      <div class="bg-white rounded-lg flex flex-col justify-center p-2 w-full h-16">
        <h2 class="text-2xl font-bold">
          {{ props.title }}
        </h2>
        <h3 class="text-gray-500">
          {{ props.subtitle }}
        </h3>
      </div>
    </v-card>

    <v-card :disabled="disabled" class="w-full" v-else
            elevation="2" :href="link" type="a" target="_blank">
      <div class="bg-white rounded-lg flex flex-col justify-center p-2 w-full h-16">
        <h2 class="text-2xl font-bold">
          {{ props.title }}
        </h2>
        <h3 class="text-gray-500">
          {{ props.subtitle }}
        </h3>
      </div>
    </v-card>


  </div>

</template>
