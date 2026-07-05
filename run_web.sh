#!/bin/sh
# Build canvaskit release + serve locally + open Chrome (macOS).
set -e
cd "$(dirname "$0")"

export USE_WASM=0
export NETLIFY_DEPLOY=1

PORT=8080
OPEN_CHROME=1
for arg in "$@"; do
  case "$arg" in
    --no-open) OPEN_CHROME=0 ;;
    [0-9]*) PORT="$arg" ;;
  esac
done

echo "==> Building portfolio (canvaskit — works in Chrome)"
chmod +x build_web.sh prepare_project.sh
./build_web.sh

if [ ! -f build/web/main.dart.js ]; then
  echo "ERROR: main.dart.js missing. Do not use plain 'flutter build web'." >&2
  exit 1
fi

URL="http://127.0.0.1:$PORT"
echo "==> Starting local server at $URL"
echo "    Use Chrome (not Cursor preview). Press Ctrl+C to stop."

cd build/web
python3 ../../scripts/serve_web.py "$PORT" &
SERVER_PID=$!

cleanup() {
  kill "$SERVER_PID" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

sleep 1

if [ "$OPEN_CHROME" -eq 1 ]; then
  if [ "$(uname -s)" = "Darwin" ]; then
    open -a "Google Chrome" "$URL" 2>/dev/null || open "$URL"
  else
    echo "    Open in Chrome: $URL"
  fi
fi

wait "$SERVER_PID"
