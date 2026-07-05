#!/bin/sh
# Upload slim arm64 APKs to GitHub Releases (portfolio-apk-v2).
# Run scripts/build_portfolio_apks.sh first.
set -e

APK_DIR="${1:-$HOME/Desktop/portfolio-apks}"
TAG=portfolio-apk-v2
NOTES="Smaller arm64-only APK for modern Android phones (2020+). ~40% smaller than universal builds."

upload() {
  repo="$1"
  file="$2"
  title="$3"
  if [ ! -f "$file" ]; then
    echo "SKIP $repo — missing $file"
    return 1
  fi
  size=$(du -h "$file" | awk '{print $1}')
  echo ""
  echo "==> $repo ($size)"
  gh release delete "$TAG" -R "ahmedehab96-c/$repo" -y 2>/dev/null || true
  gh release create "$TAG" -R "ahmedehab96-c/$repo" \
    --title "$title (arm64 — $size)" \
    --notes "$NOTES" \
    "$file#app-arm64-v8a-release.apk"
}

upload hrm-nawa-tech "$APK_DIR/hrm-arm64.apk" "HRM NAWA TECH — Android APK"
upload LifeOS "$APK_DIR/lifeos-arm64.apk" "Life OS — Android APK"
upload mezo-food-app "$APK_DIR/mezo-arm64.apk" "Mezo Food App — Android APK"
upload it-assist-nawa-tech "$APK_DIR/itassist-arm64.apk" "IT Assist — Android APK"
upload werdi "$APK_DIR/werdi-arm64.apk" "Werdi — Android APK"

echo ""
echo "==> All uploads done (tag: $TAG)"
