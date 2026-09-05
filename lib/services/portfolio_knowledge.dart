import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';

/// Complete portfolio facts and FAQ entries for the AI assistant.
class PortfolioKnowledge {
  PortfolioKnowledge._();

  static const fullName = 'Ahmed Ehab Mohammed';
  static const role = 'Full-Stack Web & Mobile Developer';
  static const yearsOfExperience = '4+';
  static const tagline =
      'Building mobile and web applications, backend systems, APIs, and '
      'AI-powered features with Flutter, React.js, and Laravel';

  static const email = 'ahmed96it96@gmail.com';
  static const phone = '+971 58 915 4605';
  static const github = 'github.com/ahmedehab96-c';
  static const githubUrl = 'https://github.com/ahmedehab96-c';
  static const linkedIn = 'Ahmed Ehab';
  static const linkedInUrl =
      'https://www.linkedin.com/in/ahmed-ehab-ba8a63285';
  static const cvUrl =
      'https://drive.google.com/file/d/1r6r5ScPVkKEE1Pqs0GWcPH89KC14gKn1/view?usp=drivesdk';
  static const dubaiCertificateUrl =
      'https://ahmedmyportofilo.netlify.app/docs/ahmed-ehab-certificate.pdf';

  static const aboutParagraph1 =
      'I am a full-stack developer with 4+ years of experience building complete digital products end to end — frontend, mobile, backend, APIs, databases, and AI integration. Flutter/Dart is the core of my stack, where I build production-ready apps for Android, iOS, and web, and I extend that with React.js for admin dashboards and web storefronts, Laravel for REST APIs and business logic, and Firebase/Supabase for backend and database services.';

