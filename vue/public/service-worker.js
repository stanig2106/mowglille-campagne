self.addEventListener('install', function (event) {
  event.waitUntil(
    caches.open('mowglille-cache').then(function (cache) {
      return cache.addAll([
        '/',
        '/index.html',
        '/epic.mp4',
        '/intro.mp4',
        '/logo.png',
        '/manifest.json',
        '/favicon.ico',
      ]);
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request).then(function (response) {
      return response || fetch(event.request);
    })
  );
});
