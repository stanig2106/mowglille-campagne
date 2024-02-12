<script lang="ts" setup>
import {computed, ref, useAttrs, useSlots, watch, watchEffect} from 'vue';
import {vOnClickOutside} from '@vueuse/components'

const props = withDefaults(
  defineProps<{
    color?: string,
    confirm_color?: string | null,
    confirm_text?: string | null,
    location?: string,
  }>(),
  {
    confirm_color: "red",
  },
);

const emit = defineEmits<{
  click: [event: MouseEvent]
}>();

const confirm = ref(false);

const handleClick = (event: MouseEvent) => {
  if (confirm.value) {
    confirm.value = false;
    emit("click", event);
  } else
    confirm.value = true;
};

const attrs = useAttrs();
const slots = useSlots();

const confirm_text = computed(() => {
  if (props.confirm_text === undefined)
    return "Cliquez à nouveau pour confirmer"
  else
    return props.confirm_text;
});


let timeout: any = null;
watch(confirm, (value) => {
  clearTimeout(timeout)
  if (value)
    timeout = setTimeout(() => confirm.value = false, 3000)
})

</script>

<template>
  <v-tooltip
    v-model="confirm"
    :close-on-content-click="true"
    :location="location as any"
    :open-on-hover="false"
    :text="confirm_text ?? undefined"
  >
    <template #activator="{props: p}">
      <v-btn
        v-if="slots.default"
        v-on-click-outside="() => confirm = false"
        :color="confirm ? (props.confirm_color ?? props.color) : props.color"
        v-bind="Object.assign({}, attrs, p)"
        @click="handleClick">
        <slot/>
      </v-btn>

      <v-btn
        v-else
        v-on-click-outside="() => confirm = false"
        :color="confirm ? (props.confirm_color ?? props.color) : props.color"
        v-bind="Object.assign({}, attrs, p)"
        @click="handleClick"/>
    </template>
  </v-tooltip>
</template>
