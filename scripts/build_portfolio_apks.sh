#!/bin/sh
# Build small arm64-only APKs (~35–45 MB vs 60–75 MB universal).
set -e

DESKTOP="${PORTFOLIO_PROJECTS_ROOT:-$HOME/Desktop}"
OUT="${1:-$HOME/Desktop/portfolio-apks}"
mkdir -p "$OUT"

build_arm64() {
  id="$1"
  dir="$2"
  echo ""
  echo "========== $id =========="
  if [ ! -d "$dir" ]; then
    echo "SKIP: $dir not found"
    return 1
  fi
  (
    cd "$dir"
    flutter pub get
    # arm64 only — one ABI, much smaller than universal app-release.apk
    flutter build apk --release \
      --target-platform android-arm64 \
      --tree-shake-icons
    SRC="build/app/outputs/flutter-apk/app-release.apk"
    if [ ! -f "$SRC" ]; then
      echo "ERROR: $SRC missing" >&2
      exit 1
    fi
    cp "$SRC" "$OUT/${id}-arm64.apk"
    ls -lh "$OUT/${id}-arm64.apk"
  )
}

build_arm64 hrm "$DESKTOP/hrm-nawa tech"
build_arm64 lifeos "$DESKTOP/LifeOS"
build_arm64 mezo "$DESKTOP/mezo_food_app"
build_arm64 itassist "$DESKTOP/IT Assist - Nawa Tech"
build_arm64 werdi "$DESKTOP/werdi/werdi"

echo ""
echo "==> Done — APKs in $OUT"
du -h "$OUT"/*.apk 2>/dev/null || true
echo ""
echo "Next: ./scripts/upload_portfolio_apks.sh"
