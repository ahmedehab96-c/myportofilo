import { featuredProjects } from './portfolioContent';

const fullName = 'Ahmed Ehab Mohammed';
const role = 'Full-Stack Mobile & Web Developer';
const yearsOfExperience = '4+';
const tagline =
  'Crafting beautiful and functional mobile and web experiences with a focus on user-centric design and clean code architecture';

const email = 'ahmed96it96@gmail.com';
const phone = '+971 58 915 4605';
const github = 'github.com/ahmedehab96-c';
const githubUrl = 'https://github.com/ahmedehab96-c';
const linkedIn = 'Ahmed Ehab';
const linkedInUrl = 'https://www.linkedin.com/in/ahmed-ehab-ba8a63285';
const cvUrl = 'https://drive.google.com/file/d/1r6r5ScPVkKEE1Pqs0GWcPH89KC14gKn1/view?usp=drivesdk';
const dubaiCertificateUrl = 'https://ahmedmyportofilo.netlify.app/docs/ahmed-ehab-certificate.pdf';

const aboutParagraph1 =
  'I am a full-stack mobile and web developer with 4+ years of experience building responsive and feature-rich applications. Flutter/Dart is the core of my stack — I build complete, production-ready apps with it — and I extend that with React.js for admin dashboards and web additions, often enhanced with AI-powered features. I enjoy creating user-friendly designs that provide seamless experiences across platforms.';

const aboutParagraph2 =
  'My focus is on creating clean, efficient, and maintainable code while delivering exceptional user experiences. I continuously grow my skills with the help of AI tools — using Cursor and Claude to accelerate development, explore new patterns, and stay at the forefront of mobile development.';

const suggestedQuestions = [
  'Who are you?',
  'Tell me about yourself',
  'What is your job title?',
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
  'What are your technical skills?',
  'Do you know GetX and BLoC?',
  'What backend technologies do you use?',
  'Can you build authentication?',
  'What is your education?',
  'Tell me about your AI diplomas',
  'Where did you study?',
  'How can I contact you?',
  'What is your email?',
  'Are you available for hire?',
  'How much does an app cost?',
  'Where can I download your CV?',
  'What sections are in this portfolio?',
  'What can you help me with?',
];

const helpTopicsReply = `I can answer detailed questions about every part of Ahmed Ehab's portfolio:

👤 Hero & About
• Full name, role (Full-Stack Mobile & Web Developer), tagline, years of experience (4+)
• Bio, highlights (Flutter, Dart, React.js, HTML, CSS, JavaScript, Firebase, GetX, REST API, Clean Architecture, UI/UX)
• Stats: 4+ years, 20+ projects, 6+ technologies

📱 Projects (7 apps — ask about any by name)
• HRM NAWA TECH — multi-tenant HR SaaS (Filament + React dashboard + Flutter + live Render demo + APK)
• Life OS — productivity app + Groq AI + Google Play
• Mezo Food App — food delivery + Flutter web admin + Firebase + APK
• IT Assist NAWA TECH — ITSM + Laravel + live Render admin + APK
• Werdi Quran App — memorization, tasmee3, Mushaf + Google Play
• BankX Digital Banking — fintech UI demo + APK
• StepZone — luxury shoe eCommerce + Supabase + APK

🛠 Skills (7 categories)
• Technical Skills, Backend Integration, Laravel, Authentication
• Tools & Platforms, UI/UX Skills, Soft Skills

🎓 Education & certifications (4 entries)
• BSc IT Al-Mashriq University 2018
• Udemy Flutter Course
• One Million Prompters — Dubai Future Foundation / DCAI
• AI Diploma — ALBYAN Institute Abu Dhabi (ACTVET, Excellent)

💼 Services
• Flutter apps, web dashboards, Firebase/Supabase, UI/UX, API & auth integration

📞 Contact & collaboration
• Email, phone (+971), GitHub, LinkedIn, CV download, hiring, pricing, live demos, APK links

💡 Examples: "Tell me about StepZone", "What is in the Skills section?", "How can I contact you?"`;

function projectsKnowledge() {
  return featuredProjects.map((p) => ({
    id: p.id,
    title: p.title,
    keywords: p.keywords,
    summary: p.summary,
    features: p.features,
    tech: p.tech,
    isGithubPrivate: p.isGithubPrivate,
  }));
}

