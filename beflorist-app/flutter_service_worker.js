'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "ad7676329f249e363410d961e529551c",
"assets/AssetManifest.bin.json": "2a647fde765b11e3a26cfbdec9e6c80d",
"assets/AssetManifest.json": "2496127340d9eb23aa697c4578fcd2f2",
"assets/assets/images/anggrek_merah.png": "b455dd6b807b306477f17125d19c1d28",
"assets/assets/images/anggrek_putih.png": "75b57ac6c16fbee9611931a05da0ce71",
"assets/assets/images/anggrek_ungu.png": "22a7e159b000252e473c5fce0b42a363",
"assets/assets/images/artifical_flowers%2520(1).jpg": "94a14b189b50138b258a52a1773bf0c6",
"assets/assets/images/artifical_flowers%2520(10).jpg": "501f590e75169540ef87f5595e9b3094",
"assets/assets/images/artifical_flowers%2520(11).jpg": "0248bf6512e4da605bc7e81725c46cc8",
"assets/assets/images/artifical_flowers%2520(12).jpg": "ade0285b1ca8272110c07b341489286f",
"assets/assets/images/artifical_flowers%2520(13).jpg": "89683664426fe2cc55b21e4f117146d5",
"assets/assets/images/artifical_flowers%2520(14).jpg": "089ec371aa8b983376c2f8930dd0eeba",
"assets/assets/images/artifical_flowers%2520(15).jpg": "ab8ac74bd9dd786f152d2deb7329ba69",
"assets/assets/images/artifical_flowers%2520(2).jpg": "6d690d96a8cbed7d33bd122fa94b6313",
"assets/assets/images/artifical_flowers%2520(3).jpg": "6c83baf24fedd0eb3cd0751e7ced3ad7",
"assets/assets/images/artifical_flowers%2520(4).jpg": "4fd172d2b2db32eb6d2c35f6196f99d4",
"assets/assets/images/artifical_flowers%2520(5).jpg": "3b541ed46cb03cee0698a4afc1efb29f",
"assets/assets/images/artifical_flowers%2520(6).jpg": "388d6921b9cb961c31d363fe630f94a1",
"assets/assets/images/artifical_flowers%2520(7).jpg": "e5399d65565a9bcc822b3333766cb6b1",
"assets/assets/images/artifical_flowers%2520(8).jpg": "67793e88774daf99367ec0990da2952e",
"assets/assets/images/artifical_flowers%2520(9).jpg": "fcfac365dd73b74b34477e9f4d20f5ee",
"assets/assets/images/baby_breath.png": "59ef5b2abf5b0af941dd7c57ffe4cbbb",
"assets/assets/images/beflorist_logo.png": "d2d0bd9935fc6703d35ae77b00162cf1",
"assets/assets/images/buket_coklat%2520(1).jpg": "55ee37599caa4f77e1a393415af69dfe",
"assets/assets/images/buket_coklat%2520(2).jpg": "22cf7a8afbe6e93e5680d2fdea820de7",
"assets/assets/images/buket_coklat%2520(3).jpg": "25c274655a183580ed7e9bb7ae03f355",
"assets/assets/images/buket_coklat%2520(4).jpg": "bec70476a861663618c640c15cfc5765",
"assets/assets/images/buket_coklat%2520(5).jpg": "1547b25df9d71aba57dd6fc248e0959f",
"assets/assets/images/buket_dried%2520(1).jpg": "3b541ed46cb03cee0698a4afc1efb29f",
"assets/assets/images/buket_dried%2520(2).jpg": "a004c74a490523200c3aa9fc203ac922",
"assets/assets/images/buket_dried%2520(3).jpg": "c74f2346fd6158b810959b5f31f2ee3a",
"assets/assets/images/buket_dried%2520(4).jpg": "53c976b18a82d5e5b2bbc1fa6d9ac4c0",
"assets/assets/images/buket_graduation%2520(1).jpg": "6346659f9c02edafca5f8e920a1ea64a",
"assets/assets/images/buket_graduation%2520(2).jpg": "b35c152903f55f8903b9fb5ba2c8e4d7",
"assets/assets/images/buket_graduation%2520(3).jpg": "a6298dcd32118131664c7213d85cc3ba",
"assets/assets/images/buket_graduation%2520(4).jpg": "7723a24373397779b2dbf55ad09a2783",
"assets/assets/images/buket_graduation%2520(5).jpg": "1d8a316fcfef312b45e0e9804e2d84c8",
"assets/assets/images/buket_graduation%2520(6).jpg": "25385ae00c7753fe28045beee9b0e314",
"assets/assets/images/buket_graduation%2520(7).jpg": "b62c508dbd9361f41bbf82f3116e1ef7",
"assets/assets/images/buket_graduation%2520(8).jpg": "5ec0ffaec32dfbb3a7b0d87b89d256ce",
"assets/assets/images/buket_graduation%2520(9).jpg": "9a91da12c50dea245291653e57508494",
"assets/assets/images/buket_money%2520(1).jpg": "98827e86c3b21e5a14b603295a84f5bb",
"assets/assets/images/buket_money%2520(10).jpg": "f1f76fa4c6dba0867fa20a1ac2f96126",
"assets/assets/images/buket_money%2520(11).jpg": "98771a0b4262a608ce7109ffe059a568",
"assets/assets/images/buket_money%2520(12).jpg": "c3be7565b6b22cbc8878659c8b1df18b",
"assets/assets/images/buket_money%2520(2).jpg": "6319ebaf3566bc19007c901f46c4dc6f",
"assets/assets/images/buket_money%2520(3).jpg": "68956e554cb0b8b8ed50b300e0b8a6b2",
"assets/assets/images/buket_money%2520(4).jpg": "e15b8a4f2d9c85500e8f79f8017735dc",
"assets/assets/images/buket_money%2520(5).jpg": "a2f0ed41bae374e50071014d86b8660f",
"assets/assets/images/buket_money%2520(6).jpg": "72f7e5b51f1fb3c9c74c3ffea3dfadbb",
"assets/assets/images/buket_money%2520(7).jpg": "836689b86934ea7e29658448c46a8fcf",
"assets/assets/images/buket_money%2520(8).jpg": "2b1692d98c9c67785be36142dee7f8a9",
"assets/assets/images/buket_money%2520(9).jpg": "092526cbf9296f63dc1ce5e051ab03b8",
"assets/assets/images/bunga_kering.jpg": "18b962628d30dac4c3ec8d591de388f5",
"assets/assets/images/dashboard_bg.jpg": "4d52b54fb1797c273b7bc8385372f6a2",
"assets/assets/images/fresh_flowers%2520(1).jpg": "156561f21d0e7e5641f947e02b4fa598",
"assets/assets/images/fresh_flowers%2520(10).jpg": "56d9d2cb025c390f53adec338822f794",
"assets/assets/images/fresh_flowers%2520(11).jpg": "0b0c4297380a780c87f3f72a12903d58",
"assets/assets/images/fresh_flowers%2520(12).jpg": "65309903a730a19bb08a54cd83a5e31b",
"assets/assets/images/fresh_flowers%2520(13).jpg": "313aa93c675300f62baced62d15c0a14",
"assets/assets/images/fresh_flowers%2520(14).jpg": "843a4cc0c1b5c83eafd928422cf73cca",
"assets/assets/images/fresh_flowers%2520(15).jpg": "9628f7045a643bd161502fbb9ef977b8",
"assets/assets/images/fresh_flowers%2520(16).jpg": "2632e8af24e597ab1dfb7615d04cc786",
"assets/assets/images/fresh_flowers%2520(17).jpg": "3c3ffd739dc898b44224e0d64dc8154f",
"assets/assets/images/fresh_flowers%2520(18).jpg": "de0352d96b3544895740e9075669b195",
"assets/assets/images/fresh_flowers%2520(19).jpg": "20fec48f0e218cb8eec5de0fc3d28ac5",
"assets/assets/images/fresh_flowers%2520(2).jpg": "e7ab573ccefc49d3e5b53f9847c64ca8",
"assets/assets/images/fresh_flowers%2520(20).jpg": "bf29b599c176990af04fe67f83974cbd",
"assets/assets/images/fresh_flowers%2520(3).jpg": "83ec4bed49b120b77ec078640cd03dcf",
"assets/assets/images/fresh_flowers%2520(4).jpg": "1265d420af6cdb56efe8e39317b2c81d",
"assets/assets/images/fresh_flowers%2520(5).jpg": "b431d96c031971c99b210fd89eb0541b",
"assets/assets/images/fresh_flowers%2520(6).jpg": "4649c500759dbd8f14de5f115c320737",
"assets/assets/images/fresh_flowers%2520(7).jpg": "b76a462bc836864d100f7fafeef7432f",
"assets/assets/images/fresh_flowers%2520(8).jpg": "2a6af5714524bb0b4813504699c1ae5b",
"assets/assets/images/fresh_flowers%2520(9).jpg": "0ab455299f727d6c06db5c5ca7a15b6f",
"assets/assets/images/gerbera_kuning.png": "4cfb369864db9296a964fa68df4844cb",
"assets/assets/images/gerbera_merah.png": "b585b016f30afdb1fb7b177ff2fb5790",
"assets/assets/images/gerbera_orange.png": "a2f04a4f5daa57c92954a203be8269dd",
"assets/assets/images/gerbera_pink.png": "85e8a623b923d5aab3d36cee7d4bcc0b",
"assets/assets/images/gift_box%2520(1).jpg": "9d22a0e36568f9a1d7070fc88b3a4829",
"assets/assets/images/gift_box%2520(2).jpg": "20d554813afcd47668bf9f60ff6b5800",
"assets/assets/images/gift_box%2520(3).jpg": "3942a71829ff7dd3e9ab1114c6c55062",
"assets/assets/images/gift_box%2520(4).jpg": "bbacbab5a80c4ab39f9fa69377dbec9f",
"assets/assets/images/gift_box%2520(5).jpg": "cb3d0e62000f271b310c3762137cfb33",
"assets/assets/images/gift_box%2520(6).jpg": "60bd3e611022b124688395f83a23bd30",
"assets/assets/images/gift_box%2520(7).jpg": "b5e325b4a8b729e3c8bb47057be72844",
"assets/assets/images/hampers%2520(1).jpg": "676e3bb0e68c41e6a1d42d35a97e59b6",
"assets/assets/images/hampers%2520(10).jpg": "c5deeb4f9ccbf6b833cc3f4acb921ed4",
"assets/assets/images/hampers%2520(11).jpg": "9d9fae919e952df569c0ea57f2fb12fe",
"assets/assets/images/hampers%2520(12).jpg": "b990745ebfe8224c1176956f52a8a44a",
"assets/assets/images/hampers%2520(13).jpg": "8deb1c44ead2b5df60eef825184f8b65",
"assets/assets/images/hampers%2520(14).jpg": "1ca349bad270a19298a5ce6cb9b24f66",
"assets/assets/images/hampers%2520(15).jpg": "e20ec40d1786efcfb596c1851b53e2ef",
"assets/assets/images/hampers%2520(2).jpg": "cf78930beba57c4cc7df826410478daf",
"assets/assets/images/hampers%2520(3).jpg": "9f02a9b067fcd46fc490ab069e329bfb",
"assets/assets/images/hampers%2520(4).jpg": "6f7b01993aa513bd2937d9a67b3967a1",
"assets/assets/images/hampers%2520(5).jpg": "88985ceca6ed08aa198d2ab301d3a3d3",
"assets/assets/images/hampers%2520(6).jpg": "463ddf4bc7b93a214b4766c6a29d12a1",
"assets/assets/images/hampers%2520(7).jpg": "2e6bf395e13488e6c52d2a1713c9ea45",
"assets/assets/images/hampers%2520(8).jpg": "f60ffaae2e575fcf9930063d80e56fd5",
"assets/assets/images/hampers%2520(9).jpg": "9cd6a92a633cd6e29b58a02fe46468a8",
"assets/assets/images/home_bg.jpg": "a39776d38fbe458c992bf2ad3f27644b",
"assets/assets/images/keranjang_rotan.jpg": "d9f4009604d2dab379541bcbe1f2af36",
"assets/assets/images/kertas_buket.jpg": "c419af1ca8a67ff311bbf76be75c118e",
"assets/assets/images/kotak_hadiah.jpg": "14e13b7248c1525a621e5c11b0c74daa",
"assets/assets/images/krisan_kuning.png": "2741fa2bf8bd17c79e86be31be4fac9b",
"assets/assets/images/krisan_pink.png": "9a0f10a0342b778ebc3fc221db18bb46",
"assets/assets/images/krisan_putih.png": "a5720c71101aef52602d39221445e4cc",
"assets/assets/images/lily_pink.png": "cb68efbe8e916089259cdb615acda12f",
"assets/assets/images/lily_putih.png": "5c5e240400b1abbc766c9537adad94c6",
"assets/assets/images/login_bg.jpg": "a39776d38fbe458c992bf2ad3f27644b",
"assets/assets/images/mawar_biru.png": "523e89981e65eedbade9f62b408bef27",
"assets/assets/images/mawar_merah.png": "cafb6d71f10c11bf801fc8891f90ebb5",
"assets/assets/images/mawar_pink.png": "65253153c7eb3849787591b6a0a365de",
"assets/assets/images/mawar_putih.png": "0167141a971b50ea8229eedd665d4a7a",
"assets/assets/images/papan_bunga%2520(1).jpg": "fcbfc0db4e6364b3cf82494eb91f75b5",
"assets/assets/images/papan_bunga%2520(2).jpg": "26290eac1e847fda0b798575d47ef3fb",
"assets/assets/images/papan_bunga%2520(3).jpg": "15a0afaceb1a76aa19a818f5a1ad6baf",
"assets/assets/images/papan_bunga%2520(4).jpg": "dcbc7a517d8a0a0f88bf56257c0faa68",
"assets/assets/images/papan_bunga%2520(5).jpg": "560aa06cb6747e30b8f0c28c9a40d3cc",
"assets/assets/images/papan_bunga%2520(6).jpg": "808434b34ffc8903bce5b03119b7646c",
"assets/assets/images/pita.jpg": "c037dc48817ea12657db37b91f55697e",
"assets/assets/images/register_bg.jpg": "a39776d38fbe458c992bf2ad3f27644b",
"assets/assets/images/ribbon_satin.jpg": "a9f946e1235db0a2bd938a74007ea9ba",
"assets/assets/images/tulip_merah.png": "d204e8414c1ac4a0021ab8ffc3c44f8b",
"assets/assets/images/tulip_pink.png": "8b3913237a7711d3d2a399a66279fa3c",
"assets/assets/images/tulip_putih.png": "8d8c94e0836884f51d4f1a7761051d25",
"assets/assets/images/vas_kaca.jpg": "81314366bb94132a41ad6f98588b27a1",
"assets/FontManifest.json": "97c2528ecc2fbf4093965257fdba1854",
"assets/fonts/MaterialIcons-Regular.otf": "7256acac01d3e61781f651b002bdf640",
"assets/NOTICES": "ff399d357164845c013e674d1ed40f51",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Brands-Regular-400.otf": "4d8fbaee00efb1b269657e46ed78e174",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Free-Regular-400.otf": "df86a1976d76bd04cf3fcaf5add2dd0f",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Free-Solid-900.otf": "e151d7a6f42f17e9ea335c91d07b3739",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "526224af768efa2670049d206ab360b6",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "fefc7d92842cefa1cff207da50484f2a",
"/": "fefc7d92842cefa1cff207da50484f2a",
"main.dart.js": "f0d60ba1cfa834abe021b1ebcbde0a51",
"manifest.json": "f5c719283775455ac542ac5a0939e7ba",
"version.json": "017f9170e80b18ddf436dce7eb685174"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
