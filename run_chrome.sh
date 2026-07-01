#!/bin/bash

echo "🚀 جاري تشغيل التطبيق على Chrome..."
echo ""

# الانتقال إلى مجلد المشروع
cd "$(dirname "$0")"

# التحقق من Flutter
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter غير مثبت أو غير موجود في PATH"
    exit 1
fi

# تفعيل دعم الويب
echo "📦 تفعيل دعم الويب..."
flutter config --enable-web

# تحديث الحزم + توليد ملفات الترجمة (مطلوب قبل كل تشغيل)
echo "📥 تحديث الحزم وتوليد الترجمة..."
./prepare_project.sh

# التحقق من Chrome
if ! command -v google-chrome &> /dev/null && ! command -v chromium &> /dev/null && ! command -v chromium-browser &> /dev/null; then
    echo "⚠️  Chrome غير موجود في PATH، سيحاول Flutter العثور عليه تلقائياً"
fi

# تشغيل التطبيق
echo "🌐 تشغيل التطبيق على Chrome..."
echo "⏳ يرجى الانتظار... قد يستغرق التجميع الأول وقتاً..."
echo ""
flutter run -d chrome --web-port=8080 --web-hostname=localhost

