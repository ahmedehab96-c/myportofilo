#!/bin/bash

# سكريبت بسيط لفتح البرتفليو

cd "$(dirname "$0")"

echo "🔍 التحقق من Flutter..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter غير مثبت!"
    exit 1
fi

echo "📦 تفعيل دعم الويب..."
flutter config --enable-web > /dev/null 2>&1

echo "🧹 تنظيف..."
flutter clean > /dev/null 2>&1

echo "📥 تحديث الحزم..."
flutter pub get > /dev/null 2>&1

echo ""
echo "🔨 جاري بناء التطبيق... (قد يستغرق بضع دقائق)"
echo ""

# بناء التطبيق
if flutter build web --web-renderer html > /dev/null 2>&1; then
    echo "✅ البناء مكتمل!"
    echo ""
    
    # التحقق من وجود Python
    if command -v python3 &> /dev/null; then
        echo "🚀 جاري تشغيل الخادم على http://localhost:8000"
        echo "📱 افتح المتصفح على: http://localhost:8000"
        echo ""
        echo "⏹️  لإيقاف الخادم، اضغط Ctrl+C"
        echo ""
        cd build/web
        python3 -m http.server 8000
    elif command -v python &> /dev/null; then
        echo "🚀 جاري تشغيل الخادم على http://localhost:8000"
        echo "📱 افتح المتصفح على: http://localhost:8000"
        echo ""
        echo "⏹️  لإيقاف الخادم، اضغط Ctrl+C"
        echo ""
        cd build/web
        python -m SimpleHTTPServer 8000
    else
        echo "⚠️  Python غير مثبت!"
        echo ""
        echo "📂 الملفات موجودة في: build/web"
        echo ""
        echo "يمكنك استخدام أي خادم محلي لفتح الملفات:"
        echo "  - Node.js: npx http-server -p 8000"
        echo "  - أو افتح index.html مباشرة من build/web"
    fi
else
    echo "❌ فشل البناء!"
    echo ""
    echo "جرب تشغيل الأمر يدوياً لرؤية الأخطاء:"
    echo "  flutter build web --web-renderer html"
    exit 1
fi

