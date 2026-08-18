#!/bin/sh
# Production web build for Netlify + Chrome (canvaskit / main.dart.js only).
set -e
cd "$(dirname "$0")"

echo "==> Installing dependencies"
./prepare_project.sh

if [ "$USE_WASM" = "1" ]; then
  echo "ERROR: USE_WASM=1 is disabled for this portfolio. Use ./run_web.sh for local preview." >&2
  exit 1
fi

echo "==> Building web (canvaskit / dart2js — CanvasKit via Google CDN for faster mobile)"
flutter build web --release \
  --pwa-strategy=none \
  --no-tree-shake-icons \
  --no-wasm-dry-run \
  -O4 \
  "$@"

echo "==> Post-process build/web"
rm -f build/web/flutter_service_worker.js
rm -f build/web/main.dart.wasm build/web/main.dart.mjs
find build/web -name '*.symbols' -delete 2>/dev/null || true

# No service worker.
perl -0777 -i -pe 's/_flutter\.loader\.load\(\{[^}]*serviceWorkerSettings[^}]*\}\);/_flutter.loader.load();/g' build/web/flutter_bootstrap.js
perl -0777 -i -pe 's/_flutter\.loader\.load\(\{\s*serviceWorkerSettings:\s*\{[^}]*\}\s*\}\);/_flutter.loader.load();/g' build/web/flutter_bootstrap.js

# Remove wasm build entry if Flutter added one (Chrome would 404 on main.dart.mjs).
perl -0777 -i -pe 's/,\s*\{"compileTarget":"dart2wasm"[^}]*\}//g' build/web/flutter_bootstrap.js
perl -0777 -i -pe 's/\{"compileTarget":"dart2wasm"[^}]*\}\s*,//g' build/web/flutter_bootstrap.js
perl -0777 -i -pe 's/,\s*\{\}//g' build/web/flutter_bootstrap.js

# Always force canvaskit — never auto-pick wasm in Chrome.
perl -0777 -i -pe 's/_flutter\.loader\.load\(\);/_flutter.loader.load({config: {renderer: "canvaskit"}});/g' build/web/flutter_bootstrap.js

# Prefer Google CDN for CanvasKit (much faster first open on mobile vs ~7MB from Netlify).
perl -pi -e 's/"useLocalCanvasKit":true/"useLocalCanvasKit":false/g' build/web/flutter_bootstrap.js
if [ -d build/web/canvaskit ]; then
  echo "==> Removing local canvaskit (loaded from gstatic CDN on mobile/desktop)"
  rm -rf build/web/canvaskit
fi

# Bust immutable CDN/browser cache for main.dart.js
BUILD_ID="${BUILD_ID:-$(date +%Y%m%d%H%M)}"
perl -pi -e "s/mainJsPath\":\"main\\.dart\\.js\"/mainJsPath\":\"main.dart.js?v=$BUILD_ID\"/g" build/web/flutter_bootstrap.js
echo "==> Cache bust: main.dart.js?v=$BUILD_ID"

# Keep nested Mezo Flutter admin demo (built separately into web/demos/mezo-admin).
if [ -d web/demos/mezo-admin ] && [ ! -d build/web/demos/mezo-admin ]; then
  echo "==> Copying Mezo admin demo into build/web"
  mkdir -p build/web/demos
  cp -R web/demos/mezo-admin build/web/demos/
fi
if [ -d web/demos/mezo ] && [ ! -f build/web/demos/mezo/index.html ]; then
  mkdir -p build/web/demos
  cp -R web/demos/mezo build/web/demos/
fi
if [ -d web/demos/itassist ] && [ ! -f build/web/demos/itassist/index.html ]; then
  mkdir -p build/web/demos
  cp -R web/demos/itassist build/web/demos/
fi
# Always refresh static demo HTML (not the heavy mezo-admin bundle unless missing).
if [ -f web/demos/mezo/index.html ]; then
  mkdir -p build/web/demos/mezo
  cp -f web/demos/mezo/index.html build/web/demos/mezo/
  cp -f web/demos/mezo/*.png build/web/demos/mezo/ 2>/dev/null || true
fi
if [ -f web/demos/itassist/index.html ]; then
  mkdir -p build/web/demos/itassist
  cp -f web/demos/itassist/index.html build/web/demos/itassist/
  cp -f web/demos/itassist/*.png build/web/demos/itassist/ 2>/dev/null || true
fi
if [ -d web/demos/mezo-admin ] && [ -f web/demos/mezo-admin/index.html ]; then
  echo "==> Syncing Mezo admin demo (Flutter web)"
  rm -rf build/web/demos/mezo-admin
  mkdir -p build/web/demos
  cp -R web/demos/mezo-admin build/web/demos/
fi

if [ ! -f build/web/main.dart.js ]; then
  echo "ERROR: main.dart.js missing. Do NOT use plain 'flutter build web --release'." >&2
  exit 1
fi

BUILD_CFG=$(grep '_flutter.buildConfig =' build/web/flutter_bootstrap.js || true)
if echo "$BUILD_CFG" | grep -qE 'dart2wasm|main\.dart\.mjs|main\.dart\.wasm'; then
  echo "ERROR: flutter_bootstrap.js still references wasm." >&2
  echo "$BUILD_CFG" >&2
  exit 1
fi

if grep -q '"builds":\[\]' build/web/flutter_bootstrap.js; then
  echo "ERROR: corrupted builds config in flutter_bootstrap.js" >&2
  exit 1
fi

TOTAL=$(du -sh build/web | awk '{print $1}')
JS=$(du -h build/web/main.dart.js | awk '{print $1}')
echo "==> Ready: build/web ($TOTAL, main.dart.js $JS)"
echo "    Preview:  ./run_web.sh"
echo "    Deploy:   ./scripts/deploy_netlify.sh"
