import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';

/// Complete portfolio facts and FAQ entries for the AI assistant.
class PortfolioKnowledge {
  PortfolioKnowledge._();

  static const fullName = 'Ahmed Ehab Mohammed';
  static const role = 'Mid-Level Flutter Engineer';
  static const yearsOfExperience = '3+';
  static const tagline =
      'Crafting beautiful and functional mobile experiences with a focus on user-centric design and clean code architecture';

  static const email = 'ahmed96it96@gmail.com';
  static const phone = '+971 58 915 4605';
  static const github = 'github.com/ahmedehab96-c';
  static const githubUrl = 'https://github.com/ahmedehab96-c';
  static const linkedIn = 'Ahmed Ehab';
  static const linkedInUrl =
      'https://www.linkedin.com/in/ahmed-ehab-ba8a63285';
  static const cvUrl =
      'https://drive.google.com/file/d/1l31V4wZzzsehnC_3tJoeSCafYpgcy9ov/view?usp=drivesdk';

  static const aboutParagraph1 =
      'I am a Mid-Level Flutter engineer with 3+ years of experience building responsive and feature-rich applications. I enjoy solving problems and creating user-friendly designs that provide seamless experiences across different platforms.';

  static const aboutParagraph2 =
      'My focus is on creating clean, efficient, and maintainable code while delivering exceptional user experiences. I continuously grow my skills with the help of AI tools — using Cursor and Claude to accelerate development, explore new patterns, and stay at the forefront of mobile development.';

  static const suggestedQuestions = [
  // About
    'Who are you?',
    'Tell me about yourself',
    'What is your job title?',
  // Projects
    'What are your projects?',
    'Tell me about HRM NAWA TECH',
    'What is Life OS?',
    'Tell me about Mezo Food App',
    'What is IT Assist NAWA TECH?',
    'Tell me about Werdi Quran App',
    'Can I download Life OS or Werdi APK?',
    'Which project uses Firebase?',
  // Skills
    'What are your technical skills?',
    'Do you know GetX and BLoC?',
    'What backend technologies do you use?',
    'Can you build authentication?',
  // Education
    'What is your education?',
    'Tell me about your AI diplomas',
    'Where did you study?',
  // Contact & work
    'How can I contact you?',
    'What is your email?',
    'Are you available for hire?',
    'How much does an app cost?',
    'Where can I download your CV?',
  // Portfolio
    'What sections are in this portfolio?',
    'What can you help me with?',
  ];

  static const helpTopicsReply = '''
I can answer detailed questions about Ahmed Ehab's portfolio:

👤 About
• Who Ahmed is, role, bio, and focus

📱 Projects (5 featured apps)
• HRM NAWA TECH — cloud HR platform
• Life OS — productivity & daily planning
• Mezo Food App — food delivery platform with admin dashboard, maps, and Stripe
• IT Assist NAWA TECH — IT support & helpdesk
• Werdi Quran App (v1.0.1+11) — no login, local progress, tasmee3 evaluation

🛠 Skills & expertise
• Technical, backend, auth, tools, UI/UX, soft skills
• Flutter, Dart, Firebase, Supabase, GetX, BLoC, Riverpod

🎓 Education & certifications
• BSc IT (Al-Mashriq University 2018)
• Udemy Flutter Course
• AI Diploma — ALBYAN Institute, Abu Dhabi (ACTVET accredited, Grade: Excellent)

📞 Contact & collaboration
• Email, phone, GitHub, LinkedIn, CV download, hiring, pricing

💡 Tip: Ask naturally, e.g. "What Firebase features do you use?" or "Tell me about IT Assist".''';

  static List<ProjectKnowledge> projectsFor(Locale locale) =>
      PortfolioContent.featuredProjects
          .map(
            (p) => ProjectKnowledge(
              id: p.id,
              title: p.title,
              keywords: p.keywords,
              summary: p.localizedSummary(locale),
              features: p.localizedFeatures(locale),
              tech: p.tech,
              isGithubPrivate: p.isGithubPrivate,
            ),
          )
          .toList(growable: false);

  static List<ProjectKnowledge> get projects => projectsFor(const Locale('en'));

  static List<String> suggestedQuestionsFor(Locale locale) =>
      locale.languageCode == 'ar' ? suggestedQuestionsAr : suggestedQuestions;

