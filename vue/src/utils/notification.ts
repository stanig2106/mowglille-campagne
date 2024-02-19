import {doItOnline} from "@/router/offline";

export async function notification_init() {

  window.addEventListener('ios-fcm-token' as any,
    (e: CustomEvent) => {
      localStorage.setItem('fcm_token', e.detail);
    })

  if (!("Notification" in window))
    return

  await Notification.requestPermission()

  navigator.serviceWorker.ready.then(async (serviceWorkerRegistration) => {
    const subscription = await serviceWorkerRegistration.pushManager.getSubscription()
    if (subscription) return localStorage.setItem('fcm_token', JSON.stringify(subscription))

    serviceWorkerRegistration.pushManager
      .subscribe({
        userVisibleOnly: true,
        applicationServerKey: urlBase64ToUint8Array(
          "BJ_orCncvdUdrIi58YEEmxFCgNTVqgqGE-KbzMTEoLlPHOPs-KHNKW8_W2YHr8Du2eASXaP87cI-nzbrsg-y2eA"
        )
      }).then((t) => {
      localStorage.setItem('fcm_token', JSON.stringify(t))
    }).catch((r) => console.error(r))
  });
}

export function saveSubscription() {
  const subscription = localStorage.getItem('fcm_token')
  if (!subscription) return
  if (localStorage.getItem('token') === null) return

  return doItOnline({
    method: 'post',
    url: '/notification/subscribe',
    data: {subscription}
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


