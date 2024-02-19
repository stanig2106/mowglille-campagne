import axios from "axios";
import {doItOnline} from "@/router/offline";

export async function notification_init() {

  window.addEventListener('ios-fcm-token' as any,
    (e: CustomEvent) => saveSubscription(e.detail))

  if (!("Notification" in window))
    return

  await Notification.requestPermission()

  navigator.serviceWorker.ready.then(async (serviceWorkerRegistration) => {
    const subscription = await serviceWorkerRegistration.pushManager.getSubscription()
    if (subscription) return saveSubscription(subscription)

    serviceWorkerRegistration.pushManager
      .subscribe({
        userVisibleOnly: true,
        applicationServerKey: urlBase64ToUint8Array(
          "BJ_orCncvdUdrIi58YEEmxFCgNTVqgqGE-KbzMTEoLlPHOPs-KHNKW8_W2YHr8Du2eASXaP87cI-nzbrsg-y2eA"
        )
      }).then(saveSubscription).catch((r) => console.error(r))
  });
}

function saveSubscription(subscription: PushSubscription | string) {
  return doItOnline({
    method: 'post',
    url: '/notification/subscribe',
    data: {
      subscription: subscription instanceof PushSubscription ?
        JSON.stringify(subscription) : subscription
    }
  }, null)
}

function urlBase64ToUint8Array(base64String: string) {
  const padding = '='.repeat((4 - base64String.length % 4) % 4);
  const base64 = (base64String + padding)
    .replace(/-/g, '+')
    .replace(/_/g, '/');

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i)
    outputArray[i] = rawData.charCodeAt(i);
  return outputArray;
}


