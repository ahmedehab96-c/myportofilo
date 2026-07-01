import 'package:flutter/material.dart';

/// Single source of truth for portfolio UI and AI assistant (all platforms).
class PortfolioContent {
  PortfolioContent._();

  /// Bump when assistant/portfolio data changes (shown in chat to verify web load).
  static const assistantDataVersion = '2.23.0';

  static const featuredProjects = <PortfolioProject>[
    PortfolioProject(
      id: 'hrm',
      title: 'HRM NAWA TECH',
      cardDescription:
          'Portfolio demo HR platform with admin web panel, employee mobile app, attendance, payroll, recruitment, and AI Command Center.',
      cardDescriptionAr:
          'منصة HRM تجريبية للبورتفوليو مع لوحة إدارة ويب، تطبيق موظف، حضور، رواتب، توظيف، ومركز أوامر ذكي (AI).',
      readmeEn: '''
HRM NAWA TECH is a full-stack HR management portfolio demo built for NAWA TECH with Flutter and Laravel. It is not a commercial SaaS product — it showcases full-stack, mobile, and AI skills for employers and recruiters.

The admin web dashboard offers real-time visibility into employees, attendance, pending leave requests, payroll, recruitment, and an AI Command Center. Employees use the mobile app to clock in, request leave, view payslips, and receive notifications. The system supports role-based access, PDF report generation, and full Arabic/English localization with light/dark themes.''',
      readmeAr: '''
HRM NAWA TECH هو عرض Portfolio لنظام إدارة موارد بشرية متكامل من NAWA TECH مبني بـ Flutter و Laravel. ليس منتج SaaS تجاري — يعرض مهارات Full-Stack والموبايل والذكاء الاصطناعي.

لوحة الإدارة على الويب تعرض الموظفين والحضور وطلبات الإجازة والرواتب والتوظيف ومركز أوامر AI. تطبيق الموظف يتيح تسجيل الحضور وطلب الإجازات وعرض كشف الراتب والإشعارات. يدعم صلاحيات حسب الدور وتقارير PDF وعربي/إنجليزي وثيم فاتح/داكن.''',
      screenshots: [
        'assets/images/hrm_dashboard.png',
        'assets/images/hrm_employees.png',
        'assets/images/hrm_login.png',
        'assets/images/hrm_mobile.png',
      ],
      summary:
          'Full-stack HR platform demo with admin web, employee app, and AI Command Center.',
      summaryAr:
          'منصة HR متكاملة تجريبية مع لوحة إدارة ويب وتطبيق موظف ومركز AI.',
      featuresEn: [
        'Admin web dashboard and employee mobile app',
        'Attendance tracking and reporting',
        'Payroll management with PDF export',
        'Leave request and approval workflow',
        'Recruitment module and AI Command Center',
        'Role-based access control',
        'Bilingual Arabic and English support',
        'Secure local storage with encrypted tokens',
      ],
      featuresAr: [
        'لوحة إدارة ويب وتطبيق موظف موبايل',
        'تتبع الحضور والتقارير',
        'إدارة الرواتب مع تصدير PDF',
        'طلبات الإجازة وسير الموافقة',
        'وحدة التوظيف ومركز أوامر AI',
        'صلاحيات حسب الدور',
        'دعم العربية والإنجليزية',
        'تخزين محلي آمن مع تشفير الرموز',
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
    ),
    PortfolioProject(
      id: 'lifeos',
      title: 'Life OS',
      cardDescription:
          'Free personal productivity app — tasks, habits, goals, finance, notes, and Groq-powered AI assistant with offline SQLite and Supabase sync.',
      cardDescriptionAr:
          'تطبيق إنتاجية شخصي مجاني — مهام، عادات، أهداف، مصاريف، ملاحظات، ومساعد AI عبر Groq مع SQLite محلي ومزامنة Supabase.',
      readmeEn: '''
Life OS is a completely free Flutter app for organizing life: tasks, expenses, goals, habits, notes, and an AI assistant.

The dashboard combines daily task planning, habit tracking, finance charts, goal progress, and smart reminders. Data is stored locally with SQLite for offline use and synced to Supabase when online. The built-in AI assistant uses an open-source Llama model via Groq, supports speech-to-text input, and can execute real commands on your data. Arabic/English and light/dark themes are included.''',
      readmeAr: '''
Life OS تطبيق Flutter مجاني بالكامل لتنظيم الحياة: مهام، مصاريف، أهداف، عادات، ملاحظات، ومساعد ذكي.

يجمع لوحة تحكم أنيقة مع تخطيط المهام وتتبع العادات ورسوم المصاريف وتتبع الأهداف وتذكيرات ذكية. تُخزَّن البيانات محلياً عبر SQLite وتُزامَن مع Supabase عند الاتصال. المساعد الذكي يستخدم نموذج Llama مفتوح المصدر عبر Groq مع إدخال صوتي وتنفيذ أوامر حقيقية على بياناتك. يدعم عربي/إنجليزي وثيم فاتح/داكن.''',
      screenshots: [
        'assets/images/lifeos_screens.png',
      ],
      summary:
          'Free productivity app with tasks, habits, finance, Groq AI, and Supabase sync.',
      summaryAr:
          'تطبيق إنتاجية مجاني مع مهام وعادات ومصاريف ومساعد Groq AI ومزامنة Supabase.',
      featuresEn: [
        'Daily tasks, habits, goals, and notes',
        'Finance tracking with charts and insights',
        'Groq-powered AI assistant with speech-to-text',
        'AI executes real commands on local data',
        'Local offline storage via SQLite',
        'Cloud sync powered by Supabase',
        'Smart local notifications and reminders',
        'Arabic/English and light/dark themes',
      ],
      featuresAr: [
        'مهام يومية وعادات وأهداف وملاحظات',
        'تتبع المصاريف مع رسوم بيانية',
        'مساعد AI عبر Groq مع إدخال صوتي',
        'تنفيذ أوامر حقيقية على البيانات المحلية',
        'تخزين محلي دون اتصال عبر SQLite',
        'مزامنة سحابية عبر Supabase',
        'إشعارات وتذكيرات ذكية',
        'عربي/إنجليزي وثيم فاتح/داكن',
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
    ),
    PortfolioProject(
      id: 'mezo',
      title: 'Mezo Food App',
      cardDescription:
          'Food delivery platform — Flutter mobile app (splash, menu, cart, checkout) plus Flutter Web admin panel with live orders, product management, and Stripe/Firebase.',
      cardDescriptionAr:
          'منصة توصيل طعام — تطبيق Flutter (شاشة ترحيب، قائمة، سلة، دفع) ولوحة أدمن ويب مباشرة لإدارة الطلبات والمنتجات مع Stripe وFirebase.',
      readmeEn: '''
Mezo Food App is a full food ordering and delivery platform with a polished customer mobile app and a responsive Flutter Web admin dashboard.

The customer app covers splash and login (email or Google), menu browsing from Firestore, product details with sizes and toppings, cart and favorites, Google Maps delivery picker with GPS, and checkout via Stripe card, demo card, or cash on delivery — with order tracking and push notifications.

The admin panel includes a branded web login, live order inbox with status filters (pending, preparing, on the way, delivered), order detail with customer info and map preview, product CRUD, and push alerts for new orders. Backend: Firebase Auth, Firestore, Cloud Functions (Stripe + FCM), Arabic/English RTL.''',
      readmeAr: '''
Mezo Food App منصة كاملة لطلب وتوصيل الطعام بتطبيق عملاء أنيق ولوحة أدمن Flutter Web متجاوبة.

تطبيق العملاء: شاشة ترحيب وتسجيل دخول (بريد أو Google)، تصفح القائمة من Firestore، تفاصيل المنتج مع الأحجام والإضافات، سلة ومفضلة، اختيار عنوان من خرائط Google مع GPS، ودفع عبر Stripe أو نقداً — مع تتبع الطلبات وإشعارات فورية.

لوحة الأدمن: تسجيل دخول ويب مخصص، صندوق طلبات مباشر مع فلاتر الحالة، تفاصيل الطلب مع بيانات العميل ومعاينة الخريطة، إدارة المنتجات، وإشعارات للطلبات الجديدة. الخلفية: Firebase Auth وFirestore وCloud Functions (Stripe + FCM) مع عربي/إنجليزي RTL.''',
      screenshots: [
        'assets/images/mezo_app_screens.png',
        'assets/images/mezo_admin_login.png',
        'assets/images/mezo_admin_orders.png',
        'assets/images/mezo_admin_order_detail.png',
      ],
      summary:
          'Food ordering platform with customer app, admin dashboard, maps, Stripe payments, and Firebase.',
      summaryAr:
          'منصة طلب طعام مع تطبيق عملاء ولوحة أدمن وخرائط وStripe وFirebase.',
      featuresEn: [
        'Mobile app — splash, login, menu, product sizes & toppings',
        'Cart, favorites, and Stripe/cash checkout',
        'Google Maps delivery location picker with GPS',
        'Order tracking timeline and push notifications',
        'Admin web login and live orders dashboard',
        'Status filters and order detail with map preview',
        'Product management (add, edit, delete)',
        'Firebase Auth, Firestore, Cloud Functions, and FCM',
        'Arabic and English (RTL) support',
      ],
      featuresAr: [
        'تطبيق موبايل — ترحيب، دخول، قائمة، أحجام وإضافات',
        'سلة، مفضلة، ودفع Stripe/نقدي',
        'اختيار عنوان التوصيل من خرائط Google مع GPS',
        'تتبع الطلبات وإشعارات فورية',
        'تسجيل دخول أدمن ولوحة طلبات مباشرة',
        'فلاتر الحالة وتفاصيل الطلب مع معاينة الخريطة',
        'إدارة المنتجات (إضافة، تعديل، حذف)',
        'Firebase Auth وFirestore وCloud Functions وFCM',
        'دعم العربية والإنجليزية (RTL)',
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
    ),
    PortfolioProject(
      id: 'itassist',
      title: 'IT Assist NAWA TECH',
      cardDescription:
          'ITSM SaaS platform — Flutter mobile app, Laravel API, web admin panel, tickets, AI assistant, biometrics, and real-time Socket.IO.',
      cardDescriptionAr:
          'منصة ITSM — تطبيق Flutter، Laravel API، لوحة ويب، تذاكر، مساعد AI، بيومترية، وSocket.IO فوري.',
      readmeEn: '''
IT Assist NAWA TECH is a production-ready IT Service Management (ITSM) SaaS platform for NAWA TECH with a Flutter mobile app, Laravel REST API, and bilingual web admin panel.

Employees can manage support tickets, service requests, change requests, and incidents; use an OpenAI-powered IT assistant; browse the knowledge base; view assigned devices; run network diagnostics; and receive push notifications with deep links. Features include biometric login, remote support (AnyDesk/TeamViewer), offline detection, and real-time updates via Socket.IO.

The web admin panel provides dashboards, SLA policies, ticket assignment, knowledge base management, user management, and multi-tenant data isolation for IT teams.''',
      readmeAr: '''
IT Assist NAWA TECH منصة ITSM جاهزة للإنتاج لـ NAWA TECH مع تطبيق Flutter وLaravel REST API ولوحة ويب ثنائية اللغة.

يمكن للموظفين إدارة تذاكر الدعم وطلبات الخدمة وطلبات التغيير والحوادث؛ استخدام مساعد IT مدعوم بـ OpenAI؛ تصفح قاعدة المعرفة؛ عرض الأجهزة؛ تشخيص الشبكة؛ وإشعارات فورية. يتضمن مصادقة بيومترية ودعم عن بُعد وSocket.IO فوري.

لوحة الإدارة توفر لوحات تحكم وسياسات SLA وتعيين التذاكر وإدارة المعرفة والمستخدمين وعزل بيانات متعدد المستأجرين.''',
      screenshots: [
        'assets/images/itassist_dashboard.png',
        'assets/images/itassist_kb.png',
        'assets/images/itassist_users.png',
        'assets/images/itassist_mobile.png',
      ],
      summary:
          'ITSM platform with mobile app, Laravel API, web admin, AI assistant, and real-time support.',
      summaryAr:
          'منصة ITSM مع تطبيق موبايل وLaravel API ولوحة ويب ومساعد AI ودعم فوري.',
      featuresEn: [
        'Ticket, service request, change, and incident management',
        'OpenAI-powered IT chat assistant',
        'Real-time updates via Socket.IO',
        'Push notifications with Firebase Messaging',
        'Biometric authentication (fingerprint/face)',
        'Knowledge base with bilingual articles',
        'Device inventory and network diagnostics',
        'Web admin panel with SLA and multi-tenant support',
        'Error monitoring with Sentry',
      ],
      featuresAr: [
        'إدارة التذاكر وطلبات الخدمة والتغيير والحوادث',
        'مساعد IT مدعوم بـ OpenAI',
        'تحديثات فورية عبر Socket.IO',
        'إشعارات عبر Firebase Messaging',
        'مصادقة بيومترية (بصمة/وجه)',
        'قاعدة معرفة بمقالات ثنائية اللغة',
        'جرد الأجهزة وتشخيص الشبكة',
        'لوحة ويب مع SLA ودعم متعدد المستأجرين',
        'مراقبة الأخطاء عبر Sentry',
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
    ),
    PortfolioProject(
      id: 'werdi',
      title: 'Werdi Quran App',
      cardDescription:
          'Arabic-first Quran app (v1.0.1+11) — no login, local progress, tasmee3 with speech evaluation, Mushaf, ayah audio, and achievements.',
      cardDescriptionAr:
          'تطبيق قرآن عربي أولاً (v1.0.1+11) — بدون تسجيل دخول، تقدم محلي، تسميع مع تقييم كلام، مصحف، صوت آيات، وإنجازات.',
      readmeEn: '''
Werdi (وردي) v1.0.1 is an Arabic-first Quran memorization and revision app with full English support. The latest release removes the login gate — open the app and start immediately. Progress is stored locally on the device, with optional Supabase sync.

Core flows: animated splash and streamlined onboarding, home dashboard with daily goals, ayah-by-ayah memorization with repetition and playback speed, smart revision sessions, voice recitation (tasmee3) with recording and speech-to-text feedback, Mushaf browsing with continuous text display, search/tafsir/bookmarks, ayah-by-ayah audio (Alafasy, Abdul Basit, Maher, Shuraim, Sudais), achievements, and daily reminder notifications.

Built with Clean Architecture, BLoC, go_router, Drift, just_audio, and Supabase. Material 3 themes and responsive layout for phones and tablets.''',
      readmeAr: '''
وردي (Werdi) v1.0.1 تطبيق عربي أولاً لحفظ ومراجعة القرآن مع دعم إنجليزي كامل. الإصدار الأخير يزيل تسجيل الدخول — افتح التطبيق وابدأ مباشرة. التقدم يُحفظ محلياً مع مزامنة Supabase اختيارية.

يشمل: افتتاحية متحركة وonboarding مبسّط، لوحة رئيسية بأهداف يومية، حفظ آية بآية مع التكرار وسرعة التشغيل، مراجعة ذكية، تسميع صوتي (tasmee3) مع تسجيل وتحويل كلام، تصفح المصحف بنص متصل، بحث وتفسير وإشارات، صوت آية بآية بعدة قراء، إنجازات، وتذكيرات يومية.

مبني بـ Clean Architecture وBLoC وgo_router وDrift وjust_audio وSupabase. ثيمات Material 3 وتخطيط متجاوب.''',
      screenshots: [
        'assets/images/werdi_screens.png',
      ],
      summary:
          'Quran app v1.0.1+11 — no login, local progress, tasmee3 evaluation, ayah audio, achievements.',
      summaryAr:
          'تطبيق قرآن v1.0.1+11 — بدون تسجيل دخول، تقدم محلي، تسميع، صوت آيات، إنجازات.',
      featuresEn: [
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
      featuresAr: [
        'بدون تسجيل دخول — افتح وابدأ مباشرة',
        'لوحة رئيسية بهدف اليوم ونظرة على التقدم',
        'تقدم المستخدم محلياً على الجهاز (Drift)',
        'حفظ آية بآية مع التكرار وسرعة التشغيل',
        'تسميع صوتي مع تقييم الكلام وعرض الفروقات',
        'مراجعة ذكية وإنجازات وتذكيرات يومية',
        'عرض آيات بأسلوب المصحف مع البحث والتفسير والإشارات',
        'صوت آية بآية مع عدة قراء',
        'ثيمات Material 3 وتخطيط متجاوب',
        'مزامنة Supabase اختيارية',
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
        'arabic rtl',
        'no login',
        'ayah audio',
        'achievements',
      ],
      githubUrl: 'https://github.com/ahmedehab96-c/werdi',
      isGithubPrivate: false,
    ),
  ];
}

class PortfolioProject {
  const PortfolioProject({
    required this.id,
    required this.title,
    required this.cardDescription,
    required this.cardDescriptionAr,
    required this.readmeEn,
    required this.readmeAr,
    required this.screenshots,
    required this.summary,
    required this.summaryAr,
    required this.featuresEn,
    required this.featuresAr,
    required this.tech,
    required this.keywords,
    this.githubUrl,
    this.isGithubPrivate = true,
  });

  final String id;
  final String title;
  final String cardDescription;
  final String cardDescriptionAr;
  final String readmeEn;
  final String readmeAr;
  final List<String> screenshots;
  final String summary;
  final String summaryAr;
  final List<String> featuresEn;
  final List<String> featuresAr;
  final List<String> tech;
  final List<String> keywords;
  final String? githubUrl;
  final bool isGithubPrivate;

  String localizedCardDescription(Locale locale) => cardDescription;

  String localizedSummary(Locale locale) => summary;

  String localizedReadme(Locale locale) => readmeEn;

  List<String> localizedFeatures(Locale locale) => featuresEn;

  /// Backward-compatible alias used by the AI assistant layer.
  List<String> get features => featuresEn;

  String get imagePath => screenshots.isNotEmpty ? screenshots.first : '';

  String assistantDetailFor(Locale locale) {
    final features = localizedFeatures(locale).map((f) => '• $f').join('\n');
    return '''${localizedSummary(locale)}

${localizedReadme(locale)}

Features:
$features

Tech: ${tech.join(', ')}''';
  }

  String get assistantDetail => assistantDetailFor(const Locale('en'));

  Map<String, String?> cardMapFor(Locale locale) => {
        'title': title,
        'desc': localizedCardDescription(locale),
        'img': imagePath,
        'github': githubUrl,
      };

  Map<String, String?> get cardMap => cardMapFor(const Locale('en'));
}
