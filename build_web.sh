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

echo "==> Building web (canvaskit / dart2js — required for Netlify)"
flutter build web --release \
  --pwa-strategy=none \
  --tree-shake-icons \
  --no-wasm-dry-run \
  --no-web-resources-cdn \
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
