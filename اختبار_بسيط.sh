#!/bin/bash

cd "$(dirname "$0")"

echo "═══════════════════════════════════════════════════════"
echo "   🧪 اختبار بسيط للخادم"
echo "═══════════════════════════════════════════════════════"
echo ""

# تنظيف المنافذ
lsof -ti:8000 | xargs kill -9 2>/dev/null
lsof -ti:8080 | xargs kill -9 2>/dev/null

echo "🚀 جاري تشغيل خادم اختبار على http://localhost:8000"
echo ""
echo "📱 افتح Chrome واذهب إلى: http://localhost:8000/test_server.html"
echo ""
echo "⏹️  لإيقاف الخادم، اضغط Ctrl+C"
echo ""

if command -v python3 &> /dev/null; then
    python3 -m http.server 8000
elif command -v python &> /dev/null; then
    python -m SimpleHTTPServer 8000
else
    echo "❌ Python غير مثبت!"
    exit 1
fi

