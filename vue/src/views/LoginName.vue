<script setup lang="ts">


import {useVModels} from "@vueuse/core";
import {ref} from "vue";

const props = defineProps<{
  first_name: string,
  last_name: string
}>();

const emit = defineEmits<{
  "update:first_name": [string],
  "update:last_name": [string],
  continue: []
}>()

const {first_name, last_name} = useVModels(props, emit)
const error = ref("")

function _continue() {
  if (first_name.value.length == 0) {
    error.value = "Le prénom ne peut pas être vide"
    return
  }
  if (last_name.value.length == 0) {
    error.value = "Le nom ne peut pas être vide"
    return
  }
  emit("continue")
}

</script>

<template>
  <form @submit.prevent="_continue">
    <v-card elevation="10" rounded="xl">

      <div class="p-8">
        <v-img src="@/assets/logo_text.png" class="w-[45vw] mx-[15vw] -mt-2 mb-6" contain/>


        <div class="mb-2">
          <label for="first_name" class="text-xl font-extrabold">PRENOM :</label>
        </div>
        <v-text-field variant="solo-filled" v-model="first_name" density="compact"
                      @input="error = ''" @focus="error = ''"
                      class="*:text-xl *:font-bold mb-2" hide-details="auto"/>

        <div class="mb-2">
          <label for="last_name" class="text-xl font-extrabold">NOM :</label>
        </div>
        <v-text-field variant="solo-filled" v-model="last_name" density="compact"
                      @input="error = ''" @focus="error = ''"
                      class="*:text-xl *:font-bold"/>

        <div v-if="error" class="text-red-500 text-sm font-bold mb-3 -mt-2">
          {{ error }}
        </div>

        <v-btn color="primary" class="w-full" rounded="lg" type="submit">
          <span class="font-extrabold text-uppercase text-2xl">
          Continuer
          </span>
        </v-btn>

      </div>

    </v-card>
  </form>
</template>

<style>
.v-input__details {
  @apply font-normal text-sm;
}
</style>
