#!/bin/bash

echo "🚀 بدء تشغيل التطبيق على الويب..."
echo ""

# الانتقال إلى مجلد المشروع
cd "$(dirname "$0")"

# التحقق من Flutter
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter غير مثبت!"
    exit 1
fi

echo "📦 تفعيل دعم الويب..."
flutter config --enable-web

echo "📥 تحديث الحزم وتوليد الترجمة..."
./prepare_project.sh

echo ""
echo "🌐 بناء التطبيق للويب..."
flutter build web --web-renderer html

echo ""
echo "✅ البناء مكتمل!"
echo ""
echo "📂 الملفات موجودة في: build/web"
echo ""
echo "🌍 لتشغيل خادم محلي، استخدم أحد الأوامر التالية:"
echo ""
echo "   Python 3:"
echo "   cd build/web && python3 -m http.server 8000"
echo ""
echo "   أو Node.js (http-server):"
echo "   cd build/web && npx http-server -p 8000"
echo ""
echo "   ثم افتح المتصفح على: http://localhost:8000"
echo ""

# محاولة تشغيل خادم تلقائي إذا كان Python متاحاً
if command -v python3 &> /dev/null; then
    echo "🚀 جاري تشغيل خادم محلي تلقائياً..."
    echo ""
    cd build/web
    python3 -m http.server 8000
elif command -v python &> /dev/null; then
    echo "🚀 جاري تشغيل خادم محلي تلقائياً..."
    echo ""
    cd build/web
    python -m SimpleHTTPServer 8000
else
    echo "⚠️  Python غير مثبت. يرجى تثبيت Python أو استخدام طريقة أخرى."
fi