function detailReply(p) {
  const featuresText = p.features.map((f) => `• ${f}`).join('\n');
  const techText = p.tech.join(', ');
  const repoNote = p.isGithubPrivate
    ? '\n\n🔒 Source code: Private GitHub repository (contact Ahmed for access).'
    : '';
  return `${p.summary}\n\nFeatures:\n${featuresText}\n\nTech: ${techText}${repoNote}`;
}

function assistantSystemPrompt() {
  let buffer = `PORTFOLIO FACTS (use ONLY these — do not invent):

Name: ${fullName} | Role: ${role} | Experience: ${yearsOfExperience} years
Tagline: ${tagline}
Email: ${email} | Phone: ${phone}
GitHub: ${githubUrl} | LinkedIn: ${linkedInUrl}
CV: ${cvUrl} | Dubai certificate: ${dubaiCertificateUrl}

About:
${aboutParagraph1}
${aboutParagraph2}

Hero stats: ${yearsOfExperience} years experience, 20+ projects, 6+ technologies
About highlights: Flutter, Dart, Firebase, GetX, REST API, Clean Architecture, UI/UX

Portfolio sections: Hero, About Me, Education & Certifications, Skills & Expertise (7 categories), Projects (7 apps), Contact, Download CV, AI Assistant

Skills categories:
1. Technical Skills — Flutter, Dart, BLoC/GetX/Riverpod, widgets, animations
2. Backend Integration — Firebase, Supabase, REST, SQLite, Hive
3. Laravel — REST API, Eloquent, Sanctum, RBAC, Flutter integration
4. Authentication — email, Google/Facebook/Apple, RBAC
5. Tools & Platforms — Git, VS Code, Android Studio, Cursor, Postman, Play Store
6. UI/UX — Material/Cupertino, MVC/MVVM, themes, responsive design
7. Soft Skills — problem-solving, agile, documentation, fast learning

Education: BSc IT Al-Mashriq University 2018; Udemy Flutter; One Million Prompters (Dubai); AI Diploma ALBYAN Abu Dhabi ACTVET Oct 2026 Excellent

Services: Flutter mobile/web apps, Firebase/Supabase backends, UI/UX, API & auth integration

PROJECTS (${featuredProjects.length}):
`;

  for (const p of featuredProjects) {
    buffer += `--- ${p.title} (${p.id}) ---\n`;
    buffer += `Summary: ${p.summary}\n`;
    buffer += `Tech: ${p.tech.join(', ')}\n`;
    buffer += `Features: ${p.features.slice(0, 6).join('; ')}\n`;
    if (p.liveDemoUrl) buffer += `Live demo: ${p.liveDemoUrl}\n`;
    if (p.playStoreUrl) buffer += `Google Play: ${p.playStoreUrl}\n`;
    if (p.apkUrl) buffer += `APK: ${p.apkUrl}\n`;
    if (p.githubUrl) {
      buffer += `GitHub: ${p.githubUrl} (${p.isGithubPrivate ? 'private' : 'public'})\n`;
    } else if (p.isGithubPrivate) {
      buffer += 'GitHub: private — contact for access\n';
    }
    buffer += '\n';
  }

  return buffer;
}

