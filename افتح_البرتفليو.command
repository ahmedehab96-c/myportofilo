#!/bin/bash

cd "$(dirname "$0")"

clear
echo "═══════════════════════════════════════════════════════"
echo "   🚀 جاري فتح البرتفليو..."
echo "═══════════════════════════════════════════════════════"
echo ""

# تفعيل دعم الويب
flutter config --enable-web > /dev/null 2>&1

# تنظيف
echo "🧹 تنظيف المشروع..."
flutter clean > /dev/null 2>&1

# تحديث الحزم
echo "📥 تحديث الحزم..."
flutter pub get > /dev/null 2>&1

echo ""
echo "🔨 جاري بناء التطبيق..."
echo "⏳ يرجى الانتظار... قد يستغرق بضع دقائق..."
echo ""

# بناء التطبيق
if flutter build web --web-renderer html 2>&1 | grep -q "Build succeeded"; then
    echo "✅ البناء مكتمل!"
else
    flutter build web --web-renderer html
fi

echo ""
echo "🚀 جاري تشغيل الخادم..."
echo ""

# الانتقال إلى مجلد البناء
cd build/web

# تشغيل الخادم
if command -v python3 &> /dev/null; then
    echo "📱 افتح المتصفح على: http://localhost:8000"
    echo ""
    echo "⏹️  لإيقاف الخادم، اضغط Ctrl+C"
    echo ""
    python3 -m http.server 8000
elif command -v python &> /dev/null; then
    echo "📱 افتح المتصفح على: http://localhost:8000"
    echo ""
    echo "⏹️  لإيقاف الخادم، اضغط Ctrl+C"
    echo ""
    python -m SimpleHTTPServer 8000
else
    echo "❌ Python غير مثبت!"
    echo ""
    echo "يرجى تثبيت Python أو استخدام:"
    echo "  npx http-server -p 8000"
    exit 1
fi