  static const suggestedQuestionsAr = [
    'من أنت؟',
    'أخبرني عن نفسك',
    'ما هي مسمى وظيفتك؟',
    'ما هي مشاريعك؟',
    'أخبرني عن HRM NAWA TECH',
    'ما هو Life OS؟',
    'أخبرني عن Mezo Food App',
    'ما هو IT Assist NAWA TECH؟',
    'أخبرني عن تطبيق وردي',
    'هل يمكن تحميل APK لـ Life OS أو وردي؟',
    'أي مشروع يستخدم Firebase؟',
    'ما هي مهاراتك التقنية؟',
    'هل تعرف GetX و BLoC؟',
    'ما تقنيات الباكند التي تستخدمها؟',
    'هل يمكنك بناء نظام مصادقة؟',
    'ما هو تعليمك؟',
    'أخبرني عن دبلومات الذكاء الاصطناعي',
    'أين درست؟',
    'كيف أتواصل معك؟',
    'ما هو بريدك الإلكتروني؟',
    'هل أنت متاح للعمل؟',
    'كم يكلف تطوير تطبيق؟',
    'أين أحمل السيرة الذاتية؟',
    'ما الأقسام في هذا البورتفوليو؟',
    'بماذا يمكنك مساعدتي؟',
  ];

  static const List<FaqEntry> faqEntries = [
    // --- About ---
    FaqEntry(
      ['who are you', 'who is ahmed', 'introduce yourself', 'about you'],
      '''$fullName is a $role.

$aboutParagraph1

$aboutParagraph2''',
    ),
    FaqEntry(
      ['full name', 'your name', 'what is your name'],
      'Full name: $fullName',
    ),
    FaqEntry(
      ['job title', 'your role', 'what do you do', 'profession', 'occupation'],
      'Role: $role\n\n$tagline',
    ),
    FaqEntry(
      ['about me', 'bio', 'background', 'tell me about yourself', 'summary'],
      '''About $fullName:

$aboutParagraph1

$aboutParagraph2''',
    ),
    FaqEntry(
      ['passion', 'why flutter', 'what motivates', 'focus'],
      'Ahmed is passionate about Flutter, user-centric design, clean architecture, and building apps that work smoothly on mobile and web.',
    ),
    FaqEntry(
      ['location', 'where are you based', 'country', 'uae', 'dubai', 'abu dhabi'],
      'Contact number uses UAE country code (+971). Ahmed works as a Flutter developer and is open to remote collaboration. Reach out to confirm current location and availability.',
    ),

    // --- Portfolio structure ---
    FaqEntry(
      [
        'portfolio sections',
        'sections in portfolio',
        'what is on this site',
        'website sections',
        'pages on portfolio',
      ],
      '''This portfolio includes:

• Header — name, role, and quick actions
• About Me — background and approach
• Education & Certifications
• Skills & Expertise (6 categories)
• Featured Projects (5 apps)
• Contact information
• Download CV button
• AI Assistant (this chat)''',
    ),
    FaqEntry(
      [
        'what can you help',
        'what can i ask',
        'help topics',
        'list questions',
        'supported questions',
        'commands',
      ],
      helpTopicsReply,
    ),

    // --- Education (detailed) ---
    FaqEntry(
      ['education', 'qualifications', 'degrees', 'studied', 'academic'],
      '''Education & certifications:

🎓 Bachelor of Information Technology
   Al-Mashriq University — Sudan (2018)

💻 Flutter Development Course
   Udemy — Mobile App Development with Flutter

🧠 Training Diploma in Artificial Intelligence
   ALBYAN Institute, Abu Dhabi, UAE
   Accredited by ACTVET | 18 Oct 2026 | Grade: Excellent
   120-hour diploma: applied AI, ML concepts, AI-driven systems''',
    ),
    FaqEntry(
      ['university', 'bachelor', 'degree', 'mashriq', 'sudan 2018'],
      '''Bachelor of Information Technology
Institution: Al-Mashriq University — Sudan
Year: 2018''',
    ),
    FaqEntry(
      ['udemy', 'flutter course', 'online course'],
      '''Flutter Development Course on Udemy.
Focus: Mobile App Development with Flutter.''',
    ),
    FaqEntry(
      ['ai diploma', 'artificial intelligence', 'albyan', 'actvet', 'machine learning diploma'],
      '''AI Diploma — ALBYAN Institute, Abu Dhabi, UAE:
• Accredited by ACTVET (Abu Dhabi Centre for Technical and Vocational Education and Training)
• Date: 18 October 2026 | Grade: Excellent
• 120-hour professional diploma covering applied AI, machine learning concepts, and AI-driven system development''',
    ),

    // --- Skills (by category) ---
    FaqEntry(
      ['technical skills', 'flutter skills', 'dart skills', 'mobile development'],
      '''Technical Skills:
• Flutter & Dart
• Cross-platform apps (Android & iOS)
• State management: Provider, GetX, BLoC, Riverpod
• Custom widgets and UI components
• Animations and responsive layouts
• pub.dev packages integration''',
    ),
    FaqEntry(
      ['backend', 'backend integration', 'api', 'database', 'firebase', 'supabase', 'laravel'],
      '''Backend Integration:
• Laravel REST API — used in HRM NAWA TECH and IT Assist NAWA TECH
• Firebase — Auth, Firestore, Cloud Messaging (Mezo + IT Assist)
• Supabase — cloud backend for Life OS
• HTTP/Dio for RESTful API calls in Flutter
• SQLite for local offline storage
• Local storage: SharedPreferences, flutter_secure_storage''',
    ),
    FaqEntry(
      ['laravel', 'php backend', 'laravel api', 'eloquent', 'sanctum'],
      '''Laravel Backend:
• RESTful API development with Laravel
• Eloquent ORM & database migrations
• Authentication with Laravel Sanctum / Passport
• Role & permission management
• API integration with Flutter frontend''',
    ),
    FaqEntry(
      [
        'authentication',
        'auth',
        'login',
        'sign in',
        'google sign',
        'facebook login',
        'apple sign',
      ],
      '''Authentication expertise:
• Email/password login
• Google, Facebook, and Apple sign-in
• Role-based access and route guarding''',
    ),
    FaqEntry(
      ['tools', 'platforms', 'git', 'vscode', 'android studio', 'postman', 'deployment'],
      '''Tools & Platforms:
• Git / GitHub for version control
• VS Code and Android Studio
• Firebase Hosting and Play Store deployment
• Postman for API testing''',
    ),
    FaqEntry(
      ['ui ux', 'design', 'material design', 'responsive', 'dark theme', 'mvvm', 'mvc'],
      '''UI/UX Skills:
• Material Design & Cupertino widgets
• Clean architecture (MVC, MVVM)
• Light/Dark theme implementation
• Responsive design for mobile, tablet, and web''',
    ),
    FaqEntry(
      ['soft skills', 'teamwork', 'agile', 'problem solving', 'documentation'],
      '''Soft Skills:
• Problem-solving and debugging
• Agile and team collaboration
• Time management
• Clean code and documentation
• Fast learning of new tools and libraries''',
    ),
    FaqEntry(
      ['state management', 'getx', 'provider', 'bloc', 'riverpod'],
      'Ahmed uses GetX, Provider, BLoC, and Riverpod for state management in Flutter apps.',
    ),
    FaqEntry(
      ['do you know flutter', 'experience flutter', 'cross platform', 'ios android web'],
      'Yes. Ahmed specializes in Flutter for Android, iOS, and Web with responsive UI and production-ready architecture.',
    ),
    FaqEntry(
      ['which project uses firebase', 'firebase projects'],
      'Firebase is used in: Mezo Food App (Auth, Firestore, Cloud Functions, FCM) and IT Assist NAWA TECH (Firebase Messaging for push notifications). Life OS uses Supabase, not Firebase.',
    ),
    FaqEntry(
      ['which project uses supabase', 'supabase projects'],
      'Supabase is used in: Life OS — as the cloud backend for data sync, combined with local SQLite for offline support.',
    ),
    FaqEntry(
      ['which project uses laravel', 'laravel projects', 'laravel backend'],
      'Laravel is used as the server-side backend in: HRM NAWA TECH and IT Assist NAWA TECH. Both use REST API calls from Flutter to a Laravel API.',
    ),
    FaqEntry(
      ['which project uses bloc', 'bloc projects', 'state management'],
      'BLoC (flutter_bloc) is used in: Life OS, Mezo Food App, and Werdi Quran App. HRM and IT Assist use simpler state approaches (http/Dio).',
    ),
    FaqEntry(
      ['which project uses provider', 'provider projects'],
      'Provider is used in some Flutter projects, but the featured Mezo Food App uses BLoC for state management.',
    ),
    FaqEntry(
      ['socket.io', 'real-time', 'websocket'],
      'IT Assist NAWA TECH uses Socket.IO for real-time communication between staff and the IT support team.',
    ),

    // --- Contact ---
    FaqEntry(
      ['email', 'mail address', 'gmail'],
      'Email: $email',
    ),
    FaqEntry(
      ['phone', 'mobile', 'call', 'whatsapp number', 'telephone'],
      'Phone: $phone',
    ),
    FaqEntry(
      ['github', 'source code', 'repository', 'repos', 'code access'],
      '''Public GitHub profile: $github ($githubUrl)

Repository visibility:
• HRM NAWA TECH — private
• Life OS — public: https://github.com/ahmedehab96-c/LifeOS
• Mezo Food App — public: https://github.com/ahmedehab96-c/mezo-food-app
• IT Assist NAWA TECH — public: https://github.com/ahmedehab96-c/it-assist-nawa-tech
• Werdi Quran App — public: https://github.com/ahmedehab96-c/werdi

For private-source projects, contact Ahmed at $email for collaboration or access discussions.''',
    ),
    FaqEntry(
      ['private repo', 'private repository', 'private github', 'can i see code', 'source code private'],
      'Life OS, Werdi, Mezo Food App, and IT Assist NAWA TECH are public on GitHub. Only HRM NAWA TECH remains private. For hiring or partnership inquiries, contact Ahmed directly.',
    ),
    FaqEntry(
      ['apk', 'download apk', 'android app', 'install app', 'life os apk', 'werdi apk'],
      '''APK downloads are on GitHub Releases only (Android):

Life OS — https://github.com/ahmedehab96-c/LifeOS/releases/tag/portfolio-apk-v1
• Download app-release.apk (~65 MB), wait until 100%, then install.
• If install fails: uninstall any older Life OS copy first.

Werdi — https://github.com/ahmedehab96-c/werdi/releases/tag/portfolio-apk-v1
• Download app-arm64-v8a-release.apk (~55 MB, v1.0.1+11, arm64 phones 2017+), wait until 100%, then install.
• Google Play Protect may warn — tap Install anyway (not OK). Normal for apps outside Play Store.
• If install fails: uninstall any older Werdi copy first.
• Enable "Install unknown apps" for Chrome in Android settings.''',
    ),
    FaqEntry(
      ['linkedin', 'linked in', 'professional profile'],
      'LinkedIn: $linkedIn\nURL: $linkedInUrl',
    ),
    FaqEntry(
      ['contact', 'reach you', 'get in touch', 'how to contact'],
      '''Contact Ahmed:
📧 $email
📱 $phone
🔗 GitHub: $github
💼 LinkedIn: $linkedIn''',
    ),
    FaqEntry(
      ['cv', 'resume', 'download cv', 'curriculum'],
      'Download the CV using the "Download CV" button at the bottom of the portfolio page.\n\nDirect link: $cvUrl',
    ),

    // --- Work inquiries ---
    FaqEntry(
      ['available', 'availability', 'hire', 'hiring', 'freelance', 'collaborate', 'need developer'],
      '''Ahmed is open to Flutter projects (mobile, web, admin panels).

Contact for availability:
📧 $email
📱 $phone
💼 LinkedIn: $linkedIn''',
    ),
    FaqEntry(
      ['price', 'cost', 'budget', 'quote', 'how much', 'app cost', 'project cost'],
      '''Pricing depends on app type, features, integrations, and timeline.

For a tailored quote, contact Ahmed:
📧 $email
📱 $phone''',
    ),
    FaqEntry(
      ['services', 'what services', 'what do you offer', 'development services'],
      '''Services Ahmed offers:
• Flutter mobile apps (Android & iOS)
• Flutter web portfolios and dashboards
• Firebase / Supabase backend integration
• UI/UX implementation and responsive design
• API integration and authentication systems''',
    ),
  ];
}

