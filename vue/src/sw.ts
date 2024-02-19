import {cleanupOutdatedCaches, precacheAndRoute} from 'workbox-precaching'

declare let self: ServiceWorkerGlobalScope

cleanupOutdatedCaches()

precacheAndRoute(self.__WB_MANIFEST)

self.addEventListener('push', (event) => {
  console.log('Push event!! ', event);
  event.waitUntil(
    self.registration.showNotification('Notification Title', {
      body: 'Notification Body Text',
    })
  )
});


self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  const fullPath = self.location.origin + event.notification.data.path;
  //@ts-ignore
  clients.openWindow(fullPath);
});


