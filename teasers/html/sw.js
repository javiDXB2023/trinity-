// JARVIS Service Worker
const CACHE_NAME = 'jarvis-v1.0.0';
const ASSETS = [
  '/jarvis-assistant.html',
  '/jarvis-mindmap.html',
  '/jarvis-terminal.html',
  '/jarvis-cheatsheet.html',
  '/manifest.json',
  'https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500&display=swap'
];

// Install - cache assets
self.addEventListener('install', (event) => {
  console.log('[JARVIS SW] Installing...');
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('[JARVIS SW] Caching assets');
      return cache.addAll(ASSETS);
    })
  );
  self.skipWaiting();
});

// Activate - clean old caches
self.addEventListener('activate', (event) => {
  console.log('[JARVIS SW] Activating...');
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.filter((key) => key !== CACHE_NAME)
            .map((key) => caches.delete(key))
      );
    })
  );
  self.clients.claim();
});

// Fetch - serve from cache, fallback to network
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((cached) => {
      if (cached) {
        return cached;
      }
      return fetch(event.request).then((response) => {
        // Cache new requests
        if (response.status === 200) {
          const clone = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, clone);
          });
        }
        return response;
      }).catch(() => {
        // Offline fallback
        if (event.request.destination === 'document') {
          return caches.match('/jarvis-assistant.html');
        }
      });
    })
  );
});

// Background sync for API calls
self.addEventListener('sync', (event) => {
  if (event.tag === 'jarvis-sync') {
    console.log('[JARVIS SW] Background sync');
  }
});

// Push notifications
self.addEventListener('push', (event) => {
  const data = event.data?.json() || {};
  const options = {
    body: data.body || 'JARVIS has a message for you',
    icon: '/icons/icon-192.png',
    badge: '/icons/icon-72.png',
    vibrate: [100, 50, 100],
    data: { url: data.url || '/jarvis-assistant.html' }
  };
  event.waitUntil(
    self.registration.showNotification(data.title || 'JARVIS', options)
  );
});

// Notification click
self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  event.waitUntil(
    clients.openWindow(event.notification.data.url)
  );
});

console.log('[JARVIS SW] Service Worker loaded');
