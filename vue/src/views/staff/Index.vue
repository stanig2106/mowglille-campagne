<script lang="ts" setup>
/*
STAFF_ROLES = {
NEW_STAFF: "Create new staff",

  CUSTOM_SCORE: "Add custom score",
  SCORE: "Add legal score",
  MANAGE_SCORE: "Manage legals score of activities",

  CHALLENGE_MANAGE: "Manage challenge",
  CHALLENGE_VALIDATION: "Validate challenge",

  MANAGE_SOUND: "Manage sound",

  MANAGE_CHAT: "Manage chat",

  MANAGE_PHOTO: "Manage photo",
}
*/
import {useUserStore} from "@/stores/user_store";
import {computed} from "vue";

const staffs_action = [
  {
    path: "/staff/planning",
    name: "Voir les plannings",
    icon: "mdi-calendar",
    roles: ["SEE_PLANNING"]
  },
  {
    path: "/staff/manage_planning",
    name: "Gérer les plannings",
    icon: "mdi-calendar-edit",
    roles: ["MANAGE_PLANNING"]
  },
  {
    path: "/staff/manage_staff",
    name: "Gérer les staffeurs",
    icon: "mdi-account-multiple-plus",
    roles: ["NEW_STAFF"]
  },
  {
    path: "/staff/activity",
    name: "Staff Activité en cours",
    icon: "mdi-party-popper",
    roles: ["SCORE"]
  },
  {
    path: '/staff/offer',
    name: "Offrir du score",
    icon: "mdi-gift",
    roles: ["CUSTOM_SCORE"]
  },
  {
    path: '/staff/manage_score',
    name: "Gérer les activités",
    icon: "mdi-pencil",
    roles: ["MANAGE_SCORE"]
  },
  {
    path: '/staff/validate_challenge',
    name: "Valider un défi",
    icon: "mdi-trophy-variant",
    roles: ["CHALLENGE_VALIDATION"]
  },
  {
    path: '/staff/manage_challenge',
    name: "Gérer les défis",
    icon: "mdi-format-list-bulleted-type",
    roles: ["CHALLENGE_MANAGE"]
  },
  {
    path: '/staff/manage_sound',
    name: "Gérer les sons",
    icon: "mdi-music",
    roles: ["MANAGE_SOUND"]
  },
  {
    path: '/staff/manage_photo',
    name: "Gérer les albums",
    icon: "mdi-camera",
    roles: ["MANAGE_PHOTO"]
  },
]

const currentUser = useUserStore()
currentUser.updateUser()

const allowed_actions = computed(() =>
  staffs_action.filter(action => action.roles.some(role => currentUser.staffRoles?.includes(role)))
)
</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">

    <div class="flex justify-between flex-wrap gap-6">
      <v-card v-for="action in allowed_actions"
              :key="action.name"
              class="text-2xl aspect-square flex-1 min-w-[40%]"
              @click="$router.push(action.path)"
      >
        <div class="flex flex-col justify-between items-center h-full p-4">
          <v-icon> {{ action.icon }}</v-icon>
          <span class="text-center" v-text="action.name"/>
        </div>
      </v-card>

      <div v-if="allowed_actions.length % 2 == 1"
           class="flex-1 min-w-[40%]"/>
    </div>

  </div>
</template>
