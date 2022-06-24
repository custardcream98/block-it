'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "e84b9ce5d62dd0b3f17599448ad5c92a",
"favicon.ico": "09e8515b0001c9ecf213fd9116bd741b",
"index.html": "d36bee87edbeb340424ebf07086f79b6",
"/": "d36bee87edbeb340424ebf07086f79b6",
"main.dart.js": "4df2a62f0f30af9f24808a83c7f8fdf8",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"favicon.png": "a4e79ddd0c80e79ecfd3a93a2ef5a794",
"icons/favicon-16x16.png": "389c16e42adcafadad1618686c19bd33",
"icons/apple-icon.png": "10557d9bd2e716878d4da6e37ce9c202",
"icons/apple-icon-144x144.png": "beb54e16c0349448362a4af81bbfae0f",
"icons/android-icon-192x192.png": "04749e509016908924fb0c0074936c7d",
"icons/apple-icon-precomposed.png": "10557d9bd2e716878d4da6e37ce9c202",
"icons/apple-icon-114x114.png": "9c098293787c769b7432cc5828f478c1",
"icons/ms-icon-310x310.png": "689317d51f8edb3f6bc10edb78109e7b",
"icons/ms-icon-144x144.png": "beb54e16c0349448362a4af81bbfae0f",
"icons/apple-icon-57x57.png": "422b62b23dd6a774ed378a2ec1701675",
"icons/apple-icon-152x152.png": "b75a6cda0c25c9c880ceba7cf9620919",
"icons/ms-icon-150x150.png": "bbd5ea6c13f70b8b2d9a70ad262f7699",
"icons/android-icon-72x72.png": "674d9b4cc201465039365447bca79e8c",
"icons/android-icon-96x96.png": "29981002a922970d76fffcc1d00c6e9c",
"icons/android-icon-36x36.png": "2f1c957e2aa57acab435493b8a28378e",
"icons/apple-icon-180x180.png": "a4fe633da3fc3acfd7d47d69f9898373",
"icons/favicon-96x96.png": "29981002a922970d76fffcc1d00c6e9c",
"icons/android-icon-48x48.png": "e7da287a42f6eebaf9ad6cba8b30f932",
"icons/apple-icon-76x76.png": "078f5f3aea98bc1aa766d5922a882489",
"icons/apple-icon-60x60.png": "2b1b820754c3e2ae1f03f196cacb36ec",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/android-icon-144x144.png": "beb54e16c0349448362a4af81bbfae0f",
"icons/apple-icon-72x72.png": "674d9b4cc201465039365447bca79e8c",
"icons/apple-icon-120x120.png": "1002086b5c8a1cd84dd8c750c5333073",
"icons/favicon-32x32.png": "a80956351ef221b745a3dbbec27e0b05",
"icons/ms-icon-70x70.png": "328d589007cf562d57427227310801df",
"manifest.json": "b0b896993313c9ffbf7a2f04fefd83a0",
"assets/AssetManifest.json": "bda2366707b7f07af78e2cc4d12584b5",
"assets/NOTICES": "939befc073e3521002e7fe20a8f0dd0a",
"assets/FontManifest.json": "42d0c654f5f4efa465c9f74999ac35c1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/lib/core/assets/icons/palette.png": "7f2da07f8518772ccade15f7a9e67874",
"assets/lib/core/assets/icons/markdown.png": "42285c149a46bd5482bb27f431883182",
"assets/lib/core/assets/icons/box.png": "dab3b5d57129e9fc64dd862f50d7bf86",
"assets/lib/core/assets/fonts/Nanum_Myeongjo/NanumMyeongjo-Bold.ttf": "5ea37dfbbfbd9fb13421ffc6032f150a",
"assets/lib/core/assets/fonts/Nanum_Myeongjo/NanumMyeongjo-Regular.ttf": "efdc1f63c31b3c0acc07777c2c2d8b38",
"assets/lib/core/assets/fonts/Nanum_Myeongjo/NanumMyeongjo-ExtraBold.ttf": "bf37d995db642e86d6d45f2388e00a9b",
"assets/lib/core/assets/fonts/Noto_Color_Emoji/NotoColorEmoji.ttf": "e0e141083ec8960372e6fa96940d0721",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
