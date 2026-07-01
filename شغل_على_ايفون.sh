#!/bin/bash

echo "═══════════════════════════════════════════════════════"
echo "   📱 تشغيل البرتفليو على iPhone 17"
echo "═══════════════════════════════════════════════════════"
echo ""

cd "$(dirname "$0")"

# التحقق من Flutter
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter غير مثبت!"
    exit 1
fi

# تشغيل محاكي iPhone 17
echo "📱 جاري تشغيل محاكي iPhone 17..."
xcrun simctl boot "iPhone 17" 2>/dev/null || echo "المحاكي يعمل بالفعل"
open -a Simulator 2>/dev/null

# انتظار قليل
echo "⏳ انتظار 5 ثوانٍ..."
sleep 5

# تنظيف
echo "🧹 تنظيف المشروع..."
flutter clean > /dev/null 2>&1

# تحديث الحزم
echo "📥 تحديث الحزم..."
flutter pub get > /dev/null 2>&1

# التحقق من الأجهزة
echo ""
echo "🔍 التحقق من الأجهزة المتاحة..."
flutter devices

echo ""
echo "🚀 جاري تشغيل التطبيق على iPhone 17..."
echo "⏳ يرجى الانتظار... قد يستغرق بضع دقائق..."
echo ""

# تشغيل التطبيق
flutter run -d "iPhone 17"

