# أوامر Flutter للتطبيق

## تشغيل التطبيق

### على iPhone 17 Simulator:
```bash
flutter run -d 50DA77EA-D06D-4073-9EC1-FF2B7B484DB5
```

### على Chrome (Web):
```bash
flutter run -d chrome --web-port=8080
```

### على macOS:
```bash
flutter run -d macos
```

## أوامر Hot Reload و Hot Restart

بعد تشغيل التطبيق، يمكنك استخدام الأوامر التالية في Terminal:

### Hot Reload (إعادة تحميل سريعة - يحافظ على الحالة):
- اضغط `r` في Terminal
- أو اكتب: `r` ثم Enter

### Hot Restart (إعادة تشغيل كاملة - يعيد تعيين الحالة):
- اضغط `R` (حرف كبير) في Terminal
- أو اكتب: `R` ثم Enter

### إيقاف التطبيق:
- اضغط `q` في Terminal
- أو اكتب: `q` ثم Enter

## أوامر أخرى مفيدة:

### عرض قائمة الأوامر:
- اضغط `h` في Terminal

### عرض معلومات التطبيق:
- اضغط `i` في Terminal

### عرض سجلات التطبيق:
- اضغط `v` في Terminal

### إعادة بناء التطبيق:
```bash
flutter run -d 50DA77EA-D06D-4073-9EC1-FF2B7B484DB5
```

## ملاحظات:

- **Hot Reload**: سريع، يحافظ على حالة التطبيق، لكن لا يعيد تحميل الثوابت العامة
- **Hot Restart**: أبطأ قليلاً، لكنه يعيد تحميل كل شيء بما في ذلك الثوابت

## حالات الاستخدام:

- استخدم **Hot Reload** (`r`) عند تعديل:
  - UI components
  - Widgets
  - Styles
  - Colors
  - Text

- استخدم **Hot Restart** (`R`) عند تعديل:
  - الثوابت العامة (const values)
  - initState
  - Global variables
  - App configuration
