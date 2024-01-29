<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {useOnline} from "@vueuse/core";
import DownloadSoutientActif from "@/views/profile/DownloadSoutientActif.vue";
import {provide, ref} from "vue";

const userStore = useUserStore()

if (useOnline().value)
  userStore.updateUser()

const keep_open = ref(false)

provide("keep_open", keep_open)

</script>


<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col mt-[100px] elevation-2 min-h-[calc(100%-100px)] relative">
    <div class="z-10 rounded-full bg-red-500 w-2/3 aspect-square -mt-[100px] self-center relative">
        <v-btn class="absolute bottom-6 -left-2" color="white" icon rounded="lg">
          <v-img :transition="false" class="h-6 w-6" src="@/assets/laurel-wreath.png"/>
          <v-dialog activator="parent" :persistent="keep_open" :close-on-back="false" :no-click-animation="true">
            <download-soutient-actif/>
          </v-dialog>
        </v-btn>

      <v-btn class="absolute bottom-6 -right-2" color="white" icon rounded="lg">
        <v-icon color="black">mdi-pencil</v-icon>
      </v-btn>
    </div>
    <div class="bg-gray-200 -mt-4 pt-6 p-2 px-8">
      <h2 class="text-3xl text-center one-line">
        {{ userStore.name }}
      </h2>
      <div class="flex justify-between text-xl mt-2">
        <div>
          #{{ userStore.rank == 0 ? "-" : userStore.rank ?? "-" }}
        </div>
        <div class="flex gap-2 items-center">
          {{ userStore.score ?? "-" }}
          <v-img :transition="false" class="h-6 w-6" src="@/assets/honey.png"/>
        </div>
      </div>
    </div>

  </div>

</template>

