import axios from "axios";

export async function notification_init() {
  if (!("Notification" in window))
    return

  await Notification.requestPermission()

  navigator.serviceWorker.ready.then(async (serviceWorkerRegistration) => {
    console.log("serviceWorkerRegistration", serviceWorkerRegistration)
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

function saveSubscription(subscription: PushSubscription) {
  return axios.post('/subscribe_notifications', {
    subscription: subscription.toJSON()
  })
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


