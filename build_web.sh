#!/bin/sh
set -e
cd "$(dirname "$0")"

echo "==> Installing dependencies"
./prepare_project.sh

echo "==> Building web (release, no service worker)"
# Default: canvaskit (dart2js) — works on Netlify and all browsers.
# Set USE_WASM=1 only for optional smaller local preview.
if [ "$USE_WASM" = "1" ]; then
  echo "    Target: wasm (skwasm) — local only"
  flutter build web --release \
    --pwa-strategy=none \
    --tree-shake-icons \
    --no-wasm-dry-run \
    --no-web-resources-cdn \
    --wasm \
    -O4 \
    "$@"
else
  echo "    Target: canvaskit (dart2js) — Netlify + production"
  flutter build web --release \
    --pwa-strategy=none \
    --tree-shake-icons \
    --no-wasm-dry-run \
    --no-web-resources-cdn \
    -O4 \
    "$@"
fi

echo "==> Cleaning deploy artifacts"
rm -f build/web/flutter_service_worker.js

# Force plain loader (no service worker registration).
perl -0777 -i -pe 's/_flutter\.loader\.load\(\{[^}]*serviceWorkerSettings[^}]*\}\);/_flutter.loader.load();/g' build/web/flutter_bootstrap.js
perl -0777 -i -pe 's/_flutter\.loader\.load\(\{\s*serviceWorkerSettings:\s*\{[^}]*\}\s*\}\);/_flutter.loader.load();/g' build/web/flutter_bootstrap.js

if tail -8 build/web/flutter_bootstrap.js | grep -q 'serviceWorkerSettings'; then
  echo "ERROR: flutter_bootstrap.js still registers a service worker." >&2
  exit 1
fi

echo "==> Stripping debug symbol files"
find build/web -name '*.symbols' -delete 2>/dev/null || true

if [ "$USE_WASM" = "1" ]; then
  echo "==> WASM-only trim (smaller first load)"
  # Keep only dart2wasm/skwasm build — remove dart2js fallback (~3MB + 20MB canvaskit).
  perl -0777 -i -pe 's/,\{"compileTarget":"dart2js","renderer":"canvaskit","mainJsPath":"main\.dart\.js"\}//g' build/web/flutter_bootstrap.js
  perl -0777 -i -pe 's/\{"compileTarget":"dart2js","renderer":"canvaskit","mainJsPath":"main\.dart\.js"\},//g' build/web/flutter_bootstrap.js

  rm -f build/web/main.dart.js
  rm -f build/web/canvaskit/canvaskit.wasm build/web/canvaskit/canvaskit.js
  rm -rf build/web/canvaskit/chromium

  if grep -F 'dart2js' build/web/flutter_bootstrap.js >/dev/null 2>&1; then
    echo "ERROR: dart2js fallback still present in flutter_bootstrap.js" >&2
    exit 1
  fi

  if [ ! -f build/web/main.dart.wasm ] || [ ! -f build/web/main.dart.mjs ]; then
    echo "ERROR: WASM build artifacts missing." >&2
    exit 1
  fi
else
  if [ ! -f build/web/main.dart.js ]; then
    echo "ERROR: main.dart.js missing from canvaskit build." >&2
    exit 1
  fi
fi

# Remove empty wasm placeholder entries from builds config (breaks loader on Netlify).
perl -0777 -i -pe 's/,\s*\{\}//g' build/web/flutter_bootstrap.js

if grep -q '"builds":\[\]' build/web/flutter_bootstrap.js; then
  echo "ERROR: corrupted builds config in flutter_bootstrap.js" >&2
  exit 1
fi

TOTAL=$(du -sh build/web | awk '{print $1}')
JS=$(du -h build/web/main.dart.js 2>/dev/null | awk '{print $1}')

echo "==> Deploy folder ready: build/web"
echo "    Total size: $TOTAL (main.dart.js ~${JS:-?})"
echo "    Local preview: ./run_web.sh"
