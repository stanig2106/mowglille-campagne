<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed} from "vue";

const currentUser = useUserStore()
currentUser.updateUser()

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">

    <div class="flex justify-between flex-wrap gap-6">
    </div>

  </div>
</template>
