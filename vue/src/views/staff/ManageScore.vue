<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed} from "vue";
import {useEventsStore} from "@/stores/events_store";
import router from "@/router";
import {typeToString} from "@/utils/event";
import {VueShowdown as Showdown} from 'vue-showdown';

const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("MANAGE_SCORE"))
  router.replace("/")

const eventsStore = useEventsStore()
eventsStore.updateEvents()


</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">

    <div class="text-2xl">
      Activité à modifier
    </div>


<!--    <Showdown :options="{-->
<!--      underline: true,-->
<!--      emoji: true,-->
<!--    }"  />-->

    <div class="flex flex-col gap-6">
      <div v-for="event in eventsStore.events" :key="event.internalId">
        {{ typeToString(event.type) }} <br>
        {{ event.name }}
      </div>



    </div>

  </div>
</template>
