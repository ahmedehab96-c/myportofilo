// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'بورتفوليو أحمد';

  @override
  String get navNavigation => 'التنقل';

  @override
  String get navAbout => 'نبذة';

  @override
  String get navEducation => 'التعليم';

  @override
  String get navSkills => 'المهارات';

  @override
  String get navProjects => 'المشاريع';

  @override
  String get navContact => 'التواصل';

  @override
  String get navAI => 'المساعد الذكي';

  @override
  String get navAIShort => 'ذكاء';

  @override
  String get languageToggle => 'EN';

  @override
  String get heroTagline =>
      'أصمم تجارب موبايل جميلة وعملية\nمع تركيز على المعمارية النظيفة وتجربة مستخدم ممتازة.';

  @override
  String get yearsExp => 'سنوات خبرة';

  @override
  String get statProjects => 'مشاريع';

  @override
  String get statTechnologies => 'تقنيات';

  @override
  String get viewProjects => 'عرض المشاريع';

  @override
  String get contactMe => 'تواصل معي';

  @override
  String get aboutMe => 'نبذة عني';

  @override
  String get educationTitle => 'التعليم والشهادات';

  @override
  String get skillsTitle => 'المهارات والخبرات';

  @override
  String get skillsSubtitle => 'التقنيات والأدوات التي أتقنها:';

  @override
  String get featuredProjects => 'المشاريع المميزة';

  @override
  String get featuredProjectsSubtitle =>
      'تطبيقات ومنصات مختارة صممتها وبنيتها.';

  @override
  String get privateRepo => 'مستودع خاص';

  @override
  String get openSource => 'مفتوح المصدر';

  @override
  String get viewProject => 'عرض المشروع';

  @override
  String get getInTouch => 'تواصل معي';

  @override
  String get getInTouchSubtitle =>
      'متاح للعمل — لا تتردد في التواصل في أي وقت.';

  @override
  String get phone => 'الهاتف';

  @override
  String get email => 'البريد';

  @override
  String get downloadCv => 'تحميل السيرة الذاتية';

  @override
  String get chatWithAI => 'محادثة المساعد الذكي';

  @override
  String get builtWith => 'مبني بـ Flutter و ❤️';

  @override
  String get couldNotOpenLink => 'لا يمكن فتح الرابط';

  @override
  String errorGeneric(String message) {
    return 'حدث خطأ: $message';
  }

  @override
  String get techStack => 'التقنيات';

  @override
  String get viewReadmeGitHub => 'عرض README على GitHub';

  @override
  String get about => 'نبذة';

  @override
  String get topics => 'المواضيع';

  @override
  String get features => 'الميزات';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get screenshotSoon => 'لقطة الشاشة قريباً';

  @override
  String get viewFull => 'عرض كامل';

  @override
  String pageOf(int current, int total) {
    return '$current من $total';
  }

  @override
  String get privateRepoNotice =>
      'الكود المصدري في مستودع GitHub خاص. تواصل مع أحمد للوصول.';

  @override
  String get couldNotOpenGithub => 'لا يمكن فتح GitHub';

  @override
  String get privateRepoLabel => 'مستودع خاص';

  @override
  String get sourceCode => 'الكود المصدري';

  @override
  String get code => 'كود';

  @override
  String get privateOnGithub => 'خاص على GitHub';

  @override
  String get viewOnGithub => 'عرض على GitHub';

  @override
  String get aiAssistant => 'المساعد الذكي';

  @override
  String suggestedQuestions(int count) {
    return 'أسئلة مقترحة ($count)';
  }

  @override
  String welcomeMessage(String version) {
    return 'مرحباً! أنا مساعد بورتفوليو أحمد إيهاب.\n\nإصدار البيانات: $version\n\nأعرف كل شيء في هذا الموقع: النبذة، 5 مشاريع مميزة، 6 مجالات مهارات، التعليم، التواصل، والمزيد.\n\nاضغط سؤالاً مقترحاً أدناه، أو اسأل: \"بماذا يمكنك مساعدتي؟\"';
  }

  @override
  String get typeMessage => 'اكتب رسالتك هنا...';

  @override
  String get somethingWentWrong => 'عذراً، حدث خطأ. حاول مرة أخرى.';

  @override
  String get emptyQuestion => 'اكتب سؤالك وسأساعدك فوراً.';

  @override
  String get year => 'السنة';

  @override
  String get description => 'الوصف';

  @override
  String get accreditedBy => 'معتمد من';

  @override
  String get date => 'التاريخ';

  @override
  String get roleTag => 'مهندس Flutter متوسط';
}
