# حل مشكلة ERR_CONNECTION_REFUSED

## المشكلة:
الخادم المحلي لا يعمل، لذلك Chrome لا يستطيع الاتصال.

## الحل السريع:

### الطريقة الأولى: استخدام السكريبت
```bash
cd /Users/ahmedehabmohammed/Desktop/myportofilo
./شغل_البرتفليو.sh
```

### الطريقة الثانية: الأوامر اليدوية

**1. افتح Terminal**

**2. انسخ والصق الأوامر التالية واحداً تلو الآخر:**

```bash
cd /Users/ahmedehabmohammed/Desktop/myportofilo
```

```bash
flutter config --enable-web
```

```bash
flutter clean
```

```bash
flutter pub get
```

```bash
flutter build web
```

**انتظر حتى ينتهي البناء** (ستظهر رسالة "Build succeeded")

```bash
cd build/web
```

```bash
python3 -m http.server 8000
```

**3. بعد ظهور:**
```
Serving HTTP on 0.0.0.0 port 8000 ...
```

**4. افتح Chrome واذهب إلى:**
```
http://localhost:8000
```

---

## استكشاف الأخطاء:

### إذا قال "python3: command not found":
```bash
python -m SimpleHTTPServer 8000
```

### إذا قال "port already in use":
```bash
# تنظيف المنفذ
lsof -ti:8000 | xargs kill -9

# أو استخدم منفذ آخر
python3 -m http.server 3000
```

### إذا قال "flutter: command not found":
- تأكد من تثبيت Flutter
- أضف Flutter إلى PATH

### إذا فشل البناء:
```bash
flutter doctor
flutter clean
flutter pub get
flutter build web --verbose
```

---

## ملاحظات مهمة:

1. ⏳ البناء الأول قد يستغرق 2-5 دقائق
2. 🔄 بعد أي تعديلات، أعد البناء: `flutter build web`
3. 🛑 لإيقاف الخادم: اضغط `Ctrl+C` في Terminal
4. ✅ تأكد من أن Terminal مفتوح في مجلد المشروع

---

## إذا استمرت المشكلة:

1. تأكد من أن Flutter مثبت: `flutter --version`
2. تأكد من أن Python مثبت: `python3 --version`
3. جرب منفذ آخر: `python3 -m http.server 3000`
4. افتح Chrome يدوياً واذهب إلى `http://localhost:8000`

