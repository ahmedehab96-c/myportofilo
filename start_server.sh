#!/bin/bash

# سكريبت بسيط لتشغيل الخادم

cd "$(dirname "$0")/build/web"

if [ ! -f "index.html" ]; then
    echo "❌ مجلد build/web غير موجود أو فارغ!"
    echo "يرجى بناء التطبيق أولاً:"
    echo "  flutter build web"
    exit 1
fi

echo "🚀 جاري تشغيل الخادم على http://localhost:8000"
echo "📱 افتح المتصفح على: http://localhost:8000"
echo ""
echo "⏹️  لإيقاف الخادم، اضغط Ctrl+C"
echo ""

if command -v python3 &> /dev/null; then
    python3 -m http.server 8000
elif command -v python &> /dev/null; then
    python -m SimpleHTTPServer 8000
else
    echo "❌ Python غير مثبت!"
    echo "يمكنك استخدام: npx http-server -p 8000"
    exit 1
fi

