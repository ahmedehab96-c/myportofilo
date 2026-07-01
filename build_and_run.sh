#!/bin/bash

# بناء وتشغيل البرتفليو

cd "$(dirname "$0")"

echo "🔨 جاري بناء التطبيق..."
flutter build web --web-renderer html

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ البناء مكتمل!"
    echo ""
    echo "🚀 جاري تشغيل الخادم..."
    echo ""
    cd build/web
    python3 -m http.server 8000
else
    echo "❌ فشل البناء!"
    exit 1
fi

