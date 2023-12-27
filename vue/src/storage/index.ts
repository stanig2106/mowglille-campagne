import {reactive, ref, Ref} from "vue";

interface StorageKey<T> extends Symbol {
}

export function StorageKey<T>(description: string): StorageKey<T> {
  return Symbol(description) as StorageKey<T>;
}

const storage = new Map<StorageKey<any>, {
  updater: () => Promise<any>,
  defaultValue: any
}>()

export const UNCHANGED = Symbol('unchanged');

export function createStorage<T>(key: StorageKey<T>, defaultValue: T, updater: () => Promise<T | typeof UNCHANGED>) {
  let quit = false;
  storage.forEach((_, storageKey) => {
    if (storageKey.description === key.description && storageKey !== key) {
      quit = true;
      throw new Error('Storage key with same description already exists');
    }
  })
  if (quit)
    return;
  storage.set(key, {
    updater, defaultValue
  });
}


export function getStorage<T>(key: StorageKey<T>): T extends Object ? T : Ref<T> {
  const s = storage.get(key);
  if (s == undefined)
    throw new Error('Storage key not found');
  const local = localStorage.getItem('storage' + key.description)
  const data: T = local == null ? s.defaultValue : JSON.parse(local)
  const res: T extends Object ? T : Ref<T> = (data instanceof Object ? reactive(data) : ref(data)) as unknown as T extends Object ? T : Ref<T>;
  s.updater().then((value: T | typeof UNCHANGED) => {
    if (value !== UNCHANGED)
      return
    setStorage(key, value)
    if (value instanceof Object)
      Object.assign(res, value)
    else
      (res as Ref<T>).value = value as T
  })
  return res;
}

export function setStorage<T>(key: StorageKey<T>, value: T) {
  if (!storage.has(key))
    throw new Error('Storage key not found');
  localStorage.setItem('storage' + key.description, JSON.stringify(value));
}
