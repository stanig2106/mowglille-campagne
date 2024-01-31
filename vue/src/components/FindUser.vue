<script lang="ts" setup>

import {ref, watch} from "vue";
import {useOnline, useVModel} from '@vueuse/core'
import {QrcodeStream} from "vue-qrcode-reader";
import {DetectedBarcode} from "barcode-detector/dist/es/BarcodeDetector";
import axios from "axios";
import {decrypt} from "@/core";

export type FoundUser = {
  id: number
  publicToken: string
  firstName: string
  lastName: string
  score: number
  cursus: string
}

const props = defineProps<{
  modelValue: FoundUser | null
}>()

const emit = defineEmits<{
  'update:modelValue': [value: FoundUser | null]
}>()

const model = useVModel(props, 'modelValue', emit)

const mode = ref<'search' | 'scan' | undefined>(undefined)

watch(mode, () => {
  if (mode.value == 'scan')
    qr_code_loading.value = true
})

const qr_code_loading = ref(true)
const qr_code_paused = ref(false)
const qr_code_scanned = ref(undefined as FoundUser | undefined)
const qr_code_error = ref("")
const qr_code_certified = ref('both_online' as 'both_offline' | 'staffer_online' | 'user_online' | 'both_online')

async function parseQrCode(content: string): Promise<FoundUser | { error: string }> {
  // decrypt content
  content = decrypt(content)

  if (content.startsWith("&")) {
    qr_code_certified.value = 'staffer_online'
    content = content.slice(1)
  }
  const [token, id, publicToken,
    firstName, lastName, score,
    cursus, date] = content.split("&")

  // date is too old (more than 5 minute)
  if (new Date(date).getTime() < Date.now() - 5 * 60 * 1000)
    return {error: "QR Code trop ancien, veuillez en générer un nouveau"}

  if (useOnline().value) {
    const res = axios.get("/check_qr_code/" + content)
      .catch(() => ({error: "Erreur inconnue, veuillez réessayer"}));
    const timeout = new Promise(resolve => setTimeout(resolve, 5000))

    const winner = Promise.race([res, timeout])
    const mark_staffer_offline = () => {
      if (qr_code_certified.value == 'both_online')
        qr_code_certified.value = 'user_online'
      else if (qr_code_certified.value == 'staffer_online')
        qr_code_certified.value = 'both_offline'
    }
    if (winner != timeout) {
      const r = await res
      if ("error" in r || r.status !== 200) mark_staffer_offline()
      else if (r.data.error) return {error: r.data.error}
    } else
      mark_staffer_offline()
  }

  return {
    id: parseInt(id),
    publicToken,
    firstName,
    lastName,
    score: parseInt(score),
    cursus,
  }
}

async function onScan(contents: DetectedBarcode[]) {
  const content = contents[0] as DetectedBarcode | undefined
  if (content == undefined) return

  qr_code_paused.value = true
  qr_code_loading.value = true

  const parsed = await parseQrCode(content.rawValue)

  qr_code_paused.value = false
  if ('error' in parsed) {
    qr_code_loading.value = false
    qr_code_error.value = parsed.error
    return
  }

  qr_code_scanned.value = parsed
}

function reset() {
  qr_code_paused.value = false
  qr_code_loading.value = false
  qr_code_error.value = ""
  qr_code_scanned.value = undefined
  qr_code_certified.value = 'both_online'
  mode.value = undefined
}

</script>

<template>
  <v-card>
    <v-card-title>
      Identifier un utilisateur
    </v-card-title>
    <v-card-text>
      <div class="flex flex-col gap-4 justify-between items-stretch h-full >:flex-grow">
        <v-card :class="{'!flex-grow-0': mode == 'search'}"
                :ripple="mode != 'scan'"
                @click="mode = 'scan'">
          <div v-if="mode != 'scan'"
               class="flex flex-col items-center justify-center gap-2 p-4 h-full text-xl">
            <v-icon>mdi-qrcode-scan</v-icon>
            Scanner un QR Code
          </div>
          <div v-else class="h-full">
            <qrcode-stream v-if="!qr_code_scanned && !qr_code_error" :formats="['qr_code']"
                           :paused="qr_code_paused"
                           class="h-full" @detect="onScan"
                           @camera-on="qr_code_loading = false">
              <div v-if="qr_code_loading"
                   class="h-full flex justify-center items-center text-xl">
                <v-progress-circular color="secondary" indeterminate/>
              </div>
            </qrcode-stream>
            <template v-else>

              <div v-if="qr_code_error" class="h-full text-xl flex-center text-red-500 text-center">
                {{ qr_code_error }}
              </div>
              <div v-else class="flex flex-col items-center justify-center gap-2 p-4 h-full text-xl">
                <v-icon color="green" size="large">mdi-check-circle</v-icon>
                <div class="text-2xl mt-2">
                  {{ qr_code_scanned!.firstName }} {{ qr_code_scanned!.lastName }}
                </div>
                <div class="text-md text-muted one-line">
                  {{ qr_code_scanned!.cursus }}
                </div>

                <div class="text-sm text-muted mt-4">
                  {{
                    qr_code_certified == 'both_online' ? 'Qr Code vérifié !' :
                      qr_code_certified == 'both_offline' ? 'Qr code non vérifié (staffer et utilisateur hors ligne)' :
                        qr_code_certified == 'staffer_online' ? 'Qr code hors ligne vérifié' :
                          'Qr code vérifié par l\'utilisateur'
                  }}

                </div>

              </div>
            </template>
          </div>
        </v-card>
        <div :class="{'!flex-grow-0': mode == 'scan'}"
             class="flex gap-2 >:flex-1">
          <v-card v-if="!(mode == 'scan' && qr_code_scanned)"
                  :ripple="mode != 'search'"
                  @click="mode = 'search'">
            <div v-if="mode != 'search'"
                 class="flex flex-col items-center justify-center gap-2 p-4 h-full text-xl">
              <v-icon>mdi-account-search</v-icon>
              Rechercher
            </div>
          </v-card>
          <v-card v-if="mode == 'scan' && (qr_code_error || qr_code_scanned)" @click="qr_code_error = ''; qr_code_scanned = undefined; qr_code_loading = true">
            <div class="flex flex-col items-center justify-center gap-2 p-4 h-full text-xl">
              <v-icon>mdi-reload</v-icon>
              Réessayer
            </div>
          </v-card>
          <v-card v-if="mode == 'scan' && qr_code_scanned" @click="model = qr_code_scanned; reset()">
            <div class="flex flex-col items-center justify-center gap-2 p-4 h-full text-xl text-green">
              <v-icon color="green">mdi-check</v-icon>
              Valider
            </div>
          </v-card>


        </div>
      </div>
    </v-card-text>
    <v-card-actions>
      <v-spacer/>
      <v-btn @click="model = null">
        Annuler
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<style>
* {
  transition: flex-grow 0.3s ease;
}
</style>
