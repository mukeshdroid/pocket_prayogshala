'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "c8eed9d7dcfeb732624e89e4080ed9a5",
"assets/assets/fonts/KRDEV510.TTF": "1d3d432d8790d99d6d9a4621a2ca79e4",
"assets/assets/fonts/KRDEV630.TTF": "857d25a73609c1937716db6371cc0f78",
"assets/assets/fonts/MyIcons.ttf": "2f11408b2a2eba3ecfa2a453d1a766f6",
"assets/assets/images/acibasebg.png": "3f217d2e8d18040bc993160f38bfa2d1",
"assets/assets/images/acid.jpg": "f377ac40d5c95ceeec8b7c2a42208904",
"assets/assets/images/acidbaseback.jpg": "bdce9705c6597c0df70aee886b1fc2eb",
"assets/assets/images/acidbasetable.png": "2f3ee603d3a897324fbbe6cbf6bdc0ad",
"assets/assets/images/acidButtonpressed.png": "82667d11acaedbb8f0635914bbac004e",
"assets/assets/images/acidButtonunpressed.png": "2c1d8f76896ae2ba458713370dd99505",
"assets/assets/images/arm.png": "3af2bce7f1e04082f8bae953733d8e4a",
"assets/assets/images/atom.jpg": "061a66a085211d6b546a3ce650a648d5",
"assets/assets/images/back.jpg": "6354700f4437b1899abc9a65768ad51a",
"assets/assets/images/basebuttonpressed.png": "79cb84c1b51dac3c4d510fb7a58bcc37",
"assets/assets/images/basebuttonunpressed.png": "efb400f447db65f52256f1a3b69d4d27",
"assets/assets/images/beaker.png": "9cc0636903ae37b8771ec2c025a8e33f",
"assets/assets/images/beakerMeth.png": "40a6f738bbc81e378dfa14e3c9ff9c6f",
"assets/assets/images/beakerPhen.png": "ba479be0c664e0143a6af0469fcaa7ca",
"assets/assets/images/betelnut1.png": "afb8d1028da1853c2313dfdcb06d0efa",
"assets/assets/images/betelnut2.png": "3a35a93d3abcc6c4621e11668d17f3cc",
"assets/assets/images/betelnut3.png": "902e5dd54f22061f9e773dcf65f324ac",
"assets/assets/images/betelnut4.png": "ad2000fcc5655c563f7af419a1edb9ad",
"assets/assets/images/betelnutcracked.png": "afb10a1bf94291efe98115a261de2d95",
"assets/assets/images/bg.jpg": "6d377fb67cf284af80338fa9fc249560",
"assets/assets/images/blackline_lever1.png": "7f5b1ed5d07906ddbb7cd1e38571ed47",
"assets/assets/images/blue.png": "15c701ed7720e0c6bd8cb670e51f1485",
"assets/assets/images/bluebox.png": "e7cb9d6f5e39df6a1f512a495c16f3da",
"assets/assets/images/boy.png": "21bd800e9b80de35f0f255f1c2bfbf35",
"assets/assets/images/chemical.jpg": "65e2b09cd2fb332a71cd2c9ac30ad5db",
"assets/assets/images/distillation.jpg": "ece9eeda69f3a5f4a0791d78ea085230",
"assets/assets/images/downArm.png": "9a5f625a3a6e0e586e6cb81bbccf6e98",
"assets/assets/images/downArm_old.png": "a5b311115558f758ab02b7af24b30f1c",
"assets/assets/images/flower.jpg": "3c8e7e590c2569fd793ddc39f8243d7e",
"assets/assets/images/girl.png": "4ffb22384b904a8d9bdad2f40587e3c0",
"assets/assets/images/grass.png": "f7cc645b8bdb90b5c4ed6f2fd7940f8f",
"assets/assets/images/kinetic.jpg": "b96efb00c79f31503d7ed812fa6d5fa1",
"assets/assets/images/lever2_bg.jpg": "f047affce94d42d11618026a00cbd5c0",
"assets/assets/images/logo.png": "b8b9456e6d406a456eb90502a83b1c19",
"assets/assets/images/nothing.png": "d4d6dafea9e7488ce9c790ae221487e5",
"assets/assets/images/nutcracker.jpeg": "e7b8afeb174b0afa78a488dbc2863b29",
"assets/assets/images/photo.jpg": "9625e9f868962ebcc90d7d5497be74a8",
"assets/assets/images/pipette.png": "1cc28b8ac544523e73b24f482e077041",
"assets/assets/images/pipetteempty.png": "1cc28b8ac544523e73b24f482e077041",
"assets/assets/images/pipettefull.png": "d954df7627e2e7c27236d078a6891f08",
"assets/assets/images/plank.png": "20406b18047c1dcfe53a4ebc2a5824e4",
"assets/assets/images/plankBase.png": "4ca54c1d01bf9c161445e73bba63d1d0",
"assets/assets/images/ppicon.png": "2075527c6e4236b7d774eb662c376a40",
"assets/assets/images/pressure.jpg": "4b59034d0668c6b0126ec5fe60f6f39d",
"assets/assets/images/prethahabhayobutton.png": "efadb4d06fb8db6d8aa4dd84b236a572",
"assets/assets/images/pretryagainbutton.png": "26efd455210e841cb62f0ac2497c9704",
"assets/assets/images/RedBall_lever1.png": "3ae9e9c612eca8561769ccb0d6ce74c7",
"assets/assets/images/Refraction-of-Light.jpg": "d8c18ab123d974323fdb30de38e29e7a",
"assets/assets/images/seed.jpeg": "45bf5a7a986141f3249bf5b287d8c60d",
"assets/assets/images/seed1.jpeg": "ab51a54e01cb0a9e844df5eb54f50d44",
"assets/assets/images/seesaw.jpg": "76ca57eb673d7f235801b59982301969",
"assets/assets/images/sky.jpg": "7d388c660966b68cb21d6d64093eb6d0",
"assets/assets/images/speed.jpg": "571e136a35216d71db648edd1ada7c28",
"assets/assets/images/splash.jpg": "75f9e0d8908b302751742947c657041f",
"assets/assets/images/supari.png": "3fcb66412ad8a0d2de40bf99ef0136d7",
"assets/assets/images/supari_full.png": "7fb3b49a54bf109530e882a68171fb9d",
"assets/assets/images/supari_half.png": "3fcb66412ad8a0d2de40bf99ef0136d7",
"assets/assets/images/supari_little.png": "7fb3b49a54bf109530e882a68171fb9d",
"assets/assets/images/supari_quarter.png": "f7d39998f5de7404b0aa13697dfc62ca",
"assets/assets/images/thahabhayobutton.png": "c9a467d0627d1ea381f3e2c6c66a0c42",
"assets/assets/images/triangle.png": "68cb6c9a106bf10c87202c1ac23250fa",
"assets/assets/images/tryagainbutton.png": "416bd3e68a087dbbd2b1ec4b681114ed",
"assets/assets/images/upArm.png": "38aa6febacf98792c9a75c2b29b7989b",
"assets/assets/images/upArm_old.png": "09c177e2a04795dabf5409a28d7f06dc",
"assets/assets/images/Velocity.jpg": "01f6aa0a590aefc2e2dce83b66b14b92",
"assets/assets/images/walnut1.png": "e0ac8a10a829285ae6963932829eef3d",
"assets/assets/images/walnut2.png": "d562ae420619b091b19b7833f934b8a1",
"assets/assets/images/walnut3.png": "048698f6e3a62cbdde89320a03741c33",
"assets/assets/images/walnut4.png": "6f66d0ddb28c62d6920a6cb2215cc7e4",
"assets/assets/images/walnutcracked.png": "ee214cdcdddecf0300333294a7007f22",
"assets/assets/images/water.png": "38da251c6fc46fbfe0c5ac2a7ff01cac",
"assets/assets/images/weight.png": "fa08e332faf073ac66e8d9980e9c8c12",
"assets/FontManifest.json": "da5401054c0b65d746a7d48db7816f58",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/NOTICES": "47f1fda5760c29c92b3756e1d6514717",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"favicon.png": "74830c08e802aead9313cc2ea1854b58",
"flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"icons/Icon-192.png": "617870ebe07ca340b661574d1125d7fa",
"icons/Icon-512.png": "19067462586d5c9aa9a1f7cdc8347a00",
"icons/Icon-maskable-192.png": "617870ebe07ca340b661574d1125d7fa",
"icons/Icon-maskable-512.png": "19067462586d5c9aa9a1f7cdc8347a00",
"index.html": "3f40b986e96920a9586e7ead2d595694",
"/": "3f40b986e96920a9586e7ead2d595694",
"main.dart.js": "fe0e56d389e6711bed6688cd6c7d386a",
"manifest.json": "741441e502e4695222fc105154d2d9e8",
"splash/img/dark-1x.png": "3df0c266bce8019182de6664175e5fee",
"splash/img/dark-2x.png": "343276ec2f9d578944fa44f65fed0562",
"splash/img/dark-3x.png": "88d9e51d91bab5681910d9411d1e2a0c",
"splash/img/dark-4x.png": "19e875a7a230b4450366fd36de544b4f",
"splash/img/light-1x.png": "3df0c266bce8019182de6664175e5fee",
"splash/img/light-2x.png": "343276ec2f9d578944fa44f65fed0562",
"splash/img/light-3x.png": "88d9e51d91bab5681910d9411d1e2a0c",
"splash/img/light-4x.png": "19e875a7a230b4450366fd36de544b4f",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/style.css": "73c6046ea5ceb0220ea78b76becf8a0b",
"version.json": "05a9735e1af0b103b16ee35510fdc247"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
