#!/bin/sh
# Manual Netlify deploy — build locally, upload build/web (no Netlify CI).
set -e
cd "$(dirname "$0")/.."

# ahmedmyportofilo.netlify.app
SITE_ID="${NETLIFY_SITE_ID:-5296b6c8-316e-4186-a832-23a8a2fe8cf3}"

export NETLIFY_DEPLOY=1
export USE_WASM=0

echo "==> Building portfolio (canvaskit / main.dart.js)"
chmod +x build_web.sh prepare_project.sh
./build_web.sh

if [ ! -f build/web/main.dart.js ]; then
  echo "ERROR: main.dart.js missing — do not deploy wasm-only builds." >&2
  exit 1
fi

rm -f build/web/main.dart.wasm build/web/main.dart.mjs

echo "==> Deploy folder: $(du -sh build/web | awk '{print $1}')"
echo "==> Uploading to https://ahmedmyportofilo.netlify.app"

npx netlify-cli deploy --prod --dir=build/web --no-build --site "$SITE_ID"

echo "==> Done: https://ahmedmyportofilo.netlify.app"
