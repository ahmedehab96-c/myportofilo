#!/bin/sh
# Point portfolio APK buttons to portfolio-apk-v2 (arm64) on GitHub.
set -e
cd "$(dirname "$0")/.."

perl -pi -e '
  s|portfolio-apk-v1/app-release\.apk|portfolio-apk-v2/app-arm64-v8a-release.apk|g;
  s|v1\.0\.0/app-release\.apk|portfolio-apk-v2/app-arm64-v8a-release.apk|g;
  s|portfolio-apk-v1/app-arm64-v8a-release\.apk|portfolio-apk-v2/app-arm64-v8a-release.apk|g;
  s|releases/tag/portfolio-apk-v1|releases/tag/portfolio-apk-v2|g;
  s|releases/tag/v1\.0\.0|releases/tag/portfolio-apk-v2|g;
' lib/data/portfolio_content.dart lib/services/portfolio_knowledge.dart

echo "==> Updated APK URLs to portfolio-apk-v2"
grep -h 'releases/download' lib/data/portfolio_content.dart
