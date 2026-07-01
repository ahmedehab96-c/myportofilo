#!/bin/sh
# Run before flutter run / build. Regenerates l10n into lib/gen/l10n (committed).
set -e
cd "$(dirname "$0")"

echo "==> flutter pub get"
flutter pub get

echo "==> flutter gen-l10n"
flutter gen-l10n

if [ ! -f lib/gen/l10n/app_localizations.dart ]; then
  echo "ERROR: lib/gen/l10n/app_localizations.dart missing after gen-l10n." >&2
  exit 1
fi

echo "==> Ready (l10n + dependencies OK)"
