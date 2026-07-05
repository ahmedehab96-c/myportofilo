#!/bin/sh
# Netlify CI for the separate project-demos site (demos-dist/).
set -e
cd "$(dirname "$0")/.."

if ! command -v flutter >/dev/null 2>&1; then
  echo "==> Installing Flutter"
  FLUTTER_DIR="${NETLIFY_BUILD_BASE:-$HOME}/flutter"
  rm -rf "$FLUTTER_DIR"
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"
  export PATH="$FLUTTER_DIR/bin:$PATH"
  flutter config --enable-web
  flutter precache --web --no-android --no-ios
fi

flutter --version

# On Netlify CI, sibling Desktop projects are not available — expect pre-built demos-dist
# committed or use build hook from local machine. Try build if folders exist.
if [ -d "${PORTFOLIO_PROJECTS_ROOT:-$HOME/Desktop}/LifeOS" ]; then
  chmod +x scripts/build_web_demos.sh
  ./scripts/build_web_demos.sh
else
  echo "==> No Desktop project folders on CI — using existing demos-dist/ if present"
  if [ ! -f demos-dist/index.html ]; then
    echo "ERROR: demos-dist/ is empty. Run ./scripts/build_web_demos.sh locally and deploy demos-dist/." >&2
    exit 1
  fi
fi

du -sh demos-dist
