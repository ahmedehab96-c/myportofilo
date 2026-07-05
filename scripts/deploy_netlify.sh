#!/bin/sh
# Upload build/web to ahmedmyportofilo.netlify.app (manual deploy).
set -e
cd "$(dirname "$0")/.."

SITE_ID="${NETLIFY_SITE_ID:-5296b6c8-316e-4186-a832-23a8a2fe8cf3}"
SITE_URL="https://ahmedmyportofilo.netlify.app"

export USE_WASM=0

echo "==> Step 1/2: Build"
chmod +x build_web.sh prepare_project.sh run_web.sh
./build_web.sh

echo "==> Step 2/2: Upload to Netlify"
echo "    Site: $SITE_URL"
npx netlify-cli deploy --prod --dir=build/web --no-build --site "$SITE_ID"

echo ""
echo "==> Deployed: $SITE_URL"
echo "    If the old page still shows, hard reload in Chrome: Cmd+Shift+R"
