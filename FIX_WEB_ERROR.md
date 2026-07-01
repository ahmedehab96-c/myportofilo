# حل مشكلة خطأ -102 في Chrome

## المشكلة:
خطأ -102 يعني أن Chrome لا يستطيع الاتصال بالخادم المحلي على `http://localhost:8080/`

## الحلول:

### الحل الأول: استخدام السكريبت المحدث
```bash
./run_chrome.sh
```

### الحل الثاني: بناء ثم تشغيل خادم محلي
```bash
# 1. بناء التطبيق
flutter build web --web-renderer html

# 2. الانتقال إلى مجلد البناء
cd build/web

# 3. تشغيل خادم محلي (اختر واحداً):
# باستخدام Python 3:
python3 -m http.server 8000

# أو باستخدام Python 2:
python -m SimpleHTTPServer 8000

# أو باستخدام Node.js:
npx http-server -p 8000
```

ثم افتح المتصفح على: `http://localhost:8000`

### الحل الثالث: استخدام Flutter Run مع إعدادات محددة
```bash
flutter run -d chrome --web-port=8080 --web-hostname=localhost --web-renderer=html
```

### الحل الرابع: التحقق من المنافذ المستخدمة
```bash
# التحقق من المنافذ المستخدمة
lsof -i :8080
lsof -i :8000

# إذا كان المنفذ مستخدماً، قم بقتل العملية:
kill -9 <PID>
```

### الحل الخامس: استخدام منفذ مختلف
```bash
flutter run -d chrome --web-port=3000
```

ثم افتح: `http://localhost:3000`

## نصائح إضافية:

1. **تأكد من أن Flutter web مفعّل:**
```bash
flutter config --enable-web
flutter doctor
```

2. **إذا استمرت المشكلة، جرب:**
```bash
flutter clean
flutter pub get
flutter build web
```

3. **للتحقق من أن Chrome يعمل:**
```bash
flutter devices
```

يجب أن ترى Chrome في القائمة.

4. **إذا لم يعمل Chrome، استخدم المتصفح يدوياً:**
   - شغّل الخادم المحلي
   - افتح Chrome يدوياً
   - اذهب إلى `http://localhost:8000`

