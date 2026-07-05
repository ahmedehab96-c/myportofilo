# Ahmed Ehab Mohammed — Portfolio

Flutter portfolio showcasing mobile, web, and full-stack projects.

**Live site:** [ahmedmyportofilo.netlify.app](https://ahmedmyportofilo.netlify.app)

---

## Build locally

```bash
chmod +x build_web.sh run_web.sh
./build_web.sh
./run_web.sh
# http://localhost:8080
```

Deploy folder: `build/web` (~25 MB)

---

## Try a project

Each project page has **Try this project** with:

- **Download APK** — Android app
- **Try Web Admin** / **Try Web App** — opens the hosted Flutter web build (where available)

Full setup steps for each project are below (English, then Arabic).

> **Note:** Web demos and HRM/Mezo APKs are hosted on a **separate** Netlify site: [ahmed-portfolio-demos.netlify.app](https://ahmed-portfolio-demos.netlify.app) (see [Deploy web demos](#deploy-web-demos-separate-netlify-site)). Life OS, IT Assist, and Werdi APKs are on GitHub Releases.

---

### HRM NAWA TECH

Full-stack HR platform demo: Flutter **admin web panel**, **employee mobile app**, Laravel API, attendance, payroll, leave, recruitment, and AI Command Center.

**How to try (English)**

1. **Web admin** — [ahmed-portfolio-demos.netlify.app/hrm/](https://ahmed-portfolio-demos.netlify.app/hrm/) (or build locally with `./scripts/build_web_demos.sh` and serve `demos-dist/`). Go to `/welcome` → **Try Admin Dashboard**.
2. **Admin login:** `admin@demo.com` / `Admin12345!`
3. **Employee APK** — [hrm.apk](https://ahmed-portfolio-demos.netlify.app/apk/hrm.apk) on the demos site. For full API features, run Laravel (`backend/` → `php artisan serve`) and in app **Settings** enable **Use server API** with `http://YOUR_PC_IP:8000/api`.
4. **Employee login:** `emp01@demo.com` / `Employee12345!`

**كيفية التجربة (عربي)**

1. **لوحة الإدارة (ويب)** — [ahmed-portfolio-demos.netlify.app/hrm/](https://ahmed-portfolio-demos.netlify.app/hrm/). ادخل `/welcome` → **جرّب لوحة الإدارة**.
2. **دخول الأدمن:** `admin@demo.com` / `Admin12345!`
3. **APK الموظف** — [hrm.apk](https://ahmed-portfolio-demos.netlify.app/apk/hrm.apk) من موقع الديمو. للميزات الكاملة شغّل Laravel وفعّل **Use server API** في الإعدادات مع `http://IP_جهازك:8000/api`.
4. **دخول الموظف:** `emp01@demo.com` / `Employee12345!`

---

### Life OS

Free personal productivity app — tasks, habits, goals, finance, notes, and Groq AI assistant.

**How to try (English)**

1. **Web app** — [lifeos demo](https://ahmed-portfolio-demos.netlify.app/lifeos/) (Chrome desktop recommended).
2. **APK** — [GitHub Release](https://github.com/ahmedehab96-c/LifeOS/releases/tag/portfolio-apk-v1) (~65 MB).
3. No login required.

**كيفية التجربة (عربي)**

1. **تطبيق ويب** — [ديمو lifeos](https://ahmed-portfolio-demos.netlify.app/lifeos/) (يفضّل Chrome على الكمبيوتر).
2. **APK** — [إصدار GitHub](https://github.com/ahmedehab96-c/LifeOS/releases/tag/portfolio-apk-v1).
3. بدون تسجيل دخول.

---

### Mezo Food App

Food delivery platform — customer mobile app + Flutter Web **admin panel** (Firebase, Stripe).

**How to try (English)**

1. **Admin web** — [mezo-admin demo](https://ahmed-portfolio-demos.netlify.app/mezo-admin/). Sign in with a Firebase admin user that has an `admins/{uid}` document in Firestore.
2. **Customer APK** — build from the [repo](https://github.com/ahmedehab96-c/mezo-food-app) or [mezo.apk](https://ahmed-portfolio-demos.netlify.app/apk/mezo.apk) on the demos site.

**كيفية التجربة (عربي)**

1. **لوحة الأدمن (ويب)** — [ديمو mezo-admin](https://ahmed-portfolio-demos.netlify.app/mezo-admin/). سجّل دخول بحساب Firebase مع مستند `admins/{uid}` في Firestore.
2. **APK العملاء** — ابنِ من المستودع أو [mezo.apk](https://ahmed-portfolio-demos.netlify.app/apk/mezo.apk) على موقع الديمو.

---

### IT Assist NAWA TECH

ITSM platform — Flutter mobile/web app, Laravel API, tickets, AI assistant, Socket.IO.

**How to try (English)**

1. **Flutter web app** — [itassist demo](https://ahmed-portfolio-demos.netlify.app/itassist/).
2. **APK** — [GitHub Release v1.0.0](https://github.com/ahmedehab96-c/it-assist-nawa-tech/releases/tag/v1.0.0) (~66 MB).
3. **Laravel admin panel** — `http://127.0.0.1:8000/panel/login` after `php artisan migrate --seed` locally.  
   IT Admin: `it@company.com` / `password` · Employee: `mohammed@company.com` / `password`

**كيفية التجربة (عربي)**

1. **تطبيق ويب Flutter** — [ديمو itassist](https://ahmed-portfolio-demos.netlify.app/itassist/).
2. **APK** — [إصدار GitHub v1.0.0](https://github.com/ahmedehab96-c/it-assist-nawa-tech/releases/tag/v1.0.0).
3. **لوحة Laravel** — `http://127.0.0.1:8000/panel/login` بعد `migrate --seed` محلياً.  
   أدمن IT: `it@company.com` / `password` · موظف: `mohammed@company.com` / `password`

---

### Werdi Quran App

Quran memorization app (v1.0.1+11) — mobile only, no login.

**How to try (English)**

1. **APK (arm64)** — [GitHub Release](https://github.com/ahmedehab96-c/werdi/releases/tag/portfolio-apk-v1) (~50 MB).
2. No web build. Open app → memorization, Mushaf, tasmee3, ayah audio.

**كيفية التجربة (عربي)**

1. **APK (arm64)** — [إصدار GitHub](https://github.com/ahmedehab96-c/werdi/releases/tag/portfolio-apk-v1).
2. بدون نسخة ويب. افتح التطبيق → حفظ، مصحف، تسميع، صوت الآيات.

---

## Deploy (Netlify)

Git push triggers `scripts/netlify_build.sh` via `netlify.toml`.

```bash
NETLIFY_DEPLOY=1 ./build_web.sh
netlify deploy --prod --dir=build/web
```

### Deploy web demos (separate Netlify site)

Web demos stay **off** the main portfolio deploy (~25 MB). Build them from sibling Flutter projects on your Desktop, then publish `demos-dist/` to a second Netlify site.

**Demos base URL (portfolio links):** `https://ahmed-portfolio-demos.netlify.app`

```bash
chmod +x scripts/build_web_demos.sh
./scripts/build_web_demos.sh
# Output: demos-dist/ (hrm/, lifeos/, mezo-admin/, itassist/, apk/*.apk)

# One-time: create a new site on Netlify, then deploy:
netlify deploy --prod --dir=demos-dist
```

For **continuous deploy** from Git, add a second Netlify site that uses `netlify-demos.toml` as its config (rename or set in Netlify UI: publish `demos-dist`, build `./scripts/netlify_demos_build.sh`). CI cannot reach your Desktop projects — run `build_web_demos.sh` locally before push, or use manual `netlify deploy`.

Override the demos URL when building the portfolio:

```bash
flutter build web --dart-define=DEMOS_BASE_URL=https://your-demos.netlify.app
```

| Demo | Path |
|------|------|
| HRM admin | `/hrm/` |
| Life OS | `/lifeos/` |
| Mezo admin | `/mezo-admin/` |
| IT Assist | `/itassist/` |
| HRM / Mezo APK | `/apk/hrm.apk`, `/apk/mezo.apk` |

Werdi has no web build (APK on GitHub Releases only).

---

## Contact

- Email: ahmed96it96@gmail.com  
- GitHub: [ahmedehab96-c](https://github.com/ahmedehab96-c)  
- LinkedIn: [Ahmed Ehab](https://www.linkedin.com/in/ahmed-ehab-ba8a63285)
