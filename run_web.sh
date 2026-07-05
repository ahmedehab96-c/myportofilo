#!/bin/sh
# Build release web and serve locally (much faster than `flutter run -d chrome`).
set -e
cd "$(dirname "$0")"

./build_web.sh

PORT="${1:-8080}"
echo "==> Serving release build at http://localhost:$PORT"
echo "    Press Ctrl+C to stop."

cd build/web
python3 -m http.server "$PORT"
