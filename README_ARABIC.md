# 🚀 كيفية فتح البرتفليو

## الطريقة الأسهل (انقر نقراً مزدوجاً):

1. انقر نقراً مزدوجاً على الملف: **افتح_البرتفليو.command**
2. انتظر حتى ينتهي البناء
3. افتح Chrome واذهب إلى: **http://localhost:8000**

---

## الطريقة اليدوية:

### في Terminal:

```bash
# 1. الانتقال إلى مجلد المشروع
cd /Users/ahmedehabmohammed/Desktop/myportofilo

# 2. تفعيل دعم الويب
flutter config --enable-web

# 3. تنظيف المشروع
flutter clean

# 4. تحديث الحزم
flutter pub get

# 5. بناء التطبيق
flutter build web

# 6. الانتقال إلى مجلد البناء
cd build/web

# 7. تشغيل خادم محلي
python3 -m http.server 8000
```

### ثم افتح Chrome:
اذهب إلى: **http://localhost:8000**

---

## استخدام Flutter Run مباشرة:

```bash
cd /Users/ahmedehabmohammed/Desktop/myportofilo
flutter run -d chrome
```

---

## استكشاف الأخطاء:

### إذا ظهر خطأ -102:
- تأكد من أن الخادم يعمل
- جرب منفذ آخر: `python3 -m http.server 3000`

### إذا لم يعمل Python:
```bash
cd build/web
npx http-server -p 8000
```

### إذا لم يفتح Chrome تلقائياً:
- افتح Chrome يدوياً
- اذهب إلى: `http://localhost:8000`

---

## ملاحظات:

- ⏳ البناء الأول قد يستغرق 2-5 دقائق
- 🔄 بعد التعديلات، أعد البناء: `flutter build web`
- 🛑 لإيقاف الخادم: اضغط `Ctrl+C` في Terminal

