<div align="center">

# Ahmed Ehab Mohammed

### Flutter Developer · Mobile · Web · Full-Stack

[![Portfolio](https://img.shields.io/badge/Portfolio-Live-58A6FF?style=for-the-badge&logo=netlify&logoColor=white)](https://ahmedmyportofilo.netlify.app)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ahmed-ehab-ba8a63285)
[![Email](https://img.shields.io/badge/Email-Contact-EA4335?style=for-the-badge&logo=gmail&logoColor=white)](mailto:ahmed96it96@gmail.com)

**Crafting production-ready Flutter apps with clean architecture, polished UX, and real-world backends.**

[🌐 Live Portfolio](https://ahmedmyportofilo.netlify.app) · [💼 LinkedIn](https://www.linkedin.com/in/ahmed-ehab-ba8a63285) · [🐙 GitHub](https://github.com/ahmedehab96-c)

</div>

---

## About

This repository powers my **interactive portfolio website** — built with Flutter Web and deployed on Netlify (~25 MB, fast load).

Each featured project includes:
- **Download APK** hosted on this portfolio (`/apks/…`)
- **Open live demo** where available (Render admin or Flutter web admin)
- Step-by-step try guide on each project page

---

## Featured Projects

| Project | Description | Live demo | APK |
|---------|-------------|-----------|-----|
| **HRM NAWA TECH** | HR SaaS — Filament admin + Flutter employee app | [Render admin](https://hrm-nawa-api.onrender.com/admin) | [/apks/hrm.apk](https://ahmedmyportofilo.netlify.app/apks/hrm.apk) |
| **Life OS** | Productivity — tasks, habits, finance, Groq AI | — | [/apks/lifeos.apk](https://ahmedmyportofilo.netlify.app/apks/lifeos.apk) |
| **Mezo Food App** | Food delivery + Flutter web admin, Firebase, Stripe | [Web admin](https://ahmedmyportofilo.netlify.app/demos/mezo-admin/) | [/apks/mezo.apk](https://ahmedmyportofilo.netlify.app/apks/mezo.apk) |
| **IT Assist NAWA TECH** | ITSM — tickets, AI, Socket.IO, Laravel | [Render panel](https://it-assist-api.onrender.com/panel/login) | [/apks/itassist.apk](https://ahmedmyportofilo.netlify.app/apks/itassist.apk) |
| **Werdi Quran App** | Memorization, tasmee3, Mushaf, ayah audio | — | [/apks/werdi.apk](https://ahmedmyportofilo.netlify.app/apks/werdi.apk) |

---

## Tech Stack

`Flutter` · `Dart` · `Laravel` · `Firebase` · `Supabase` · `BLoC` · `REST API` · `Socket.IO` · `Stripe` · `Groq AI` · `OpenAI`

---

## Try a Project

### HRM NAWA TECH

**Live admin:** https://hrm-nawa-api.onrender.com/admin  
Admin: `admin@demo.com` / `Admin12345!` · Employee: `emp01@demo.com` / `Employee12345!`  
**APK:** https://ahmedmyportofilo.netlify.app/apks/hrm.apk

---

### Life OS

**APK:** https://ahmedmyportofilo.netlify.app/apks/lifeos.apk  
**Web (local):** clone → `flutter run -d chrome`

---

### Mezo Food App

**Live web admin:** https://ahmedmyportofilo.netlify.app/demos/mezo-admin/  
(Sign in with a Firebase admin: Firestore `admins/{uid}`)  
**APK:** https://ahmedmyportofilo.netlify.app/apks/mezo.apk

---

### IT Assist NAWA TECH

**Live admin:** https://it-assist-api.onrender.com/panel/login  
IT Admin: `it@company.com` / `password`  
**APK:** https://ahmedmyportofilo.netlify.app/apks/itassist.apk

---

### Werdi Quran App

**APK:** https://ahmedmyportofilo.netlify.app/apks/werdi.apk  
No login — open and start.

---

## Build & Deploy (manual Netlify)

### ⚠️ Important — do NOT use this for deploy

```bash
flutter build web --release   # ❌ may pick WASM → black screen on Netlify
```

### ✅ Correct commands

**Preview locally in Chrome:**

```bash
chmod +x build_web.sh run_web.sh scripts/deploy_netlify.sh
./run_web.sh
```

**Publish to Netlify:**

```bash
./scripts/deploy_netlify.sh
```

First time only: `npx netlify-cli login`

After deploy, if the old page shows: **Cmd+Shift+R** (hard reload) in Chrome.

Git push updates GitHub only — **Netlify does not auto-build**.

### Smaller APKs (arm64 only)

```bash
chmod +x scripts/build_portfolio_apks.sh scripts/upload_portfolio_apks.sh
./scripts/build_portfolio_apks.sh
./scripts/upload_portfolio_apks.sh
```

---

## Contact

| | |
|---|---|
| **Email** | ahmed96it96@gmail.com |
| **GitHub** | [@ahmedehab96-c](https://github.com/ahmedehab96-c) |
| **LinkedIn** | [Ahmed Ehab](https://www.linkedin.com/in/ahmed-ehab-ba8a63285) |
| **CV** | [Google Drive](https://drive.google.com/file/d/1Dgux5ROcG1E8R6Mrki8kAWtQcsMviLgv/view?usp=drivesdk) |
| **Portfolio** | [ahmedmyportofilo.netlify.app](https://ahmedmyportofilo.netlify.app) |

---

<div align="center">

**Open to work** — mobile, web, and full-stack Flutter roles.

</div>
