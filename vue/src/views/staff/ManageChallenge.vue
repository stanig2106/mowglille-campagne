<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {inject, reactive, ref} from "vue";
import {informShowKey} from "@/router/keys";
import {doItOnline} from "@/router/offline";
import {useChallengesStore} from "@/stores/challenges_store";
import ChallengeLine from "@/views/staff/ChallengeLine.vue";

const currentUser = useUserStore()
currentUser.updateUser()

const d_value = {
  category: null,
  id: null,
  name: "",
  description: "",
  score: null,
  start_date: null,
  end_date: null,
  amount: null,
}

const new_challenge = reactive({...d_value})

const informShow = inject(informShowKey)!

async function submit() {
  if (new_challenge.name.length == 0 || new_challenge.description.length == 0)
    return onError("Veuillez remplir tous les champs")

  if (new_challenge.score == null || new_challenge.score <= 0)
    return onError("Le score doit être supérieur à 0")

  if ((new_challenge.amount || 1) <= 0)
    return onError("Le nombre de validation max doit être supérieur à 0")

  await doItOnline({
    method: "post", url: "/challenges",
    data: {...new_challenge}
  }, {
    title: "Créer un défi",
    message: "Création du défi " + new_challenge.name
  })?.then(() => {
    challengesStore.updateChallenges()
  })

  Object.assign(new_challenge, d_value)

  return Promise.resolve()
}

const challengesStore = useChallengesStore()
challengesStore.updateChallenges()

function onError(message: string) {
  informShow("Erreur", message)
  return Promise.reject(message)
}

function delete_challenge({id, name}: { id: number, name: string }) {
  return doItOnline({
    method: "delete", url: `/challenges/${id}`
  }, {
    title: "Supprimer un défi",
    message: "Suppression du défi " + name
  })?.then(() => challengesStore.updateChallenges())
}

const isEditing = ref(false)

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <v-btn color="secondary" size="large">
      Créer un challenge
      <v-dialog v-model="isEditing" activator="parent" persistent>
        <template #default="{isActive}">
          <v-card>
            <v-card-title>
              <span class="headline">
                {{ isEditing ? "Modifier" : "Créer" }} un défi
              </span>
            </v-card-title>
            <v-card-text>
              <v-select v-model="new_challenge.category"
                        :items="[{ title: 'Défi flash', value: 'flash' },
                        { title: 'Défi bzzz bzzz', value: 'bzzz' },
                        { title: 'Défi mielleux au miel', value: 'mielleux' },
                        { title: 'Défi de zinzin', value: 'zinzin' }]"
                        label="Catégorie" required/>

              <v-text-field v-model="new_challenge.name" label="Nom du challenge" required/>
              <v-textarea v-model="new_challenge.description" label="Description" required/>
              <v-text-field v-model.number="new_challenge.score" label="Score" required/>

              <v-text-field v-model.number="new_challenge.amount" label="Nombre de validation max (optionnel)"/>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn @click="isActive.value = false">Annuler</v-btn>
              <v-btn color="secondary"
                     @click="submit().then(() => isActive.value = false)">
                {{ isEditing ? "Modifier" : "Créer" }}
              </v-btn>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>
    </v-btn>


    <div class="mt-4 overflow-y-auto flex flex-col gap-2">
      <challenge-line v-for="challenge in challengesStore.challenges" :key="challenge.id"
                      :challenge="challenge">
        <template #actions="{isActive}">
          <v-spacer/>
          <v-btn color="red">
            Supprimer
            <v-dialog #default="{isActive: isActive2}" activator="parent">
              <v-card>
                <v-card-title>
                  <span class="headline">Supprimer le défi</span>
                </v-card-title>
                <v-card-text>
                  <p>
                    Êtes-vous sûr de vouloir supprimer le défi {{ challenge.name }} ?
                  </p>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn @click="isActive.value = false">Annuler</v-btn>
                  <v-btn color="secondary" @click="delete_challenge(challenge);
                             isActive.value = false; isActive2.value = false">
                    Supprimer
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-btn>
          <v-btn color="secondary" @click="Object.assign(new_challenge, {
                ...challenge,
                start_date: challenge.start_date ? new Date(challenge.start_date).toISOString().slice(0, 16) : '',
                end_date: challenge.end_date ? new Date(challenge.end_date).toISOString().slice(0, 16) : ''
              }); isEditing = true; isActive.value = false">
            Modifier
          </v-btn>
        </template>

      </challenge-line>
    </div>


  </div>
</template>
