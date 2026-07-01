// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ahmed\'s Portfolio';

  @override
  String get navNavigation => 'Navigation';

  @override
  String get navAbout => 'About';

  @override
  String get navEducation => 'Education';

  @override
  String get navSkills => 'Skills';

  @override
  String get navProjects => 'Projects';

  @override
  String get navContact => 'Contact';

  @override
  String get navAI => 'AI Assistant';

  @override
  String get navAIShort => 'AI';

  @override
  String get languageToggle => 'عربي';

  @override
  String get heroTagline =>
      'Crafting beautiful & functional mobile experiences\nwith a focus on clean architecture and great UX.';

  @override
  String get yearsExp => 'Years Exp.';

  @override
  String get statProjects => 'Projects';

  @override
  String get statTechnologies => 'Technologies';

  @override
  String get viewProjects => 'View Projects';

  @override
  String get contactMe => 'Contact Me';

  @override
  String get aboutMe => 'About Me';

  @override
  String get educationTitle => 'Education & Certifications';

  @override
  String get skillsTitle => 'Skills & Expertise';

  @override
  String get skillsSubtitle => 'Technologies and tools I specialize in:';

  @override
  String get featuredProjects => 'Featured Projects';

  @override
  String get featuredProjectsSubtitle =>
      'Selected apps and platforms I designed and built.';

  @override
  String get privateRepo => 'Private repo';

  @override
  String get openSource => 'Open source';

  @override
  String get viewProject => 'View project';

  @override
  String get getInTouch => 'Get in Touch';

  @override
  String get getInTouchSubtitle =>
      'Open to work — feel free to reach out anytime.';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get downloadCv => 'Download CV';

  @override
  String get chatWithAI => 'Chat with AI Assistant';

  @override
  String get builtWith => 'Built with Flutter & ❤️';

  @override
  String get couldNotOpenLink => 'Could not open link';

  @override
  String errorGeneric(String message) {
    return 'Error: $message';
  }

  @override
  String get techStack => 'Tech Stack';

  @override
  String get viewReadmeGitHub => 'View README on GitHub';

  @override
  String get about => 'About';

  @override
  String get topics => 'Topics';

  @override
  String get features => 'Features';

  @override
  String get overview => 'Overview';

  @override
  String get screenshotSoon => 'Screenshot coming soon';

  @override
  String get viewFull => 'View full';

  @override
  String pageOf(int current, int total) {
    return '$current of $total';
  }

  @override
  String get privateRepoNotice =>
      'Source code is hosted in a private GitHub repository. Contact Ahmed for access.';

  @override
  String get couldNotOpenGithub => 'Could not open GitHub';

  @override
  String get privateRepoLabel => 'Private Repo';

  @override
  String get sourceCode => 'Source Code';

  @override
  String get code => 'Code';

  @override
  String get privateOnGithub => 'Private on GitHub';

  @override
  String get viewOnGithub => 'View on GitHub';

  @override
  String get aiAssistant => 'AI Assistant';

  @override
  String suggestedQuestions(int count) {
    return 'Suggested questions ($count)';
  }

  @override
  String welcomeMessage(String version) {
    return 'Hello! I am Ahmed Ehab\'s portfolio AI assistant.\n\nData version: $version\n\nI know everything on this site: About, 5 featured projects, 6 skill areas, education, contact, and more.\n\nTap a suggested question below, or ask: \"What can you help me with?\"';
  }

  @override
  String get typeMessage => 'Type your message here...';

  @override
  String get somethingWentWrong =>
      'Sorry, something went wrong. Please try again.';

  @override
  String get emptyQuestion =>
      'Type your question and I will help you right away.';

  @override
  String get year => 'Year';

  @override
  String get description => 'Description';

  @override
  String get accreditedBy => 'Accredited by';

  @override
  String get date => 'Date';

  @override
  String get roleTag => 'Mid-Level Flutter Engineer';
}
