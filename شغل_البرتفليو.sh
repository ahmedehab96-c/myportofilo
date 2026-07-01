#!/bin/bash

# سكريبت بسيط لبناء وتشغيل البرتفليو

cd "$(dirname "$0")"

echo "═══════════════════════════════════════════════════════"
echo "   🚀 جاري بناء وتشغيل البرتفليو"
echo "═══════════════════════════════════════════════════════"
echo ""

# تنظيف المنافذ المستخدمة
echo "🧹 تنظيف المنافذ..."
lsof -ti:8000 | xargs kill -9 2>/dev/null
lsof -ti:8080 | xargs kill -9 2>/dev/null

# تفعيل دعم الويب
echo "📦 تفعيل دعم الويب..."
flutter config --enable-web > /dev/null 2>&1

# تحديث الحزم + توليد الترجمة
echo "📥 تحديث الحزم وتوليد الترجمة..."
./prepare_project.sh

# بناء التطبيق
echo ""
echo "🔨 جاري بناء التطبيق... (قد يستغرق بضع دقائق)"
echo ""

if flutter build web --web-renderer html; then
    echo ""
    echo "✅ البناء مكتمل بنجاح!"
    echo ""
    
    # الانتقال إلى مجلد البناء
    cd build/web
    
    # التحقق من وجود index.html
    if [ ! -f "index.html" ]; then
        echo "❌ خطأ: ملف index.html غير موجود!"
        exit 1
    fi
    
    echo "🚀 جاري تشغيل الخادم على http://localhost:8000"
    echo ""
    echo "📱 افتح Chrome واذهب إلى: http://localhost:8000"
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
        echo "يرجى تثبيت Python أو استخدام: npx http-server -p 8000"
        exit 1
    fi
else
    echo ""
    echo "❌ فشل البناء!"
    echo ""
    echo "يرجى التحقق من الأخطاء أعلاه"
    exit 1
fi

