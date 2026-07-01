#!/bin/bash

cd "$(dirname "$0")"

echo "═══════════════════════════════════════════════════════"
echo "   🔨 بناء وتشغيل البرتفليو - نسخة محسّنة"
echo "═══════════════════════════════════════════════════════"
echo ""

# تنظيف المنافذ
echo "🧹 تنظيف المنافذ..."
lsof -ti:8000 | xargs kill -9 2>/dev/null
lsof -ti:8080 | xargs kill -9 2>/dev/null
sleep 1

# تفعيل دعم الويب
echo "📦 تفعيل دعم الويب..."
flutter config --enable-web

# تنظيف
echo "🧹 تنظيف المشروع..."
flutter clean

# تحديث الحزم
echo "📥 تحديث الحزم..."
flutter pub get

# بناء التطبيق مع عرض المخرجات
echo ""
echo "🔨 جاري بناء التطبيق..."
echo "⏳ يرجى الانتظار... قد يستغرق بضع دقائق..."
echo ""

flutter build web --web-renderer html --release

# التحقق من نجاح البناء
if [ $? -eq 0 ] && [ -f "build/web/index.html" ]; then
    echo ""
    echo "✅ البناء مكتمل بنجاح!"
    echo ""
    
    cd build/web
    
    echo "🚀 جاري تشغيل الخادم على http://localhost:8000"
    echo ""
    echo "📱 افتح Chrome واذهب إلى:"
    echo "   http://localhost:8000"
    echo ""
    echo "⏹️  لإيقاف الخادم، اضغط Ctrl+C"
    echo ""
    echo "═══════════════════════════════════════════════════════"
    echo ""
    
    # تشغيل الخادم
    if command -v python3 &> /dev/null; then
        python3 -m http.server 8000
    elif command -v python &> /dev/null; then
        python -m SimpleHTTPServer 8000
    else
        echo "❌ Python غير مثبت!"
        echo "يمكنك استخدام: npx http-server -p 8000"
        exit 1
    fi
else
    echo ""
    echo "❌ فشل البناء!"
    echo ""
    echo "يرجى التحقق من الأخطاء أعلاه"
    echo ""
    echo "جرب:"
    echo "  flutter doctor"
    echo "  flutter clean"
    echo "  flutter pub get"
    echo "  flutter build web --verbose"
    exit 1
fi

