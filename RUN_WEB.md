# كيفية تشغيل التطبيق على Chrome

## الطريقة الأولى: استخدام Flutter Run
```bash
flutter run -d chrome
```

## الطريقة الثانية: بناء ثم تشغيل
```bash
# بناء التطبيق للويب
flutter build web

# تشغيل خادم محلي
cd build/web
python3 -m http.server 8000
# أو
npx http-server -p 8000
```

ثم افتح المتصفح على: `http://localhost:8000`

## الطريقة الثالثة: استخدام Flutter DevTools
```bash
flutter run -d chrome --web-port=8080
```

## استكشاف الأخطاء:

1. **تأكد من تفعيل دعم الويب:**
```bash
flutter config --enable-web
```

2. **تحقق من الأجهزة المتاحة:**
```bash
flutter devices
```

3. **تأكد من تثبيت Chrome:**
   - يجب أن يكون Chrome مثبتاً على النظام
   - يمكنك استخدام `google-chrome` أو `chromium` أيضاً

4. **إذا لم يعمل، جرب:**
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

## ملاحظات:
- قد يستغرق التجميع الأول وقتاً أطول
- تأكد من أن Chrome مثبت ومتاح في PATH
- إذا ظهرت أخطاء، تحقق من إصدار Flutter: `flutter --version`

