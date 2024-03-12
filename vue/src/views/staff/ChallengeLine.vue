<script lang="ts" setup>


import {Challenges} from "@/stores/challenges_store";
import honey from "@/assets/honey.webp";
import {dateToS} from "../games/safariSprint/core/utils";
import {useSlots} from "vue";

const props = defineProps<{
  challenge: Challenges[number]
  userShow?: boolean
}>()

const slots = useSlots()

</script>

<template>
  <v-card
    variant="tonal" @click="">
    <div class="p-2 flex gap-2 justify-between">
      <div>
        <h3 :class="{'text-green-600': challenge.validated}" class="flex items-center gap-2">
          <v-icon v-if="challenge.validated" size="24">mdi-check</v-icon>
          <v-icon v-if="challenge.start_date || challenge.end_date" size="24">mdi-clock</v-icon>
          <v-icon v-if="challenge.amount" size="24">mdi-account-clock</v-icon>
          {{ challenge.name }}
        </h3>
        <p class="ml-1">
          {{ challenge.description }}
        </p>
      </div>

      <div class="flex gap-2 flex-col">
        <div class="flex gap-2 items-center justify-end">
          {{ challenge.score }}
          <div>
            <v-img :src="honey" height="24" width="24"/>
          </div>
        </div>
        <div v-if="!userShow">
          Cat. {{ challenge.category }}
        </div>
      </div>
    </div>

    <v-dialog #default="{isActive}" activator="parent">
      <v-card>
        <div class="p-4">
          <h2 class="one-line mb-4">{{ challenge.name }}</h2>
          <div class="flex flex-col gap-4">
            <p>
              {{ challenge.description }}
            </p>
            <p class="flex gap-2 items-center">
              Miel à gagner : {{ challenge.score }}
              <span>
                <v-img :src="honey" height="20" width="20"/>
              </span>
            </p>
            <p class="flex gap-2 items-center">
              <span><v-icon size="24">mdi-account-clock</v-icon></span>
              <template v-if="!userShow">
                Nombre de validations max : {{ challenge.amount || "Illimité" }}
              </template>
              <template v-else>
                Nombre de validations : {{ challenge.validation }}
                <template v-if="challenge.amount">/ {{ challenge.amount }}</template>
              </template>
            </p>
          </div>
        </div>
        <v-card-actions>
          <v-spacer v-if="!slots.default"/>
          <v-btn @click="isActive.value = false">Fermer</v-btn>
          <slot :isActive="isActive" name="actions"/>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-card>
</template>
