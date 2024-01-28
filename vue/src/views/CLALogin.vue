<script lang="ts" setup>
import {useRouteQuery} from '@vueuse/router'
import router from "@/router";
import {type Ref} from "vue";
import axios from "axios";

const ticket = useRouteQuery('ticket') as Ref<string | null>

if (ticket.value == null) {
  router.replace("/login")
} else {
  axios.get("/cla_login", {params: {ticket: ticket.value}}).then(({data}) => {
    if (data.ok) {
      localStorage.setItem("token", data.token)
      router.replace("/")
    } else {
      router.replace("/login")
    }
  })
}


</script>


<template>
  <div></div>
</template>
