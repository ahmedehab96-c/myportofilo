#!/bin/sh
# Build Flutter WEB demos only → demos-dist/ (deploy as separate Netlify site).
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="${PORTFOLIO_PROJECTS_ROOT:-$HOME/Desktop}"
OUT="$ROOT/demos-dist"
APK_OUT="$OUT/apk"

mkdir -p "$APK_OUT"

build_web() {
  dir="$1"
  id="$2"
  target="${3:-lib/main.dart}"
  echo "==> Build web demo: $id ($target)"
  (
    cd "$dir"
    flutter pub get
    flutter build web --release -t "$target" --pwa-strategy=none
    rm -rf "$OUT/$id"
    mkdir -p "$OUT/$id"
    cp -R build/web/* "$OUT/$id/"
  )
}

copy_web() {
  src="$1"
  id="$2"
  if [ -d "$src" ] && [ -f "$src/index.html" ]; then
    echo "==> Copy web demo: $id"
    rm -rf "$OUT/$id"
    mkdir -p "$OUT/$id"
    cp -R "$src/"* "$OUT/$id/"
    return 0
  fi
  return 1
}

copy_apk() {
  src="$1"
  name="$2"
  if [ -f "$src" ]; then
    echo "==> Copy APK: $name"
    cp "$src" "$APK_OUT/$name.apk"
  fi
}

HRM="$DESKTOP/hrm-nawa tech"
LIFEOS="$DESKTOP/LifeOS"
MEZO="$DESKTOP/mezo_food_app"
IT="$DESKTOP/IT Assist - Nawa Tech"

echo "==> Remote web demos → $OUT"

# --- HRM (Flutter web admin) ---
if [ -d "$HRM" ]; then
  copy_web "$HRM/build/web" "hrm" || build_web "$HRM" "hrm" "lib/main.dart"
  copy_apk "$HRM/build/app/outputs/flutter-apk/app-release.apk" "hrm"
fi

# --- Life OS ---
if [ -d "$LIFEOS" ]; then
  copy_web "$LIFEOS/build/web" "lifeos" || build_web "$LIFEOS" "lifeos"
fi

# --- Mezo admin web (always build admin entry — do not reuse customer web build) ---
if [ -d "$MEZO" ]; then
  build_web "$MEZO" "mezo-admin" "lib/admin/main_admin.dart"
  copy_apk "$MEZO/build/app/outputs/flutter-apk/app-release.apk" "mezo"
fi

# --- IT Assist (Flutter web — Laravel panel is separate) ---
if [ -d "$IT" ]; then
  copy_web "$IT/build/web" "itassist" || build_web "$IT" "itassist"
  copy_apk "$IT/build/app/outputs/flutter-apk/app-release.apk" "itassist"
fi

# Werdi: mobile-only (web build not supported) — skipped

# Landing page for the demos Netlify site
cat > "$OUT/index.html" <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Ahmed Ehab — Project Web Demos</title>
  <style>
    body { font-family: system-ui, sans-serif; max-width: 520px; margin: 48px auto; padding: 0 20px;
      background: #0d1117; color: #c9d1d9; }
    h1 { font-size: 1.35rem; color: #58a6ff; }
    a { display: block; padding: 12px 16px; margin: 8px 0; background: #161b22; border: 1px solid #30363d;
      border-radius: 8px; color: #58a6ff; text-decoration: none; }
    a:hover { border-color: #58a6ff; }
    p { color: #8b949e; font-size: 0.9rem; }
  </style>
</head>
<body>
  <h1>Project web demos</h1>
  <p>Hosted separately from the portfolio to keep the main site fast.</p>
  <a href="/hrm/">HRM NAWA TECH — Web admin</a>
  <a href="/lifeos/">Life OS — Web app</a>
  <a href="/mezo-admin/">Mezo — Admin panel</a>
  <a href="/itassist/">IT Assist — Flutter web</a>
  <p>Werdi is mobile-only (APK on GitHub Releases).</p>
</body>
</html>
EOF

cp "$ROOT/web/_headers" "$OUT/_headers" 2>/dev/null || true

echo "==> Done"
du -sh "$OUT"/* 2>/dev/null | head -20
ls -lh "$APK_OUT" 2>/dev/null || true
