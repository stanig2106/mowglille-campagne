import {InjectionKey, Ref} from "vue";


export const offlineKey = Symbol() as InjectionKey<{
  offline: Ref<boolean>,
  updateOffline: (value: boolean) => void
}>
