<script lang="ts" setup>
import {computed, ref, watch} from "vue";
import {useSwipe, watchDebounced, watchThrottled} from "@vueuse/core";
import {ProfileImage} from "@/utils/profile_pictures";

const el = ref(null)
const swipe = useSwipe(el, {threshold: 30})
const swipeCanceled = ref(false)

const swipeOffset = computed(() => {
  if (swipeCanceled.value)
    return 0
  return swipe.lengthX.value < 0 ?
    Math.min(-1 * swipe.lengthX.value, 58) : 0
})

watchDebounced(
  swipe.isSwiping,
  (value) => {
    if (!value)
      swipeCanceled.value = true
  },
  {debounce: 100},
)

watch(swipe.isSwiping, (value) => {
  if (value)
    swipeCanceled.value = false
  else {
    if (swipe.lengthX.value < -48)
      emit('selected', true)
  }
})

const emit = defineEmits<{
  selected: [true]
}>()


</script>

<template>

  <div ref="el"
       :style="{ transform: `translateX(${swipeOffset}px)` }"
       class="flex gap-2 items-end relative"
       style="transition: transform 0.1s">
    <div class="absolute bottom-1.5 -left-5 -translate-x-full">
      <v-icon v-if="swipeOffset != 0" size="24">
        mdi-reply
      </v-icon>
    </div>

    <v-img :lazy-src="new ProfileImage('Mowgli').png()"
           class="rounded-full w-6 h-6 mb-1.5"/>
    <div class="w-full >:w-full">
      <div class="text-xs font-bold px-2 text-muted flex justify-between mb-1">
        <span class="mr-2 one-line">
        Mowgli
        </span>
        <span>
          14:20
        </span>
      </div>
      <div class="bg-white rounded-2xl p-2">
        <div class="text-sm">
          Sup bro
        </div>
      </div>
    </div>
  </div>
</template>
