self.addEventListener('install', function (event) {
  event.waitUntil(
    caches.open('mowglille-cache').then(function (cache) {
      return cache.addAll([
        '/',
        '/index.html',
        '/chest/epic.mp4',
        '/chest/intro.mp4',
        '/chest/loop.mp4',
        '/service-worker.js',
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
