import {cleanupOutdatedCaches, precacheAndRoute} from 'workbox-precaching'

declare let self: ServiceWorkerGlobalScope

cleanupOutdatedCaches()

precacheAndRoute(self.__WB_MANIFEST)

self.addEventListener('push', (event) => {

  const data = event.data?.json();
  if (!data) return;

  if (data.type === 'notification') {
    event.waitUntil(
      self.registration.showNotification(data.title, {
        body: data.body,
        data: {path: data.path}
      })
    )
  }
});


self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  const fullPath = self.location.origin + event.notification.data.path;
  //@ts-ignore
  clients.openWindow(fullPath);
});


