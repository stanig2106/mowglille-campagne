import {InjectionKey, Ref} from "vue";

export type Inform = {
  title: string,
  message: string,
  show: boolean
  actions: {
    label: string,
    callback: () => void
  }[]
}
export const informKey: InjectionKey<Inform> = Symbol("inform");
export const informShowKey: InjectionKey<(title: string, message: string) => void> = Symbol("informShow");
