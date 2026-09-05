/// Single source of truth for portfolio UI and AI assistant (all platforms).
class PortfolioContent {
  PortfolioContent._();

  /// Bump when assistant/portfolio data changes (shown in chat to verify web load).
  static const assistantDataVersion = '3.8.0';

  /// Project IDs shown large in the bento grid layout.
  static const bentoFeaturedIds = {'hrm', 'mezo'};

  static const featuredProjects = <PortfolioProject>[
    PortfolioProject(
      id: 'hrm',
      title: 'HRM NAWA TECH',
      cardDescription:
          'Multi-tenant HR SaaS — Filament admin, React dashboard, Flutter employee app, live Render demo.',
      readme: '''
HRM NAWA TECH is a full-stack multi-tenant HR platform built with Laravel Filament (admin), a React SPA dashboard, and Flutter (employee app).

**What it ships today**
• Company self-registration + 14-day free trial
• Plan employee caps (trial / starter / growth / enterprise)
• Filament admin (AR/EN, RTL/LTR, dark mode)
• React SPA dashboard (employees, departments, attendance, leave, payroll, recruitment, performance, reports, roles & permissions) consuming the same Sanctum-token API
• Responsive Flutter employee UI (phone / tablet / desktop)
• AI-assisted recruitment, leave, performance, and reports
• Docker, queues, scheduler, `/api/health`, GitHub Actions CI

**Live demo (Render)**
• Admin: https://hrm-nawa-api.onrender.com/admin
• React dashboard: https://hrm-nawa-api.onrender.com/dashboard
• Demo admin: admin@demo.com / Admin12345!
• Demo employee: emp01@demo.com / Employee12345!
• API health: https://hrm-nawa-api.onrender.com/api/health
(First open after idle may take ~30–60s on free tier.)

Source is private — email your GitHub username for collaborator access.''',
      cardImage: 'assets/images/hrm_screens.png',
      screenshots: [
        'assets/images/hrm_screens.png',
      ],
      summary: 'Multi-tenant HR SaaS — Filament admin, React dashboard, Flutter app, live demo.',
      features: [
        'Filament admin + React SPA dashboard + Flutter employee app',
        'Multi-tenant SaaS trial & plans',
        'Responsive phone / tablet / desktop layouts',
        'AI workflows + live public demo on Render',
        'Attendance, payroll, leave, recruitment',
        'Role-based access and bilingual support',
      ],
      tech: [
        'Flutter',
        'Laravel',
        'Filament',
        'React',
        'Sanctum',
        'REST API',
        'go_router',
        'Docker',
        'GitHub Actions',
      ],
      keywords: [
        'hrm',
        'hrm nawa tech',
        'nawa tech hr',
        'react',
        'react dashboard',
        'react spa',
        'saas',
        'multi-tenant',
        'trial',
        'subscription',
        'human resources',
        'hr system',
        'payroll',
        'attendance',
        'employees',
        'leave request',
        'laravel',
        'filament',
        'platform console',
        'ai command center',
        'recruitment',
        'live demo',
        'render',
        'rbac',
        'responsive',
      ],
      categories: ['SaaS', 'Mobile', 'Web', 'Backend', 'AI'],
      githubUrl: 'https://github.com/ahmedehab96-c/hrm-nawa-tech',
      isGithubPrivate: true,
      apkUrl: 'https://ahmedmyportofilo.netlify.app/apks/hrm.apk',
      liveDemoUrl: 'https://hrm-nawa-api.onrender.com/admin',
      webSetupGuide: '''**Live demo (no local setup required)**
1. Tap **Open live demo** (or open https://hrm-nawa-api.onrender.com/admin)
2. Admin: admin@demo.com / Admin12345!
3. Employee: emp01@demo.com / Employee12345!
4. React dashboard: https://hrm-nawa-api.onrender.com/dashboard (same demo accounts)
5. API health: https://hrm-nawa-api.onrender.com/api/health

Cold start on free Render may take 30–60s after idle.

**Android APK**
1. Tap **Download APK** in this Try section
2. Install on your phone (allow unknown sources if asked)
3. Sign in with the demo employee account above

**Source:** private — email your GitHub username for access.''',
    ),
    PortfolioProject(
      id: 'lifeos',
      title: 'Life OS',
      cardDescription:
          'Free personal productivity app — tasks, habits, goals, finance, notes, and Groq-powered AI assistant with offline SQLite and Supabase sync.',
      readme: '''
Life OS is a completely free Flutter app for organizing life: tasks, expenses, goals, habits, notes, and an AI assistant.

The dashboard combines daily task planning, habit tracking, finance charts, goal progress, and smart reminders. Data is stored locally with SQLite for offline use and synced to Supabase when online. The built-in AI assistant uses an open-source Llama model via Groq, supports speech-to-text input, and can execute real commands on your data.''',
      cardImage: 'assets/images/lifeos_mockup.png',
      screenshots: [
        'assets/images/lifeos_mockup.png',
      ],
      summary: 'Productivity app — tasks, habits, finance, Groq AI, Supabase sync.',
      features: [
        'Daily tasks, habits, goals, and notes',
        'Finance tracking with charts and insights',
        'Groq-powered AI assistant with speech-to-text',
        'AI executes real commands on local data',
        'Local offline storage via SQLite',
        'Cloud sync powered by Supabase',
        'Smart local notifications and reminders',
        'Responsive layouts for phone, tablet, and web',
      ],
      tech: ['Flutter', 'BLoC', 'Supabase', 'SQLite', 'Groq AI'],
      keywords: [
        'lifeos',
        'life os',
        'productivity',
        'habits',
        'goals',
        'reminders',
        'daily planner',
        'lifestyle app',
        'supabase',
        'bloc',
        'sqlite',
        'groq',
        'ai assistant',
        'responsive',
      ],
      categories: ['Mobile', 'AI'],
      githubUrl: 'https://github.com/ahmedehab96-c/LifeOS',
      isGithubPrivate: false,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.ahmed.lifeos',
      webSetupGuide: '''Free on Google Play — install and start instantly.

Run web locally: clone [LifeOS](https://github.com/ahmedehab96-c/LifeOS), then `flutter pub get` and `flutter run -d chrome`.''',
    ),
    PortfolioProject(
      id: 'mezo',
      title: 'Mezo Food App',
      cardDescription:
          'Food ordering + delivery — Flutter app, responsive Flutter Web admin, Firebase, Google Maps, Stripe/demo/cash.',
      readme: '''
Mezo Food App (from project README) - food ordering and delivery with a customer mobile app and a responsive admin web dashboard.

**Customer app (iOS / Android)**
• Browse menu from Firestore (with demo fallback)
• Cart, favorites, checkout
• Google Maps - pick delivery location on map + GPS
• Order tracking (My Orders + status timeline)
• Arabic / English (RTL)
• Sign in with email or Google
• Stripe card + demo test card + cash on delivery
• Push notifications (order status)

**Admin panel (Web)**
• Responsive dashboard (orders list + detail)
• Update order status (pending → preparing → on the way → delivered)
• Product management - add, edit, delete menu items
• Delivery address + map preview when coordinates exist
• Arabic / English sidebar
• Admin push notifications for new orders

**Backend (Firebase)**
• Firestore - users, products, orders, admins
• Cloud Functions - Stripe PaymentIntent, push notifications
• Security rules for customers and admins

**Live demo**
• Web admin: https://ahmedmyportofilo.netlify.app/demos/mezo-admin/
• Admin: admin@mezofood.com / MezoDemo123!
• Android APK: https://ahmedmyportofilo.netlify.app/apks/mezo.apk''',
      cardImage: 'assets/images/mezo_screens.png',
      screenshots: [
        'assets/images/mezo_screens.png',
      ],
      summary: 'Food delivery — Flutter app, web admin, Firebase, Maps & Stripe.',
      features: [
        'Menu from Firestore with demo fallback',
        'Cart, favorites, checkout (Stripe / demo card / cash)',
        'Google Maps delivery picker + GPS',
        'Order tracking timeline + FCM push',
        'Arabic / English RTL customer + admin UI',
        'Responsive Flutter Web admin dashboard',
        'Order status workflow + product CRUD',
        'Firebase Auth, Firestore, Cloud Functions',
        'Live web admin on this portfolio + Android APK',
      ],
      tech: [
        'Flutter',
        'BLoC',
        'Firebase',
        'Stripe',
        'Google Maps',
        'Cloud Functions',
      ],
      keywords: [
        'mezo',
        'mezo food',
        'food delivery',
        'food app',
        'restaurant',
        'order food',
        'menu',
        'cart',
        'checkout',
        'firebase',
        'stripe',
        'admin dashboard',
        'google maps',
        'live demo',
        'apk',
        'responsive',
        'rtl',
      ],
      categories: ['Mobile', 'Web', 'Backend'],
      githubUrl: 'https://github.com/ahmedehab96-c/mezo-food-app',
      isGithubPrivate: true,
      apkUrl: 'https://ahmedmyportofilo.netlify.app/apks/mezo.apk',
      liveDemoUrl: 'https://ahmedmyportofilo.netlify.app/demos/mezo-admin/',
      webSetupGuide: '''**Live web admin (credentials from project README)**
1. Tap **Open live demo** → https://ahmedmyportofilo.netlify.app/demos/mezo-admin/
2. Admin: admin@mezofood.com / MezoDemo123!
3. Explore orders inbox, order detail + map, product management

**Android APK**
1. Tap **Download APK** → install → explore menu, cart, Maps checkout, demo card / cash

**Payment modes (README)**
1. Cash on delivery
2. Demo card (one-tap test when `pk_test_` is set)
3. Stripe card via Cloud Function `createPaymentIntent`

**Run admin locally**
`flutter run -d chrome -t lib/admin/main_admin.dart` or `bash scripts/run_admin_web.sh`''',
    ),
    PortfolioProject(
      id: 'itassist',
      title: 'IT Assist NAWA TECH',
      cardDescription:
          'ITSM SaaS — Flutter app + Laravel panel/API, live Render demo, tickets, AI, Socket.IO, biometrics.',
      readme: '''
IT Assist - Nawa Tech (from project README): Smart IT Support SaaS - Flutter Mobile App + Laravel Web Panel + REST API.

A full-stack ITSM platform for companies to manage IT support requests, incidents, change requests, and assets - with an AI-powered assistant and a bilingual web admin panel.

**Mobile app**
• Tickets, service requests, change requests, incidents
• OpenAI-powered IT chat assistant
• Biometric login, FCM push with deep links
• Remote support (AnyDesk / TeamViewer)
• Knowledge base, device inventory, network diagnostics
• Offline detection, Arabic/English RTL, dark theme

**Web admin panel**
• Real-time dashboard (stats + charts, SLA)
• Ticket / service / change / incident management
• SLA policies, knowledge base, user management
• Multi-tenant data isolation, bilingual AR/EN

**Live demo (Render)** - credentials from project README
• Panel: https://it-assist-api.onrender.com/panel/login
• IT Admin: it@company.com / password
• Employee: mohammed@company.com / password
(Cold start on free Render may take 30-60s.)

**Android APK:** https://ahmedmyportofilo.netlify.app/apks/itassist.apk''',
      cardImage: 'assets/images/itassist_screens.png',
      screenshots: [
        'assets/images/itassist_screens.png',
      ],
      summary: 'ITSM SaaS — Flutter mobile, Laravel API, live admin, tickets & AI.',
      features: [
        'Tickets, service requests, change requests, incidents',
        'OpenAI IT chat assistant',
        'Real-time updates (Socket.IO) + FCM push',
        'Biometric login + remote support sessions',
        'Knowledge base, devices, network diagnostics',
        'Admin dashboard with SLA and multi-tenant isolation',
        'Bilingual Arabic/English (RTL) mobile + panel',
        'Live Render admin demo + Android APK',
        'Sentry error monitoring',
      ],
      tech: ['Flutter', 'Laravel', 'Socket.IO', 'Firebase', 'OpenAI'],
      keywords: [
        'it assist',
        'it assist nawa tech',
        'nawa tech it',
        'helpdesk',
        'it support',
        'ticketing',
        'asset management',
        'it system',
        'itsm',
        'socket.io',
        'laravel',
        'firebase',
        'live demo',
        'render',
        'apk',
        'responsive',
        'sla',
      ],
      categories: ['SaaS', 'Mobile', 'Web', 'Backend', 'AI'],
      githubUrl: 'https://github.com/ahmedehab96-c/it-assist-nawa-tech',
      isGithubPrivate: true,
      apkUrl: 'https://ahmedmyportofilo.netlify.app/apks/itassist.apk',
      liveDemoUrl: 'https://it-assist-api.onrender.com/panel/login',
      webSetupGuide: '''**Live demo (credentials from project README)**
1. Tap **Open live demo** → https://it-assist-api.onrender.com/panel/login
2. IT Admin: it@company.com / password
3. Employee: mohammed@company.com / password
4. Cold start may take 30-60s after idle

**Android APK**
1. Tap **Download APK** → install → explore tickets, KB, AI assistant

**Local setup (README)**
1. Backend: `cd backend && composer install && php artisan migrate --seed && php artisan serve`
2. Flutter: `flutter run --dart-define-from-file=config/dev.json`
3. Panel: http://127.0.0.1:8000/panel/login''',
    ),
    PortfolioProject(
      id: 'werdi',
      title: 'Werdi Quran App',
      cardDescription:
          'Quran memorization app (v1.0.1+11) — no login, local progress, tasmee3 with speech evaluation, Mushaf, ayah audio, and achievements.',
      readme: '''
Werdi v1.0.1 is a Quran memorization and revision app. The latest release removes the login gate — open the app and start immediately. Progress is stored locally on the device, with optional Supabase sync.

Core flows: animated splash and onboarding, home dashboard with daily goals, ayah-by-ayah memorization with repetition and playback speed, smart revision sessions, voice recitation (tasmee3) with recording and speech-to-text feedback, Mushaf browsing, search/tafsir/bookmarks, ayah-by-ayah audio with multiple reciters, achievements, and daily reminder notifications.

Built with Clean Architecture, BLoC, go_router, Drift, just_audio, and Supabase. Material 3 themes and responsive layout for phones and tablets.''',
      cardImage: 'assets/images/werdi_showcase.png',
      screenshots: [
        'assets/images/werdi_showcase.png',
      ],
      summary: 'Quran app — memorization, tasmee3, Mushaf, ayah audio, no login.',
      features: [
        'No login — open and start instantly',
        'Home dashboard with today\'s goal and progress overview',
        'Local user progress stored on device (Drift)',
        'Ayah-by-ayah memorization with repetition and playback speed',
        'Voice recitation (tasmee3) with speech evaluation and diff UI',
        'Smart revision list, achievements, and daily reminders',
        'Mushaf-style ayah display with search, tafsir, and bookmarks',
        'Ayah-by-ayah audio with multiple reciters',
        'Material 3 themes and responsive layout',
        'Optional Supabase sync',
      ],
      tech: [
        'Flutter',
        'BLoC',
        'go_router',
        'Drift',
        'Supabase',
        'just_audio',
        'flutter_screenutil',
      ],
      keywords: [
        'werdi',
        'quran app',
        'memorization',
        'tasmee3',
        'quran revision',
        'islamic app',
        'recitation',
        'no login',
        'ayah audio',
        'achievements',
        'responsive',
      ],
      categories: ['Mobile'],
      githubUrl: 'https://github.com/ahmedehab96-c/werdi',
      isGithubPrivate: false,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.werdi.app',
      webSetupGuide: '''Free on Google Play — install and start instantly.
No login required, start memorizing immediately.''',
    ),
    PortfolioProject(
      id: 'bankx',
      title: 'BankX Digital Banking',
      cardDescription:
          'Flutter banking app — dashboard, transfers, bill pay, cards, and biometric sign-in with Material 3 UI.',
      readme: '''
BankX Digital Banking is a Flutter mobile banking experience with splash, sign-in, home dashboard, transfers, and bill payment flows.

**Highlights**
• Total balance card with quick actions (transfer, pay bills, scan QR, cards)
• Account carousel, spending analytics, and recent activity
• Bill payment by category (electricity, water, internet, mobile)
• Clean Material 3 UI with light/dark-ready layouts
• Responsive phone layouts with polished motion and typography

**Try the demo**
• Download the Android APK from this portfolio''',
      cardImage: 'assets/images/bankx_mockup.png',
      screenshots: [
        'assets/images/bankx_mockup.png',
      ],
      summary: 'Digital banking — dashboard, transfers, bill pay, Material 3 UI.',
      features: [
        'Splash and sign-in with biometric-ready flow',
        'Home dashboard with balance and quick actions',
        'Money transfer and beneficiary flows',
        'Bill payment by service category',
        'Account cards and spending overview',
        'Material 3 UI with polished banking UX',
      ],
      tech: ['Flutter', 'Material 3', 'Clean Architecture', 'REST API ready'],
      keywords: [
        'bankx',
        'banking',
        'digital banking',
        'fintech',
        'mobile banking',
        'transfer',
        'bill payment',
        'flutter',
        'finance app',
      ],
      categories: ['Mobile'],
      isGithubPrivate: true,
      apkUrl: 'https://ahmedmyportofilo.netlify.app/apks/bankx.apk',
      webSetupGuide: '''**Android APK**
1. Tap **Download APK** in this Try section
2. Install on your phone and explore dashboard, transfer, and bill pay flows''',
    ),
    PortfolioProject(
      id: 'stepzone',
      title: 'StepZone',
      cardDescription:
          'Luxury shoe eCommerce — Supabase backend, Google sign-in, coupons, live orders, and AED pricing.',
      readme: '''
StepZone is a premium Flutter eCommerce app for luxury footwear. It connects to a live Supabase backend for products, cart, wishlist, orders, reviews, and coupons.

**Try the demo**
• Email: stepzone.demo@gmail.com / StepZone2026!
• Google Sign-In is enabled
• Coupons: LUXE10, KICKS20, WELCOME15
• Prices in AED; EU sizes 39–44

**Highlights**
• Clean Architecture + GetX
• Remote catalog and product images from Supabase Storage
• Checkout with coupon RPCs and automated order status pipeline
• Reviews on home, explore, wishlist, orders, and product details
• Material 3 light/dark themes and English/Arabic RTL
• React.js + Vite web storefront with Tap Payments (cards, Tabby, Tamara)''',
      cardImage: 'assets/images/stepzone_mockup_v2.png',
      screenshots: [
        'assets/images/stepzone_mockup_v2.png',
      ],
      summary: 'Luxury shoe store — Supabase, Google sign-in, coupons, AED pricing.',
      features: [
        'Live Supabase catalog, cart, wishlist, and orders',
        'Google Sign-In + email demo account',
        'Remote coupons (LUXE10, KICKS20, WELCOME15)',
        'Product reviews across the app',
        'Order status pipeline with cron + Edge Function',
        'Supabase Storage product images',
        'AED pricing and EU shoe sizes',
        'Dark mode and Arabic RTL',
        'React.js web storefront with Tap Payments checkout',
      ],
      tech: [
        'Flutter',
        'GetX',
        'Supabase',
        'PostgreSQL',
        'Edge Functions',
        'Google OAuth',
        'Clean Architecture',
        'Material 3',
        'React.js',
        'Vite',
        'Tap Payments',
      ],
      keywords: [
        'stepzone',
        'shoes',
        'ecommerce',
        'luxury',
        'supabase',
        'flutter',
        'cart',
        'checkout',
        'coupons',
        'google sign in',
        'aed',
        'react',
        'react.js',
        'vite',
        'web storefront',
      ],
      categories: ['Mobile', 'Web', 'Backend'],
      githubUrl: 'https://github.com/ahmedehab96-c/stepzone',
      isGithubPrivate: false,
      apkUrl: 'https://ahmedmyportofilo.netlify.app/apks/stepzone.apk',
      liveDemoUrl: 'https://ahmedmyportofilo.netlify.app/demos/stepzone/',
      webSetupGuide: '''**Web demo or Android APK**
1. Open the **Live demo** link to try StepZone in your browser, or tap **Download APK** to install it
2. Sign in with stepzone.demo@gmail.com / StepZone2026! or use Google
3. Try coupon LUXE10 in the cart''',
    ),
  ];
}

