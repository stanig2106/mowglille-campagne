<script lang="ts" setup>

import {useAttrs, useSlots} from "vue";

const props = defineProps<{
  duration: number
  startLabel: string
  endLabel?: string
  topLine?: boolean
  bottomLine?: boolean
}>()

const minToPxRatio = 1.5 as const

const slot = useSlots();

const attrs = useAttrs()
</script>

<template>
  <div class="-mt-4 text-sm">
    {{ startLabel }}
  </div>
  <div :class="{'text-sm': duration < 30}"
       :style="{ height: duration * minToPxRatio + 'px' }"
       class="min-h-[30px] relative"
  >
    <div v-if="topLine" class="border-t border-gray-300 w-full -mt-1.5 absolute top-0"/>
    <div v-if="bottomLine" class="border-t border-gray-300 w-full -mb-0.5 absolute bottom-0"/>
    <v-card v-if="slot.default"  class="h-full rounded-lg"
            v-bind="{...attrs}">
      <slot/>
    </v-card>
  </div>
  <template v-if="endLabel">
    <div class="-mt-4 text-sm">
      {{ endLabel }}
    </div>
    <div/>
  </template>
</template>