const faqEntries = [
  [['who are you', 'who is ahmed', 'introduce yourself', 'about you'],
    `${fullName} is a ${role}.\n\n${aboutParagraph1}\n\n${aboutParagraph2}`],
  [['full name', 'your name', 'what is your name'], `Full name: ${fullName}`],
  [['job title', 'your role', 'what do you do', 'profession', 'occupation'], `Role: ${role}\n\n${tagline}`],
  [['about me', 'bio', 'background', 'tell me about yourself', 'summary'],
    `About ${fullName}:\n\n${aboutParagraph1}\n\n${aboutParagraph2}`],
  [['passion', 'why flutter', 'what motivates', 'focus'],
    'Ahmed is passionate about Flutter, user-centric design, clean architecture, and building apps that work smoothly on mobile and web.'],
  [['location', 'where are you based', 'country', 'uae', 'dubai', 'abu dhabi'],
    'Contact number uses UAE country code (+971). Ahmed works as a Flutter developer and is open to remote collaboration. Reach out to confirm current location and availability.'],
  [['portfolio sections', 'sections in portfolio', 'what is on this site', 'website sections', 'pages on portfolio'],
    `This portfolio includes:\n\n• Header — name, role, and quick actions\n• About Me — background and approach\n• Education & Certifications\n• Skills & Expertise (7 categories)\n• Projects (7 featured apps)\n• Contact information\n• Download CV button\n• AI Assistant (this chat)`],
  [['what can you help', 'what can i ask', 'help topics', 'list questions', 'supported questions', 'commands'],
    helpTopicsReply],
  [['education', 'qualifications', 'degrees', 'studied', 'academic'],
    `Education & certifications:\n\n🎓 Bachelor of Information Technology\n   Al-Mashriq University — Sudan (2018)\n\n💻 Flutter Development Course\n   Udemy — Mobile App Development with Flutter\n\n🤖 One Million Prompters — Certificate of Completion\n   Dubai Future Foundation · Dubai Centre for Artificial Intelligence\n   Prompt engineering for AI systems (Dubai Universal Blueprint for AI)\n   View certificate: ${dubaiCertificateUrl}\n\n🧠 Training Diploma in Artificial Intelligence\n   ALBYAN Institute, Abu Dhabi, UAE\n   Accredited by ACTVET | 18 Oct 2026 | Grade: Excellent\n   120-hour diploma: applied AI, ML concepts, AI-driven systems`],
  [['university', 'bachelor', 'degree', 'mashriq', 'sudan 2018'],
    'Bachelor of Information Technology\nInstitution: Al-Mashriq University — Sudan\nYear: 2018'],
  [['udemy', 'flutter course', 'online course'],
    'Flutter Development Course on Udemy.\nFocus: Mobile App Development with Flutter.'],
  [['ai diploma', 'artificial intelligence', 'albyan', 'actvet', 'machine learning diploma'],
    'AI Diploma — ALBYAN Institute, Abu Dhabi, UAE:\n• Accredited by ACTVET (Abu Dhabi Centre for Technical and Vocational Education and Training)\n• Date: 18 October 2026 | Grade: Excellent\n• 120-hour professional diploma covering applied AI, machine learning concepts, and AI-driven system development'],
  [['certificate', 'certification', 'dubai certificate', 'view certificate', 'one million prompters', 'prompt engineering', 'dubai future foundation'],
    `One Million Prompters — Certificate of Completion (Dubai):\n• Issued by Dubai Future Foundation & Dubai Centre for Artificial Intelligence\n• Prompt engineering for AI systems — Dubai Universal Blueprint for Artificial Intelligence\n• Listed under Education on the portfolio\n\nView certificate (PDF): ${dubaiCertificateUrl}`],
  [['skills', 'skills section', 'expertise', 'what skills', 'skill categories'],
    'Skills & Expertise — 7 categories on the portfolio:\n\n1️⃣ Technical Skills — Flutter & Dart, cross-platform, BLoC/GetX/Riverpod, widgets, animations\n2️⃣ Backend Integration — Firebase, Supabase, REST, SQLite, Hive, SharedPreferences\n3️⃣ Laravel — REST API, Eloquent, Sanctum/Passport, RBAC, Flutter integration\n4️⃣ Authentication — email/password, Google/Facebook/Apple sign-in, route guarding\n5️⃣ Tools & Platforms — Git/GitHub, VS Code, Android Studio, Cursor, Postman, Play Store\n6️⃣ UI/UX Skills — Material/Cupertino, MVC/MVVM, light/dark themes, responsive design\n7️⃣ Soft Skills — problem-solving, agile, time management, documentation, fast learning\n\nAsk "What are your technical skills?" or "Do you know Laravel?" for details.'],
  [['hero', 'header', 'stats', 'years of experience', 'how many projects', 'technologies count'],
    `Hero section highlights:\n• Name: ${fullName}\n• Role: ${role}\n• Experience: ${yearsOfExperience} years\n• Portfolio stats: 20+ projects, 6+ technologies\n• Tagline: Crafting beautiful & functional mobile experiences with clean architecture and great UX`],
  [['about highlights', 'tech stack summary', 'what technologies'],
    'About highlights on the portfolio: Flutter, Dart, Firebase, GetX, REST API, Clean Architecture, UI/UX.'],
  [['life os', 'lifeos', 'productivity app', 'groq', 'google play life'],
    'Life OS — free personal productivity app:\n• Tasks, habits, goals, finance, notes, Groq-powered AI assistant\n• Offline SQLite + Supabase sync, speech-to-text\n• Google Play: https://play.google.com/store/apps/details?id=com.ahmed.lifeos\n• GitHub (public): https://github.com/ahmedehab96-c/LifeOS\n• Tech: Flutter, BLoC, Supabase, SQLite, Groq AI'],
  [['mezo', 'mezo food', 'food delivery', 'restaurant app'],
    'Mezo Food App — food ordering & delivery:\n• Customer Flutter app + responsive Flutter Web admin\n• Firebase, Google Maps, Stripe/demo/cash, Arabic/English RTL\n• Live admin: https://ahmedmyportofilo.netlify.app/demos/mezo-admin/\n• Admin: admin@mezofood.com / MezoDemo123!\n• APK: https://ahmedmyportofilo.netlify.app/apks/mezo.apk\n• GitHub: private'],
  [['it assist', 'itsm', 'helpdesk', 'it support app'],
    'IT Assist NAWA TECH — ITSM SaaS:\n• Flutter mobile + Laravel admin/API, tickets, AI assistant, Socket.IO, biometrics\n• Live panel: https://it-assist-api.onrender.com/panel/login\n• IT Admin: it@company.com / password | Employee: mohammed@company.com / password\n• APK: https://ahmedmyportofilo.netlify.app/apks/itassist.apk\n• GitHub: private'],
  [['werdi', 'quran', 'memorization', 'tasmee3', 'mushaf'],
    'Werdi Quran App (v1.0.1+11):\n• No login — open and start; local progress on device\n• Memorization, tasmee3 voice evaluation, Mushaf, ayah audio, achievements\n• Google Play: https://play.google.com/store/apps/details?id=com.werdi.app\n• GitHub (public): https://github.com/ahmedehab96-c/werdi\n• Tech: Flutter, BLoC, Drift, Supabase, just_audio'],
  [['bankx', 'banking', 'bank app', 'fintech', 'digital banking'],
    'BankX Digital Banking — Flutter banking UI demo:\n• Dashboard, transfers, bill pay, cards, biometric-ready sign-in, Material 3\n• APK: https://ahmedmyportofilo.netlify.app/apks/bankx.apk\n• Source: private repository — contact Ahmed for access\n• Tech: Flutter, Material 3, Clean Architecture'],
  [['stepzone', 'shoes', 'ecommerce', 'luxury shoes', 'online store'],
    'StepZone — luxury shoe eCommerce:\n• Supabase backend, Google sign-in, coupons, AED pricing, reviews\n• Demo: stepzone.demo@gmail.com / StepZone2026! | Coupons: LUXE10, KICKS20, WELCOME15\n• APK: https://ahmedmyportofilo.netlify.app/apks/stepzone.apk\n• GitHub (public): https://github.com/ahmedehab96-c/stepzone\n• Tech: Flutter, GetX, Supabase, PostgreSQL, Edge Functions, React.js + Vite (web storefront), Tap Payments'],
  [['navigation', 'menu', 'how to navigate', 'scroll sections'],
    'Use the top navigation (or mobile menu) to jump to:\n• About — bio and highlights\n• Education — degrees and AI certificates\n• Skills — 7 skill categories\n• Projects — 7 featured apps with demos and APKs\n• Contact — email, phone, GitHub, LinkedIn'],
  [['technical skills', 'flutter skills', 'dart skills', 'mobile development'],
    'Technical Skills:\n• Flutter & Dart — my core stack for full, production-ready apps (Android & iOS)\n• State management: BLoC, GetX, Riverpod\n• Custom widgets and UI components\n• Animations and responsive layouts\n• React.js as an addition — for admin dashboards and web, often with AI-powered features\n• Web development: HTML, CSS, JavaScript, React.js\n• pub.dev / npm packages integration'],
  [['hrm saas', 'saas hrm', 'multi-tenant', 'hrm trial', 'filament', 'hrm demo', 'live hrm', 'hrm render', 'hrm nawa tech', 'tell me about hrm', 'responsive hrm', 'react dashboard', 'hrm react'],
    `HRM NAWA TECH — multi-tenant HR SaaS with live demo:\n\n• Laravel Filament admin + React SPA dashboard + Flutter employee app + REST API\n• Company self-registration + 14-day free trial + plan caps\n• React dashboard covers employees, departments, attendance, leave, payroll, recruitment, performance, reports, roles & permissions — same Sanctum API as the mobile app\n• Responsive employee UI (phone / tablet / desktop)\n• AI-assisted recruitment, leave, performance, reports\n• Live demo: https://hrm-nawa-api.onrender.com/admin\n  React dashboard: https://hrm-nawa-api.onrender.com/dashboard\n  Admin: admin@demo.com / Admin12345!\n  Employee: emp01@demo.com / Employee12345!\n• API health: https://hrm-nawa-api.onrender.com/api/health\n• APK: https://ahmedmyportofilo.netlify.app/apks/hrm.apk\n• Source private — email GitHub username for access\n\nStack: Laravel · Filament · React · Flutter · Sanctum · Docker.`],
  [['backend', 'backend integration', 'api', 'database', 'firebase', 'supabase', 'laravel'],
    'Backend Integration:\n• Laravel REST API — used in HRM NAWA TECH (Filament admin + React dashboard + Sanctum) and IT Assist NAWA TECH\n• Firebase — Auth, Firestore, Cloud Messaging (Mezo + IT Assist)\n• Supabase — cloud backend for Life OS\n• HTTP/Dio for RESTful API calls in Flutter\n• SQLite for local offline storage\n• Local storage: SharedPreferences, flutter_secure_storage'],
  [['laravel', 'php backend', 'laravel api', 'eloquent', 'sanctum'],
    'Laravel Backend:\n• RESTful API development with Laravel\n• Eloquent ORM & database migrations\n• Authentication with Laravel Sanctum / Passport\n• Role & permission management\n• API integration with Flutter frontend'],
  [['authentication', 'auth', 'login', 'sign in', 'google sign', 'facebook login', 'apple sign'],
    'Authentication expertise:\n• Email/password login\n• Google, Facebook, and Apple sign-in\n• Role-based access and route guarding'],
  [['tools', 'platforms', 'git', 'vscode', 'android studio', 'postman', 'deployment'],
    'Tools & Platforms:\n• Git / GitHub for version control\n• VS Code and Android Studio\n• Firebase Hosting and Play Store deployment\n• Postman for API testing'],
  [['ui ux', 'design', 'material design', 'responsive', 'dark theme', 'mvvm', 'mvc'],
    'UI/UX Skills:\n• Material Design & Cupertino widgets\n• Clean architecture (MVC, MVVM)\n• Light/Dark theme implementation\n• Responsive design for mobile, tablet, and web'],
  [['soft skills', 'teamwork', 'agile', 'problem solving', 'documentation'],
    'Soft Skills:\n• Problem-solving and debugging\n• Agile and team collaboration\n• Time management\n• Clean code and documentation\n• Fast learning of new tools and libraries'],
  [['state management', 'getx', 'provider', 'bloc', 'riverpod'],
    'Ahmed uses GetX, Provider, BLoC, and Riverpod for state management in Flutter apps.'],
  [['do you know flutter', 'experience flutter', 'cross platform', 'ios android web'],
    'Yes. Ahmed specializes in Flutter for Android, iOS, and Web with responsive UI and production-ready architecture.'],
  [['which project uses firebase', 'firebase projects'],
    'Firebase is used in: Mezo Food App (Auth, Firestore, Cloud Functions, FCM) and IT Assist NAWA TECH (Firebase Messaging for push notifications). Life OS uses Supabase, not Firebase.'],
  [['which project uses supabase', 'supabase projects'],
    'Supabase is used in: Life OS — as the cloud backend for data sync, combined with local SQLite for offline support.'],
  [['which project uses laravel', 'laravel projects', 'laravel backend'],
    'Laravel is used as the server-side backend in: HRM NAWA TECH and IT Assist NAWA TECH. Both use REST API calls from Flutter to a Laravel API.'],
  [['which project uses bloc', 'bloc projects', 'state management'],
    'BLoC (flutter_bloc) is used in: Life OS, Mezo Food App, and Werdi Quran App. HRM and IT Assist use simpler state approaches (http/Dio).'],
  [['which project uses provider', 'provider projects'],
    'Provider is used in some Flutter projects, but the featured Mezo Food App uses BLoC for state management.'],
  [['socket.io', 'real-time', 'websocket'],
    'IT Assist NAWA TECH uses Socket.IO for real-time communication between staff and the IT support team.'],
  [['email', 'mail address', 'gmail'], `Email: ${email}`],
  [['phone', 'mobile', 'call', 'whatsapp number', 'telephone'], `Phone: ${phone}`],
  [['github', 'source code', 'repository', 'repos', 'code access'],
    `Public GitHub profile: ${github} (${githubUrl})\n\nRepository visibility:\n• HRM NAWA TECH — private\n• Life OS — public: https://github.com/ahmedehab96-c/LifeOS\n• Mezo Food App — private\n• IT Assist NAWA TECH — private\n• Werdi Quran App — public: https://github.com/ahmedehab96-c/werdi\n• StepZone — public: https://github.com/ahmedehab96-c/stepzone\n• BankX — private (no public repo link)\n\nFor private-source projects, contact Ahmed at ${email} for collaboration or access discussions.`],
  [['private repo', 'private repository', 'private github', 'can i see code', 'source code private'],
    'Life OS and Werdi are public on GitHub. StepZone is public. HRM, Mezo, IT Assist, and BankX are private. For hiring or partnership inquiries, contact Ahmed directly.'],
  [['demo', 'try project', 'web demo', 'live demo', 'how to try'],
    `Use **Try this project** on each project page:\n\n• **HRM** — Open live demo (Render admin) + Download APK\n  Admin: https://hrm-nawa-api.onrender.com/admin\n  React dashboard: https://hrm-nawa-api.onrender.com/dashboard\n  APK: https://ahmedmyportofilo.netlify.app/apks/hrm.apk\n\n• **Mezo Food** — Open live demo (web admin) + Download APK\n  Admin: https://ahmedmyportofilo.netlify.app/demos/mezo-admin/\n  Admin: admin@mezofood.com / MezoDemo123!\n  APK: https://ahmedmyportofilo.netlify.app/apks/mezo.apk\n\n• **IT Assist** — Open live demo (Render admin) + Download APK\n  Admin: https://it-assist-api.onrender.com/panel/login\n  IT: it@company.com / password\n  APK: https://ahmedmyportofilo.netlify.app/apks/itassist.apk\n\nLife OS — Google Play: https://play.google.com/store/apps/details?id=com.ahmed.lifeos\nWerdi — Google Play: https://play.google.com/store/apps/details?id=com.werdi.app\nOthers have APKs on this portfolio under /apks/.\nStepZone — https://github.com/ahmedehab96-c/stepzone (public)`],
  [['apk', 'download apk', 'android app', 'install app'],
    `APK downloads (hosted on this portfolio):\n\nLife OS — Google Play: https://play.google.com/store/apps/details?id=com.ahmed.lifeos\nWerdi — Google Play: https://play.google.com/store/apps/details?id=com.werdi.app\nHRM — https://ahmedmyportofilo.netlify.app/apks/hrm.apk\nMezo — https://ahmedmyportofilo.netlify.app/apks/mezo.apk\nIT Assist — https://ahmedmyportofilo.netlify.app/apks/itassist.apk\nStepZone — https://ahmedmyportofilo.netlify.app/apks/stepzone.apk\nBankX — https://ahmedmyportofilo.netlify.app/apks/bankx.apk`],
  [['linkedin', 'linked in', 'professional profile'], `LinkedIn: ${linkedIn}\nURL: ${linkedInUrl}`],
  [['contact', 'reach you', 'get in touch', 'how to contact'],
    `Contact Ahmed:\n📧 ${email}\n📱 ${phone}\n🔗 GitHub: ${github}\n💼 LinkedIn: ${linkedIn}`],
  [['cv', 'resume', 'download cv', 'curriculum'],
    `Download the CV using the "Download CV" button at the bottom of the portfolio page.\n\nDirect link: ${cvUrl}`],
  [['available', 'availability', 'hire', 'hiring', 'freelance', 'collaborate', 'need developer'],
    `Ahmed is open to Flutter projects (mobile, web, admin panels).\n\nContact for availability:\n📧 ${email}\n📱 ${phone}\n💼 LinkedIn: ${linkedIn}`],
  [['price', 'cost', 'budget', 'quote', 'how much', 'app cost', 'project cost'],
    `Pricing depends on app type, features, integrations, and timeline.\n\nFor a tailored quote, contact Ahmed:\n📧 ${email}\n📱 ${phone}`],
  [['services', 'what services', 'what do you offer', 'development services'],
    'Services Ahmed offers:\n• Flutter mobile apps (Android & iOS)\n• Flutter web portfolios and dashboards\n• Firebase / Supabase backend integration\n• UI/UX implementation and responsive design\n• API integration and authentication systems'],
].map(([keywords, answer]) => ({ keywords, answer, matches: (m) => keywords.some((k) => m.includes(k.toLowerCase())) }));

export const PortfolioKnowledge = {
  fullName,
  role,
  yearsOfExperience,
  tagline,
  email,
  phone,
  github,
  githubUrl,
  linkedIn,
  linkedInUrl,
  cvUrl,
  dubaiCertificateUrl,
  aboutParagraph1,
  aboutParagraph2,
  suggestedQuestions,
  helpTopicsReply,
  get projects() {
    return projectsKnowledge();
  },
  detailReply,
  get assistantSystemPrompt() {
    return assistantSystemPrompt();
  },
  faqEntries,
};
