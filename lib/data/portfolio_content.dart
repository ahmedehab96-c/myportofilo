/// Single source of truth for portfolio UI and AI assistant (all platforms).
class PortfolioContent {
  PortfolioContent._();

  /// Bump when assistant/portfolio data changes (shown in chat to verify web load).
  static const assistantDataVersion = '3.2.0';

  /// Remote Netlify site for web demos + hosted APKs (separate from portfolio).
  /// Override at build: --dart-define=DEMOS_BASE_URL=https://your-demos.netlify.app
  static const demosBaseUrl = String.fromEnvironment(
    'DEMOS_BASE_URL',
    defaultValue: 'https://ahmed-portfolio-demos.netlify.app',
  );

  static String get _demosOrigin {
    final u = demosBaseUrl.trim();
    if (u.endsWith('/')) return u.substring(0, u.length - 1);
    return u;
  }

  /// Resolve a path on the remote demos host (e.g. `/hrm/` → full URL).
  static String demosUrl(String path) {
    final p = path.startsWith('/') ? path : '/$path';
    return '$_demosOrigin$p';
  }

  /// Project IDs shown large in the bento grid layout.
  static const bentoFeaturedIds = {'hrm', 'mezo'};

  static const featuredProjects = <PortfolioProject>[
    PortfolioProject(
      id: 'hrm',
      title: 'HRM NAWA TECH',
      cardDescription:
          'Portfolio demo HR platform with admin web panel, employee mobile app, attendance, payroll, recruitment, and AI Command Center.',
      readme: '''
HRM NAWA TECH is a full-stack HR management portfolio demo built for NAWA TECH with Flutter and Laravel. It is not a commercial SaaS product — it showcases full-stack, mobile, and AI skills for employers and recruiters.

**Project goal:** Build a realistic HR platform that unifies admin web dashboards, employee mobile workflows, attendance, payroll, leave management, recruitment, and an AI Command Center — demonstrating production-ready Flutter + Laravel architecture for enterprise HR teams.

The admin web dashboard offers real-time visibility into employees, attendance, pending leave requests, payroll, recruitment, and an AI Command Center. Employees use the mobile app to clock in, request leave, view payslips, and receive notifications. The system supports role-based access, PDF report generation, and bilingual localization with light/dark themes.''',
      cardImage: 'assets/images/hrm_dashboard.png',
      screenshots: [
        'assets/images/hrm_login.png',
        'assets/images/hrm_dashboard.png',
        'assets/images/hrm_mobile.png',
        'assets/images/hrm_employees.png',
      ],
      summary:
          'Full-stack HR platform demo with admin web, employee app, and AI Command Center.',
      features: [
        'Admin web dashboard and employee mobile app',
        'Attendance tracking and reporting',
        'Payroll management with PDF export',
        'Leave request and approval workflow',
        'Recruitment module and AI Command Center',
        'Role-based access control',
        'Bilingual localization support',
        'Secure local storage with encrypted tokens',
      ],
      tech: ['Flutter', 'Laravel', 'REST API', 'go_router'],
      keywords: [
        'hrm',
        'hrm nawa tech',
        'nawa tech hr',
        'human resources',
        'hr system',
        'payroll',
        'attendance',
        'employees',
        'leave request',
        'laravel',
        'ai command center',
      ],
      githubUrl: 'https://github.com/ahmedehab96-c/hrm-nawa-tech',
      isGithubPrivate: true,
      apkUrl: '/apk/hrm.apk',
      webTryPath: '/hrm/',
      webTryIsAdmin: true,
    ),
    PortfolioProject(
      id: 'lifeos',
      title: 'Life OS',
      cardDescription:
          'Free personal productivity app — tasks, habits, goals, finance, notes, and Groq-powered AI assistant with offline SQLite and Supabase sync.',
      readme: '''
Life OS is a completely free Flutter app for organizing life: tasks, expenses, goals, habits, notes, and an AI assistant.

The dashboard combines daily task planning, habit tracking, finance charts, goal progress, and smart reminders. Data is stored locally with SQLite for offline use and synced to Supabase when online. The built-in AI assistant uses an open-source Llama model via Groq, supports speech-to-text input, and can execute real commands on your data.''',
      cardImage: 'assets/images/lifeos_screens.png',
      screenshots: [
        'assets/images/lifeos_screens.png',
      ],
      summary:
          'Free productivity app with tasks, habits, finance, Groq AI, and Supabase sync.',
      features: [
        'Daily tasks, habits, goals, and notes',
        'Finance tracking with charts and insights',
        'Groq-powered AI assistant with speech-to-text',
        'AI executes real commands on local data',
        'Local offline storage via SQLite',
        'Cloud sync powered by Supabase',
        'Smart local notifications and reminders',
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
      ],
      githubUrl: 'https://github.com/ahmedehab96-c/LifeOS',
      isGithubPrivate: false,
      apkUrl:
          'https://github.com/ahmedehab96-c/LifeOS/releases/download/portfolio-apk-v1/app-release.apk',
      webTryPath: '/lifeos/',
      webTryIsAdmin: false,
    ),
    PortfolioProject(
      id: 'mezo',
      title: 'Mezo Food App',
      cardDescription:
          'Food delivery platform — Flutter mobile app plus Flutter Web admin panel with live orders, product management, and Stripe/Firebase.',
      readme: '''
Mezo Food App is a full food ordering and delivery platform with a polished customer mobile app and a responsive Flutter Web admin dashboard.

The customer app covers splash and login (email or Google), menu browsing from Firestore, product details with sizes and toppings, cart and favorites, Google Maps delivery picker with GPS, and checkout via Stripe card, demo card, or cash on delivery — with order tracking and push notifications.

The admin panel includes a branded web login, live order inbox with status filters, order detail with customer info and map preview, product CRUD, and push alerts for new orders. Backend: Firebase Auth, Firestore, Cloud Functions (Stripe + FCM).''',
      cardImage: 'assets/images/mezo_admin_orders.png',
      screenshots: [
        'assets/images/mezo_app_screens.png',
        'assets/images/mezo_admin_login.png',
        'assets/images/mezo_admin_orders.png',
        'assets/images/mezo_admin_order_detail.png',
      ],
      summary:
          'Food ordering platform with customer app, admin dashboard, maps, Stripe payments, and Firebase.',
      features: [
        'Mobile app — splash, login, menu, product sizes & toppings',
        'Cart, favorites, and Stripe/cash checkout',
        'Google Maps delivery location picker with GPS',
        'Order tracking timeline and push notifications',
        'Admin web login and live orders dashboard',
        'Status filters and order detail with map preview',
        'Product management (add, edit, delete)',
        'Firebase Auth, Firestore, Cloud Functions, and FCM',
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
      ],
      githubUrl: 'https://github.com/ahmedehab96-c/mezo-food-app',
      isGithubPrivate: false,
      webTryPath: '/mezo-admin/',
      webTryIsAdmin: true,
    ),
    PortfolioProject(
      id: 'itassist',
      title: 'IT Assist NAWA TECH',
      cardDescription:
          'ITSM SaaS platform — Flutter mobile app, Laravel API, web admin panel, tickets, AI assistant, biometrics, and real-time Socket.IO.',
      readme: '''
IT Assist NAWA TECH is a production-ready IT Service Management (ITSM) SaaS platform for NAWA TECH with a Flutter mobile app, Laravel REST API, and web admin panel.

Employees can manage support tickets, service requests, change requests, and incidents; use an OpenAI-powered IT assistant; browse the knowledge base; view assigned devices; run network diagnostics; and receive push notifications with deep links. Features include biometric login, remote support (AnyDesk/TeamViewer), offline detection, and real-time updates via Socket.IO.

The web admin panel provides dashboards, SLA policies, ticket assignment, knowledge base management, user management, and multi-tenant data isolation for IT teams.''',
      cardImage: 'assets/images/itassist_dashboard.png',
      screenshots: [
        'assets/images/itassist_dashboard.png',
        'assets/images/itassist_kb.png',
        'assets/images/itassist_users.png',
        'assets/images/itassist_mobile.png',
      ],
      summary:
          'ITSM platform with mobile app, Laravel API, web admin, AI assistant, and real-time support.',
      features: [
        'Ticket, service request, change, and incident management',
        'OpenAI-powered IT chat assistant',
        'Real-time updates via Socket.IO',
        'Push notifications with Firebase Messaging',
        'Biometric authentication (fingerprint/face)',
        'Knowledge base with articles',
        'Device inventory and network diagnostics',
        'Web admin panel with SLA and multi-tenant support',
        'Error monitoring with Sentry',
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
      ],
      githubUrl: 'https://github.com/ahmedehab96-c/it-assist-nawa-tech',
      isGithubPrivate: false,
      apkUrl:
          'https://github.com/ahmedehab96-c/it-assist-nawa-tech/releases/download/v1.0.0/app-release.apk',
      webTryPath: '/itassist/',
      webTryIsAdmin: false,
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
      cardImage: 'assets/images/werdi_screens.png',
      screenshots: [
        'assets/images/werdi_screens.png',
      ],
      summary:
          'Quran app v1.0.1+11 — no login, local progress, tasmee3 evaluation, ayah audio, achievements.',
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
      ],
      githubUrl: 'https://github.com/ahmedehab96-c/werdi',
      isGithubPrivate: false,
      apkUrl:
          'https://github.com/ahmedehab96-c/werdi/releases/download/portfolio-apk-v1/app-arm64-v8a-release.apk',
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
    this.githubUrl,
    this.isGithubPrivate = true,
    this.apkUrl,
    this.webTryPath,
    this.webTryIsAdmin = true,
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
  final String? githubUrl;
  final bool isGithubPrivate;
  /// APK path (`/apk/x.apk` on demos host) or full GitHub Releases URL.
  final String? apkUrl;
  /// Web demo path (`/hrm/` on demos host) or full URL. Admin or full app.
  final String? webTryPath;
  final bool webTryIsAdmin;

  String? resolveApkUrl(String _) {
    if (apkUrl == null) return null;
    if (apkUrl!.startsWith('http')) return apkUrl;
    return PortfolioContent.demosUrl(apkUrl!);
  }

  String? resolveWebTryUrl(String _) {
    if (webTryPath == null) return null;
    if (webTryPath!.startsWith('http')) return webTryPath;
    return PortfolioContent.demosUrl(webTryPath!);
  }

  bool get hasTryActions => apkUrl != null || webTryPath != null;

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
