import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/portfolio_knowledge.dart';

class ProfileEducationEntry {
  const ProfileEducationEntry({
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.detailsEn,
    required this.detailsAr,
    required this.color,
  });

  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final List<(String, String)> detailsEn;
  final List<(String, String)> detailsAr;
  final Color color;

  String title(Locale locale) =>
      PortfolioProfileContent.isArabic(locale) ? titleAr : titleEn;

  String subtitle(Locale locale) =>
      PortfolioProfileContent.isArabic(locale) ? subtitleAr : subtitleEn;

  List<(String, String)> details(Locale locale) =>
      PortfolioProfileContent.isArabic(locale) ? detailsAr : detailsEn;
}

class ProfileSkillCategory {
  const ProfileSkillCategory({
    required this.categoryEn,
    required this.categoryAr,
    required this.icon,
    required this.color,
    required this.skillsEn,
    required this.skillsAr,
  });

  final String categoryEn;
  final String categoryAr;
  final IconData icon;
  final Color color;
  final List<String> skillsEn;
  final List<String> skillsAr;

  String category(Locale locale) =>
      PortfolioProfileContent.isArabic(locale) ? categoryAr : categoryEn;

  List<String> skills(Locale locale) =>
      PortfolioProfileContent.isArabic(locale) ? skillsAr : skillsEn;
}

/// Bilingual profile content for About, Education, and Skills sections.
class PortfolioProfileContent {
  PortfolioProfileContent._();

  static bool isArabic(Locale locale) => locale.languageCode == 'ar';

  static String role(Locale locale) =>
      isArabic(locale) ? 'مهندس Flutter متوسط' : PortfolioKnowledge.role;

  static String tagline(Locale locale) => isArabic(locale)
      ? 'أصمم تجارب موبايل جميلة وعملية مع تركيز على تجربة المستخدم والكود النظيف'
      : PortfolioKnowledge.tagline;

  static String aboutParagraph1(Locale locale) => isArabic(locale)
      ? 'أنا مهندس Flutter متوسط الخبرة مع أكثر من 3 سنوات في بناء تطبيقات متجاوبة وغنية بالميزات. أستمتع بحل المشكلات وتصميم واجهات سهلة الاستخدام تعمل بسلاسة على مختلف المنصات.'
      : PortfolioKnowledge.aboutParagraph1;

  static String aboutParagraph2(Locale locale) => isArabic(locale)
      ? 'أركز على كتابة كود نظيف وفعّال وقابل للصيانة مع تقديم تجارب مستخدم مميزة. أطور مهاراتي باستمرار بمساعدة أدوات الذكاء الاصطناعي مثل Cursor وClaude لتسريع التطوير واستكشاف أنماط جديدة.'
      : PortfolioKnowledge.aboutParagraph2;

  static List<String> aboutHighlights(Locale locale) => isArabic(locale)
      ? [
          'Flutter',
          'Dart',
          'Firebase',
          'GetX',
          'REST API',
          'معمارية نظيفة',
          'UI/UX',
        ]
      : [
          'Flutter',
          'Dart',
          'Firebase',
          'GetX',
          'REST API',
          'Clean Architecture',
          'UI/UX',
        ];

  static List<ProfileEducationEntry> educationEntries(Locale locale) => const [
      ProfileEducationEntry(
        titleEn: 'Bachelor of Information Technology',
        titleAr: 'بكالوريوس تقنية المعلومات',
        subtitleEn: 'Al-Mashriq University - Sudan',
        subtitleAr: 'جامعة المشرق - السودان',
        detailsEn: [('Year', '2018')],
        detailsAr: [('السنة', '2018')],
        color: Color(0xFF0099FF),
      ),
      ProfileEducationEntry(
        titleEn: 'Flutter Development Course',
        titleAr: 'دورة تطوير Flutter',
        subtitleEn: 'Udemy - Online Platform',
        subtitleAr: 'Udemy - منصة تعليمية',
        detailsEn: [
          ('Description', 'Mobile App Development with Flutter'),
        ],
        detailsAr: [
          ('الوصف', 'تطوير تطبيقات الموبايل باستخدام Flutter'),
        ],
        color: Color(0xFF00B0FF),
      ),
      ProfileEducationEntry(
        titleEn: 'Training Diploma in Artificial Intelligence',
        titleAr: 'دبلوم تدريبي في الذكاء الاصطناعي',
        subtitleEn:
            'ALBYAN Institute Education Support Services – Abu Dhabi, UAE',
        subtitleAr: 'معهد البيان لخدمات دعم التعليم – أبوظبي، الإمارات',
        detailsEn: [
          (
            'Accredited by',
            'ACTVET – Abu Dhabi Centre for Technical and Vocational Education and Training',
          ),
          ('Date', '18 October 2026 • Grade: Excellent'),
          (
            'Description',
            'Completed a comprehensive 120-hour professional diploma covering applied Artificial Intelligence, machine learning concepts, and AI-driven system development for technical and vocational applications.',
          ),
        ],
        detailsAr: [
          (
            'معتمد من',
            'ACTVET – مركز أبوظبي للتعليم والتدريب التقني والمهني',
          ),
          ('التاريخ', '18 أكتوبر 2026 • التقدير: ممتاز'),
          (
            'الوصف',
            'أكملت دبلوماً مهنياً شاملاً (120 ساعة) يغطي الذكاء الاصطناعي التطبيقي ومفاهيم التعلم الآلي وتطوير الأنظمة المعتمدة على AI للتطبيقات التقنية والمهنية.',
          ),
        ],
        color: Color(0xFFFF6B6B),
      ),
    ];

