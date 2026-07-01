#!/bin/sh
set -e
cd "$(dirname "$0")"

echo "==> Installing dependencies"
flutter pub get

echo "==> Generating localizations"
flutter gen-l10n

echo "==> Building web (no service worker)"
flutter build web --release --pwa-strategy=none --no-wasm-dry-run "$@"

echo "==> Cleaning deploy artifacts"
rm -f build/web/flutter_service_worker.js
perl -0777 -i -pe 's/_flutter\.loader\.load\(\{\s*serviceWorkerSettings:\s*\{[^}]*\}\s*\}\);/_flutter.loader.load();/g' build/web/flutter_bootstrap.js

# Standalone config file (avoids parsing minified bootstrap on the client).
python3 - <<'PY'
from pathlib import Path
text = Path("build/web/flutter_bootstrap.js").read_text(encoding="utf-8")
marker = "_flutter.buildConfig = "
idx = text.rfind(marker)
if idx < 0:
    raise SystemExit("Could not extract Flutter build config.")
start = idx + len(marker)
depth = 0
end = start
for i in range(start, len(text)):
    ch = text[i]
    if ch == "{":
        depth += 1
    elif ch == "}":
        depth -= 1
        if depth == 0:
            end = i
            break
config = text[start : end + 1]
Path("build/web/flutter_build_config.js").write_text(
    "window._flutter=window._flutter||{};window._flutter.buildConfig="
    + config
    + ";\n",
    encoding="utf-8",
)
PY

if tail -5 build/web/flutter_bootstrap.js | grep -q "serviceWorkerSettings"; then
  echo "ERROR: flutter_bootstrap.js still registers a service worker." >&2
  exit 1
fi

if [ ! -f build/web/flutter_build_config.js ]; then
  echo "ERROR: flutter_build_config.js missing from build/web." >&2
  exit 1
fi

echo "==> Deploy folder ready: build/web"
echo "    Upload ALL files inside build/web to Netlify."
