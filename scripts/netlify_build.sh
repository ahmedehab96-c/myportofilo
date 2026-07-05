#!/bin/sh
# Netlify CI: install Flutter if needed, build portfolio only (no sibling-project demos).
set -e
cd "$(dirname "$0")/.."

if ! command -v flutter >/dev/null 2>&1; then
  echo "==> Installing Flutter (Netlify CI)"
  FLUTTER_DIR="${NETLIFY_BUILD_BASE:-$HOME}/flutter"
  rm -rf "$FLUTTER_DIR"
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"
  export PATH="$FLUTTER_DIR/bin:$PATH"
  flutter config --enable-web
  flutter precache --web --no-android --no-ios
fi

flutter --version

export NETLIFY_DEPLOY=1
export USE_WASM=0

chmod +x build_web.sh prepare_project.sh
./build_web.sh

# Safety: production deploy must ship dart2js, not wasm-only (black screen on Netlify).
if [ ! -f build/web/main.dart.js ]; then
  echo "ERROR: main.dart.js missing — refusing wasm-only deploy." >&2
  exit 1
fi
rm -f build/web/main.dart.wasm build/web/main.dart.mjs

echo "==> Netlify deploy size:"
du -sh build/web