class ProjectKnowledge {
  const ProjectKnowledge({
    required this.id,
    required this.title,
    required this.keywords,
    required this.summary,
    required this.features,
    required this.tech,
    this.isGithubPrivate = true,
  });

  final String id;
  final String title;
  final List<String> keywords;
  final String summary;
  final List<String> features;
  final List<String> tech;
  final bool isGithubPrivate;

  String detailReplyFor(Locale locale) {
    final featuresText = features.map((f) => '• $f').join('\n');
    final techText = tech.join(', ');
    final isAr = locale.languageCode == 'ar';
    final repoNote = isGithubPrivate
        ? (isAr
            ? '\n\n🔒 الكود المصدري: مستودع GitHub خاص (تواصل مع أحمد للوصول).'
            : '\n\n🔒 Source code: Private GitHub repository (contact Ahmed for access).')
        : '';
    final featuresLabel = isAr ? 'الميزات:' : 'Features:';
    final techLabel = isAr ? 'التقنيات:' : 'Tech:';
    return '$summary\n\n$featuresLabel\n$featuresText\n\n$techLabel $techText$repoNote';
  }

  String get detailReply => detailReplyFor(const Locale('en'));
}

class FaqEntry {
  const FaqEntry(this.keywords, this.answer);

  final List<String> keywords;
  final String answer;

  bool matches(String normalizedMessage) {
    return keywords.any((k) => normalizedMessage.contains(k.toLowerCase()));
  }
}
