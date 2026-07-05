import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/portfolio_knowledge.dart';

class ProfileEducationEntry {
  const ProfileEducationEntry({
    required this.title,
    required this.subtitle,
    required this.details,
    required this.color,
  });

  final String title;
  final String subtitle;
  final List<(String, String)> details;
  final Color color;
}

class ProfileSkillCategory {
  const ProfileSkillCategory({
    required this.category,
    required this.icon,
    required this.color,
    required this.skills,
  });

  final String category;
  final IconData icon;
  final Color color;
  final List<String> skills;
}

/// Profile content for About, Education, and Skills sections.
class PortfolioProfileContent {
  PortfolioProfileContent._();

  static String role(Locale locale) => PortfolioKnowledge.role;

  static String tagline(Locale locale) => PortfolioKnowledge.tagline;

  static String aboutParagraph1(Locale locale) =>
      PortfolioKnowledge.aboutParagraph1;

  static String aboutParagraph2(Locale locale) =>
      PortfolioKnowledge.aboutParagraph2;

  static List<String> aboutHighlights(Locale locale) => const [
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
          title: 'Bachelor of Information Technology',
          subtitle: 'Al-Mashriq University - Sudan',
          details: [('Year', '2018')],
          color: Color(0xFF0099FF),
        ),
        ProfileEducationEntry(
          title: 'Flutter Development Course',
          subtitle: 'Udemy - Online Platform',
          details: [
            ('Description', 'Mobile App Development with Flutter'),
          ],
          color: Color(0xFF00B0FF),
        ),
        ProfileEducationEntry(
          title: 'Training Diploma in Artificial Intelligence',
          subtitle:
              'ALBYAN Institute Education Support Services – Abu Dhabi, UAE',
          details: [
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
          color: Color(0xFFFF6B6B),
        ),
      ];

  static List<ProfileSkillCategory> skillCategories(Locale locale) =>
      _skillCategories;

  static const _skillCategories = <ProfileSkillCategory>[
    ProfileSkillCategory(
      category: 'Technical Skills',
      icon: FontAwesomeIcons.code,
      color: Color(0xFF0099FF),
      skills: [
        'Flutter & Dart',
        'Cross-platform mobile development (Android & iOS)',
        'State management: BLoC, GetX, Riverpod',
        'Widget-based UI design & custom components',
        'Animations and responsive layouts',
        'Working with pub.dev packages',
      ],
    ),
    ProfileSkillCategory(
      category: 'Backend Integration',
      icon: FontAwesomeIcons.database,
      color: Color(0xFF00B0FF),
      skills: [
        'Firebase (Auth, Firestore, Realtime DB, Storage, Cloud Functions)',
        'Supabase integration',
        'RESTful API consumption using http or Dio',
        'Local storage: SQLite, Hive, SharedPreferences',
      ],
    ),
    ProfileSkillCategory(
      category: 'Laravel',
      icon: FontAwesomeIcons.laravel,
      color: Color(0xFFFF2D20),
      skills: [
        'RESTful API development with Laravel',
        'Eloquent ORM & database migrations',
        'Authentication with Laravel Sanctum / Passport',
        'Role & permission management',
        'API integration with Flutter frontend',
      ],
    ),
    ProfileSkillCategory(
      category: 'Authentication',
      icon: FontAwesomeIcons.lock,
      color: Color(0xFF0288D1),
      skills: [
        'Email/password login',
        'Google, Facebook, Apple sign-in',
        'Role-based access and route guarding',
      ],
    ),
    ProfileSkillCategory(
      category: 'Tools & Platforms',
      icon: FontAwesomeIcons.screwdriverWrench,
      color: Color(0xFF0099FF),
      skills: [
        'Git/GitHub for version control',
        'VS Code, Android Studio',
        'Firebase Hosting / Play Store deployment',
        'Postman for API testing',
      ],
    ),
    ProfileSkillCategory(
      category: 'UI/UX Skills',
      icon: FontAwesomeIcons.palette,
      color: Color(0xFF00B0FF),
      skills: [
        'Material Design & Cupertino widgets',
        'Clean architecture (MVC, MVVM)',
        'Light/Dark theme implementation',
        'Responsive design for mobile, tablet, web',
      ],
    ),
    ProfileSkillCategory(
      category: 'Soft Skills',
      icon: FontAwesomeIcons.lightbulb,
      color: Color(0xFF0288D1),
      skills: [
        'Problem-solving & debugging',
        'Agile & team collaboration',
        'Time management',
        'Clean code writing & documentation',
        'Fast learning of new tools/libraries',
      ],
    ),
  ];
}