  static List<ProfileSkillCategory> skillCategories(Locale locale) {
    return _skillCategories;
  }

  static const _skillCategories = <ProfileSkillCategory>[
      ProfileSkillCategory(
        categoryEn: 'Technical Skills',
        categoryAr: 'المهارات التقنية',
        icon: FontAwesomeIcons.code,
        color: Color(0xFF0099FF),
        skillsEn: [
          'Flutter & Dart',
          'Cross-platform mobile development (Android & iOS)',
          'State management: BLoC, GetX, Riverpod',
          'Widget-based UI design & custom components',
          'Animations and responsive layouts',
          'Working with pub.dev packages',
        ],
        skillsAr: [
          'Flutter و Dart',
          'تطوير موبايل متعدد المنصات (أندرويد و iOS)',
          'إدارة الحالة: BLoC و GetX و Riverpod',
          'تصميم واجهات مبنية على Widget ومكونات مخصصة',
          'الحركات والتخطيطات المتجاوبة',
          'العمل مع حزم pub.dev',
        ],
      ),
      ProfileSkillCategory(
        categoryEn: 'Backend Integration',
        categoryAr: 'تكامل الخلفية',
        icon: FontAwesomeIcons.database,
        color: Color(0xFF00B0FF),
        skillsEn: [
          'Firebase (Auth, Firestore, Realtime DB, Storage, Cloud Functions)',
          'Supabase integration',
          'RESTful API consumption using http or Dio',
          'Local storage: SQLite, Hive, SharedPreferences',
        ],
        skillsAr: [
          'Firebase (Auth, Firestore, Realtime DB, Storage, Cloud Functions)',
          'تكامل Supabase',
          'استهلاك REST API عبر http أو Dio',
          'تخزين محلي: SQLite و Hive و SharedPreferences',
        ],
      ),
      ProfileSkillCategory(
        categoryEn: 'Laravel',
        categoryAr: 'Laravel',
        icon: FontAwesomeIcons.laravel,
        color: Color(0xFFFF2D20),
        skillsEn: [
          'RESTful API development with Laravel',
          'Eloquent ORM & database migrations',
          'Authentication with Laravel Sanctum / Passport',
          'Role & permission management',
          'API integration with Flutter frontend',
        ],
        skillsAr: [
          'تطوير REST API بـ Laravel',
          'Eloquent ORM وهجرات قاعدة البيانات',
          'المصادقة عبر Laravel Sanctum / Passport',
          'إدارة الأدوار والصلاحيات',
          'تكامل API مع واجهة Flutter',
        ],
      ),
      ProfileSkillCategory(
        categoryEn: 'Authentication',
        categoryAr: 'المصادقة',
        icon: FontAwesomeIcons.lock,
        color: Color(0xFF0288D1),
        skillsEn: [
          'Email/password login',
          'Google, Facebook, Apple sign-in',
          'Role-based access and route guarding',
        ],
        skillsAr: [
          'تسجيل دخول بالبريد/كلمة المرور',
          'تسجيل دخول Google و Facebook و Apple',
          'صلاحيات حسب الدور وحماية المسارات',
        ],
      ),
      ProfileSkillCategory(
        categoryEn: 'Tools & Platforms',
        categoryAr: 'الأدوات والمنصات',
        icon: FontAwesomeIcons.screwdriverWrench,
        color: Color(0xFF0099FF),
        skillsEn: [
          'Git/GitHub for version control',
          'VS Code, Android Studio',
          'Firebase Hosting / Play Store deployment',
          'Postman for API testing',
        ],
        skillsAr: [
          'Git/GitHub لإدارة الإصدارات',
          'VS Code و Android Studio',
          'نشر Firebase Hosting / Play Store',
          'Postman لاختبار API',
        ],
      ),
      ProfileSkillCategory(
        categoryEn: 'UI/UX Skills',
        categoryAr: 'مهارات UI/UX',
        icon: FontAwesomeIcons.palette,
        color: Color(0xFF00B0FF),
        skillsEn: [
          'Material Design & Cupertino widgets',
          'Clean architecture (MVC, MVVM)',
          'Light/Dark theme implementation',
          'Responsive design for mobile, tablet, web',
        ],
        skillsAr: [
          'Material Design و Cupertino',
          'معمارية نظيفة (MVC, MVVM)',
          'ثيمات فاتح/داكن',
          'تصميم متجاوب للموبايل والتابلت والويب',
        ],
      ),
      ProfileSkillCategory(
        categoryEn: 'Soft Skills',
        categoryAr: 'المهارات الشخصية',
        icon: FontAwesomeIcons.lightbulb,
        color: Color(0xFF0288D1),
        skillsEn: [
          'Problem-solving & debugging',
          'Agile & team collaboration',
          'Time management',
          'Clean code writing & documentation',
          'Fast learning of new tools/libraries',
        ],
        skillsAr: [
          'حل المشكلات وتصحيح الأخطاء',
          'Agile والعمل الجماعي',
          'إدارة الوقت',
          'كتابة كود نظيف وتوثيق',
          'تعلم سريع للأدوات والمكتبات الجديدة',
        ],
      ),
    ];
}