  static const aboutParagraph2 =
      'I also integrate AI directly into the products I build — from OpenAI-powered assistants to Groq-powered chat features — and hold an AI diploma alongside hands-on prompt-engineering training. My focus stays on clean, maintainable code and shipping real, deployed applications (live demos, Play Store apps, and hosted web dashboards) rather than just prototypes.';

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
    'Tell me about BankX Digital Banking',
    'What is StepZone?',
    'Can I download Life OS or Werdi from Google Play?',
    'Which project uses Firebase?',
    'What sections are in this portfolio?',
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
I can answer detailed questions about every part of Ahmed Ehab's portfolio:

👤 Hero & About
• Full name, role (Full-Stack Web & Mobile Developer), tagline, years of experience (4+)
• Bio, highlights (Flutter, Dart, React.js, Laravel, HTML, CSS, JavaScript, Firebase, Supabase, GetX, REST API, AI Integration, Clean Architecture, UI/UX)
• Stats: 4+ years, 20+ projects, 6+ technologies

📱 Projects (7 apps — ask about any by name)
• HRM NAWA TECH — multi-tenant HR SaaS (Filament + React dashboard + Flutter + live Render demo + APK)
• Life OS — productivity app + Groq AI + Google Play
• Mezo Food App — food delivery + Flutter web admin + Firebase + APK
• IT Assist NAWA TECH — ITSM + Laravel + live Render admin + APK
• Werdi Quran App — memorization, tasmee3, Mushaf + Google Play
• BankX Digital Banking — fintech UI demo + APK
• StepZone — luxury shoe eCommerce + Supabase + APK

🛠 Skills (9 categories)
• Mobile Development, Web Development, Backend Development, Cloud & Services, AI Integration
• Authentication, Tools & Platforms, UI/UX Skills, Soft Skills

🎓 Education & certifications (4 entries)
• BSc IT Al-Mashriq University 2018
• Udemy Flutter Course
• One Million Prompters — Dubai Future Foundation / DCAI
• AI Diploma — ALBYAN Institute Abu Dhabi (ACTVET, Excellent)

💼 Services (dedicated section)
• Mobile App Development, Web Development, Backend Development, Full-Stack Development, AI Integration, API Integration

📞 Contact & collaboration
• Email, phone (+971), GitHub, LinkedIn, CV download, hiring, pricing, live demos, APK links

💡 Examples: "Tell me about StepZone", "What is in the Skills section?", "How can I contact you?"''';

  static List<ProjectKnowledge> projectsFor(Locale locale) =>
      PortfolioContent.featuredProjects
          .map(
            (p) => ProjectKnowledge(
              id: p.id,
              title: p.title,
              keywords: p.keywords,
              summary: p.summary,
              features: p.features,
              tech: p.tech,
              isGithubPrivate: p.isGithubPrivate,
            ),
          )
          .toList(growable: false);

  static List<ProjectKnowledge> get projects => projectsFor(const Locale('en'));

  /// Full portfolio facts for Gemini / deep local replies.
  static String get assistantSystemPrompt {
    final buffer = StringBuffer('''
PORTFOLIO FACTS (use ONLY these — do not invent):

Name: $fullName | Role: $role | Experience: $yearsOfExperience years
Tagline: $tagline
Email: $email | Phone: $phone
GitHub: $githubUrl | LinkedIn: $linkedInUrl
CV: $cvUrl | Dubai certificate: $dubaiCertificateUrl

About:
$aboutParagraph1
$aboutParagraph2

Hero stats: $yearsOfExperience years experience, 20+ projects, 6+ technologies
About highlights: Flutter, Dart, Laravel, Firebase, GetX, REST API, AI Integration, Clean Architecture, UI/UX

Portfolio sections: Hero, About Me, Education & Certifications, Skills & Expertise (9 categories), Services, Projects (7 apps), Contact, Download CV, AI Assistant

Skills categories:
1. Mobile Development — Flutter, Dart, BLoC/GetX/Riverpod, widgets, animations
2. Web Development — HTML, CSS, JavaScript, React.js
3. Backend Development — Laravel REST API, Eloquent, Sanctum/Passport, RBAC
4. Cloud & Services — Firebase, Supabase, SQLite/local storage
5. AI Integration — OpenAI assistant (IT Assist), Groq AI (Life OS), AI-assisted HRM workflows, AI diploma
6. Authentication — email, Google/Facebook/Apple, RBAC
7. Tools & Platforms — Git, VS Code, Android Studio, Cursor, Postman, Play Store
8. UI/UX — Material/Cupertino, MVC/MVVM, themes, responsive design
9. Soft Skills — problem-solving, agile, documentation, fast learning

Education: BSc IT Al-Mashriq University 2018; Udemy Flutter; One Million Prompters (Dubai); AI Diploma ALBYAN Abu Dhabi ACTVET Oct 2026 Excellent

Services (dedicated section): Mobile App Development, Web Development, Backend Development, Full-Stack Development, AI Integration, API Integration

PROJECTS (${PortfolioContent.featuredProjects.length}):
''');

    for (final p in PortfolioContent.featuredProjects) {
      buffer.writeln('--- ${p.title} (${p.id}) ---');
      buffer.writeln('Summary: ${p.summary}');
      buffer.writeln('Tech: ${p.tech.join(", ")}');
      buffer.writeln('Features: ${p.features.take(6).join("; ")}');
      if (p.liveDemoUrl != null) buffer.writeln('Live demo: ${p.liveDemoUrl}');
      if (p.playStoreUrl != null) buffer.writeln('Google Play: ${p.playStoreUrl}');
      if (p.apkUrl != null) buffer.writeln('APK: ${p.apkUrl}');
      if (p.githubUrl != null) {
        buffer.writeln(
          'GitHub: ${p.githubUrl} (${p.isGithubPrivate ? "private" : "public"})',
        );
      } else if (p.isGithubPrivate) {
        buffer.writeln('GitHub: private — contact for access');
      }
      buffer.writeln('');
    }

    return buffer.toString();
  }

  static List<String> suggestedQuestionsFor(Locale locale) =>
      suggestedQuestions;

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

• Header — name, role, and quick actions (View Projects, Hire Me, Contact Me, Download CV)
• About Me — background and approach
• Education & Certifications
• Skills & Expertise (9 categories)
• Services — what Ahmed can build for you
• Projects (7 featured apps)
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

🤖 One Million Prompters — Certificate of Completion
   Dubai Future Foundation · Dubai Centre for Artificial Intelligence
   Prompt engineering for AI systems (Dubai Universal Blueprint for AI)
   View certificate: $dubaiCertificateUrl

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
    FaqEntry(
      ['certificate', 'certification', 'dubai certificate', 'view certificate', 'one million prompters', 'prompt engineering', 'dubai future foundation'],
      '''One Million Prompters — Certificate of Completion (Dubai):
• Issued by Dubai Future Foundation & Dubai Centre for Artificial Intelligence
• Prompt engineering for AI systems — Dubai Universal Blueprint for Artificial Intelligence
• Listed under Education on the portfolio

View certificate (PDF): $dubaiCertificateUrl''',
    ),

    FaqEntry(
      ['skills', 'skills section', 'expertise', 'what skills', 'skill categories'],
      '''Skills & Expertise — 9 categories on the portfolio:

1️⃣ Mobile Development — Flutter & Dart, cross-platform, BLoC/GetX/Riverpod, widgets, animations
2️⃣ Web Development — HTML, CSS, JavaScript, React.js
3️⃣ Backend Development — Laravel REST API, Eloquent, Sanctum/Passport, RBAC
4️⃣ Cloud & Services — Firebase, Supabase, SQLite/local storage
5️⃣ AI Integration — OpenAI assistant, Groq AI, AI-assisted workflows, AI diploma
6️⃣ Authentication — email/password, Google/Facebook/Apple sign-in, route guarding
7️⃣ Tools & Platforms — Git/GitHub, VS Code, Android Studio, Cursor, Postman, Play Store
8️⃣ UI/UX Skills — Material/Cupertino, MVC/MVVM, light/dark themes, responsive design
9️⃣ Soft Skills — problem-solving, agile, time management, documentation, fast learning

Ask "What are your technical skills?" or "Do you know Laravel?" for details.''',
    ),
    FaqEntry(
      ['hero', 'header', 'stats', 'years of experience', 'how many projects', 'technologies count'],
      '''Hero section highlights:
• Name: $fullName
• Role: $role
• Experience: $yearsOfExperience years
• Portfolio stats: 20+ projects, 6+ technologies
• Tagline: I build modern mobile and web applications, scalable backend systems, APIs, and AI-powered solutions using Flutter, React.js, Laravel, and modern technologies.''',
    ),
    FaqEntry(
      ['about highlights', 'tech stack summary', 'what technologies'],
      'About highlights on the portfolio: Flutter, Dart, Laravel, Firebase, GetX, REST API, AI Integration, Clean Architecture, UI/UX.',
    ),
    FaqEntry(
      ['life os', 'lifeos', 'productivity app', 'groq', 'google play life'],
      '''Life OS — free personal productivity app:
• Tasks, habits, goals, finance, notes, Groq-powered AI assistant
• Offline SQLite + Supabase sync, speech-to-text
• Google Play: https://play.google.com/store/apps/details?id=com.ahmed.lifeos
• GitHub (public): https://github.com/ahmedehab96-c/LifeOS
• Tech: Flutter, BLoC, Supabase, SQLite, Groq AI''',
    ),
    FaqEntry(
      ['mezo', 'mezo food', 'food delivery', 'restaurant app'],
      '''Mezo Food App — food ordering & delivery:
• Customer Flutter app + responsive Flutter Web admin
• Firebase, Google Maps, Stripe/demo/cash, Arabic/English RTL
• Live admin: https://ahmedmyportofilo.netlify.app/demos/mezo-admin/
• Admin: admin@mezofood.com / MezoDemo123!
• APK: https://ahmedmyportofilo.netlify.app/apks/mezo.apk
• GitHub: private''',
    ),
    FaqEntry(
      ['it assist', 'itsm', 'helpdesk', 'it support app'],
      '''IT Assist NAWA TECH — ITSM SaaS:
• Flutter mobile + Laravel admin/API, tickets, AI assistant, Socket.IO, biometrics
• Live panel: https://it-assist-api.onrender.com/panel/login
• IT Admin: it@company.com / password | Employee: mohammed@company.com / password
• APK: https://ahmedmyportofilo.netlify.app/apks/itassist.apk
• GitHub: private''',
    ),
    FaqEntry(
      ['werdi', 'quran', 'memorization', 'tasmee3', 'mushaf'],
      '''Werdi Quran App (v1.0.1+11):
• No login — open and start; local progress on device
• Memorization, tasmee3 voice evaluation, Mushaf, ayah audio, achievements
• Google Play: https://play.google.com/store/apps/details?id=com.werdi.app
• GitHub (public): https://github.com/ahmedehab96-c/werdi
• Tech: Flutter, BLoC, Drift, Supabase, just_audio''',
    ),
    FaqEntry(
      ['bankx', 'banking', 'bank app', 'fintech', 'digital banking'],
      '''BankX Digital Banking — Flutter banking UI demo:
• Dashboard, transfers, bill pay, cards, biometric-ready sign-in, Material 3
• APK: https://ahmedmyportofilo.netlify.app/apks/bankx.apk
• Source: private repository — contact Ahmed for access
• Tech: Flutter, Material 3, Clean Architecture''',
    ),
    FaqEntry(
      ['stepzone', 'shoes', 'ecommerce', 'luxury shoes', 'online store'],
      '''StepZone — luxury shoe eCommerce:
• Supabase backend, Google sign-in, coupons, AED pricing, reviews
• Demo: stepzone.demo@gmail.com / StepZone2026! | Coupons: LUXE10, KICKS20, WELCOME15
• APK: https://ahmedmyportofilo.netlify.app/apks/stepzone.apk
• GitHub (public): https://github.com/ahmedehab96-c/stepzone
• Tech: Flutter, GetX, Supabase, PostgreSQL, Edge Functions, React.js + Vite (web storefront), Tap Payments''',
    ),
    FaqEntry(
      ['navigation', 'menu', 'how to navigate', 'scroll sections'],
      '''Use the top navigation (or mobile menu) to jump to:
• About — bio and highlights
• Education — degrees and AI certificates
• Skills — 7 skill categories
• Projects — 7 featured apps with demos and APKs
• Contact — email, phone, GitHub, LinkedIn''',
    ),
    FaqEntry(
      ['technical skills', 'flutter skills', 'dart skills', 'mobile development'],
      '''Mobile Development:
• Flutter & Dart — my core stack for full, production-ready apps (Android & iOS)
• State management: BLoC, GetX, Riverpod
• Custom widgets and UI components
• Animations and responsive layouts
• React.js as an addition — for admin dashboards and web, often with AI-powered features
• Web development: HTML, CSS, JavaScript, React.js
• pub.dev / npm packages integration''',
    ),
    FaqEntry(
      [
        'hrm saas',
        'saas hrm',
        'multi-tenant',
        'hrm trial',
        'filament',
        'hrm demo',
        'live hrm',
        'hrm render',
        'hrm nawa tech',
        'tell me about hrm',
        'responsive hrm',
        'react dashboard',
        'hrm react',
      ],
      '''HRM NAWA TECH — multi-tenant HR SaaS with live demo:

• Laravel Filament admin + React SPA dashboard + Flutter employee app + REST API
• Company self-registration + 14-day free trial + plan caps
• React dashboard covers employees, departments, attendance, leave, payroll, recruitment, performance, reports, roles & permissions — same Sanctum API as the mobile app
• Responsive employee UI (phone / tablet / desktop)
• AI-assisted recruitment, leave, performance, reports
• Live demo: https://hrm-nawa-api.onrender.com/admin
  React dashboard: https://hrm-nawa-api.onrender.com/dashboard
  Admin: admin@demo.com / Admin12345!
  Employee: emp01@demo.com / Employee12345!
• API health: https://hrm-nawa-api.onrender.com/api/health
• APK: https://ahmedmyportofilo.netlify.app/apks/hrm.apk
• Source private — email GitHub username for access

Stack: Laravel · Filament · React · Flutter · Sanctum · Docker.''',
    ),
    FaqEntry(
      ['backend', 'backend integration', 'api', 'database', 'firebase', 'supabase', 'laravel'],
      '''Backend Integration:
• Laravel REST API — used in HRM NAWA TECH (Filament admin + React dashboard + Sanctum) and IT Assist NAWA TECH
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
• Mezo Food App — private
• IT Assist NAWA TECH — private
• Werdi Quran App — public: https://github.com/ahmedehab96-c/werdi
• StepZone — public: https://github.com/ahmedehab96-c/stepzone
• BankX — private (no public repo link)

For private-source projects, contact Ahmed at $email for collaboration or access discussions.''',
    ),
    FaqEntry(
      ['private repo', 'private repository', 'private github', 'can i see code', 'source code private'],
      'Life OS and Werdi are public on GitHub. StepZone is public. HRM, Mezo, IT Assist, and BankX are private. For hiring or partnership inquiries, contact Ahmed directly.',
    ),
    FaqEntry(
      ['demo', 'try project', 'web demo', 'live demo', 'how to try'],
      """Use **Try this project** on each project page:

• **HRM** — Open live demo (Render admin) + Download APK
  Admin: https://hrm-nawa-api.onrender.com/admin
  React dashboard: https://hrm-nawa-api.onrender.com/dashboard
  APK: https://ahmedmyportofilo.netlify.app/apks/hrm.apk

• **Mezo Food** — Open live demo (web admin) + Download APK
  Admin: https://ahmedmyportofilo.netlify.app/demos/mezo-admin/
  Admin: admin@mezofood.com / MezoDemo123!
  APK: https://ahmedmyportofilo.netlify.app/apks/mezo.apk

• **IT Assist** — Open live demo (Render admin) + Download APK
  Admin: https://it-assist-api.onrender.com/panel/login
  IT: it@company.com / password
  APK: https://ahmedmyportofilo.netlify.app/apks/itassist.apk

Life OS — Google Play: https://play.google.com/store/apps/details?id=com.ahmed.lifeos
Werdi — Google Play: https://play.google.com/store/apps/details?id=com.werdi.app
Others have APKs on this portfolio under /apks/.
StepZone — https://github.com/ahmedehab96-c/stepzone (public)""",
    ),
    FaqEntry(
      ['apk', 'download apk', 'android app', 'install app'],
      """APK downloads (hosted on this portfolio):

Life OS — Google Play: https://play.google.com/store/apps/details?id=com.ahmed.lifeos
Werdi — Google Play: https://play.google.com/store/apps/details?id=com.werdi.app
HRM — https://ahmedmyportofilo.netlify.app/apks/hrm.apk
Mezo — https://ahmedmyportofilo.netlify.app/apks/mezo.apk
IT Assist — https://ahmedmyportofilo.netlify.app/apks/itassist.apk
StepZone — https://ahmedmyportofilo.netlify.app/apks/stepzone.apk
BankX — https://ahmedmyportofilo.netlify.app/apks/bankx.apk""",
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
      '''Services Ahmed offers (see the Services section on the portfolio):
• Mobile App Development — Flutter apps for Android and iOS
• Web Development — modern responsive web apps with React.js
• Backend Development — Laravel APIs, databases, authentication, business logic
• Full-Stack Development — complete apps from frontend to backend
• AI Integration — AI capabilities inside mobile and web applications
• API Integration — REST APIs and third-party service integrations''',
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
    final repoNote = isGithubPrivate
        ? '\n\n🔒 Source code: Private GitHub repository (contact Ahmed for access).'
        : '';
    return '$summary\n\nFeatures:\n$featuresText\n\nTech: $techText$repoNote';
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
