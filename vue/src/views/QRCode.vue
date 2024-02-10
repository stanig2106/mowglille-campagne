<script lang="ts" setup>

import axios from "axios";
import {inject, onUnmounted, ref, watch} from "vue";
import Qrious from "vue-qrious";
import {storeToRefs} from "pinia";
import {useUserStore} from "@/stores/user_store";
import {encrypt} from "@/utils/encrypt";
import {useOffline} from "@/router/offline";

const {offline} = useOffline();

const {firstName, lastName, score, publicToken, id, cursus} = storeToRefs(useUserStore())
const {updateUser} = useUserStore()

updateUser()

function generateRandomString(length: number) {
  let result = '';
  const characters = encrypt('ABCDEFGHIJKLMNOPQRSTUVWXYZabcde' +
    'fghijklmnopqrstuvwxyz0123456789flksdjflqsjkdflqsjkflfkj');
  const charactersLength = characters.length;
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}

const offline_qr_code = () => '&' +
  generateRandomString(15) + "&" +
  id.value + "&" +
  publicToken.value + "&" +
  firstName.value + "&" +
  lastName.value + "&" +
  score.value + "&" +
  cursus.value + "&" +
  new Date().toISOString();


const qr_code_content = ref(encrypt(offline_qr_code()))
const loading = ref(null as boolean | null)


// every 60 seconds
const interval = setInterval(() => generateQRCode(), 60 * 1000)

onUnmounted(() => clearInterval(interval))

async function generateQRCode(force = false): Promise<any> {
  if (loading.value && !force) return
  loading.value = true
  const fake_loading = new Promise(resolve => setTimeout(resolve, 300))

  const content = await (async () => {
    if (offline.value) return offline_qr_code()
    const {data, status} = await axios.get("/qr_code").catch(() => ({data: undefined, status: 500}))
    if (status !== 200) {
      setTimeout(() => generateQRCode(true), 300)
      return null
    }
    return data.content as string
  })()
  if (content == null) return

  await fake_loading

  loading.value = false
  qr_code_content.value = encrypt(content)
}

watch(offline, () => generateQRCode())

generateQRCode()

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col justify-center elevation-2 h-full gap-4"
       @click="() => generateQRCode()">
    <div v-if="offline" class="text-center text-md text-red-500">
      QR Code hors ligne
    </div>
    <div class="w-full mb-4">
      <qrious id="qrcode" :class="{ 'blur-md': loading }" :size="1024" :value="qr_code_content"
              class="w-full mx-auto max-h-[60vh]"
      />
    </div>

    <h2 class="text-center text-2xl">
      Arthur Nobrega
    </h2>

    <span class="text-center text-gray-500 text-xs px-6">
      Ce QR Code est unique à votre compte et permet aux différents staffeurs
      de vous identifier. Il vous permettra de gagner des points. <br> <br>
      Attention, ce QR Code est valide qu'une seule fois et pendant 1 minute, cliquez sur
      l'écran pour en générer un nouveau.
    </span>
  </div>


</template>


<style lang="scss">
#qrcode {
  transition: filter 0.7s;
}
</style>