class PortfolioProject {
  const PortfolioProject({
    required this.id,
    required this.title,
    required this.cardDescription,
    required this.readme,
    required this.cardImage,
    required this.screenshots,
    required this.summary,
    required this.features,
    required this.tech,
    required this.keywords,
    required this.categories,
    this.githubUrl,
    this.isGithubPrivate = true,
    this.apkUrl,
    this.playStoreUrl,
    this.liveDemoUrl,
    this.webSetupGuide,
  });

  final String id;
  final String title;
  final String cardDescription;
  final String readme;
  final String cardImage;
  final List<String> screenshots;
  final String summary;
  final List<String> features;
  final List<String> tech;
  final List<String> keywords;
  /// Project category tags: Mobile / Web / Backend / SaaS / AI.
  final List<String> categories;
  final String? githubUrl;
  final bool isGithubPrivate;
  /// Hosted Android APK (prefer Netlify /apks/).
  final String? apkUrl;
  /// Google Play Store listing.
  final String? playStoreUrl;
  /// Hosted live / try web URL (Render admin, portfolio demo page, etc.).
  final String? liveDemoUrl;
  /// Step-by-step try guide (live demo, APK, and/or local web).
  final String? webSetupGuide;

  bool get hasTrySection =>
      apkUrl != null ||
      playStoreUrl != null ||
      liveDemoUrl != null ||
      webSetupGuide != null;

  String get imagePath => cardImage;

  String get assistantDetail {
    final featureLines = features.map((f) => '• $f').join('\n');
    return '''$summary

$readme

Features:
$featureLines

Tech: ${tech.join(', ')}''';
  }

  Map<String, String?> get cardMap => {
        'title': title,
        'desc': cardDescription,
        'img': imagePath,
        'github': githubUrl,
      };
}
