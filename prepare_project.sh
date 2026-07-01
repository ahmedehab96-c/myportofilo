#!/bin/sh
# Ensures l10n Dart files exist before every run/build.
set -e
cd "$(dirname "$0")"

L10N=(
  lib/generated/l10n/app_localizations.dart
  lib/generated/l10n/app_localizations_ar.dart
  lib/generated/l10n/app_localizations_en.dart
)

restore_l10n_from_git() {
  missing=0
  for f in "${L10N[@]}"; do
    if [ ! -f "$f" ]; then
      missing=1
      break
    fi
  done
  if [ "$missing" -eq 1 ]; then
    echo "==> Restoring l10n from git"
    git restore "${L10N[@]}" 2>/dev/null \
      || git checkout HEAD -- "${L10N[@]}" 2>/dev/null \
      || true
  fi
}

restore_l10n_from_git
flutter pub get
restore_l10n_from_git

if [ ! -f lib/generated/l10n/app_localizations.dart ]; then
  echo "==> flutter gen-l10n"
  flutter gen-l10n
fi

if [ ! -f lib/generated/l10n/app_localizations.dart ]; then
  echo "ERROR: lib/generated/l10n/app_localizations.dart is missing." >&2
  exit 1
fi

echo "==> Ready (l10n + dependencies OK)"
