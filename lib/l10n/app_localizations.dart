import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ahmed\'s Portfolio'**
  String get appTitle;

  /// No description provided for @navNavigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navNavigation;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @navEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get navEducation;

  /// No description provided for @navSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get navSkills;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @navAI.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get navAI;

  /// No description provided for @navAIShort.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get navAIShort;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get languageToggle;

  /// No description provided for @heroTagline.
  ///
  /// In en, this message translates to:
  /// **'Crafting beautiful & functional mobile experiences\nwith a focus on clean architecture and great UX.'**
  String get heroTagline;

  /// No description provided for @yearsExp.
  ///
  /// In en, this message translates to:
  /// **'Years Exp.'**
  String get yearsExp;

  /// No description provided for @statProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get statProjects;

  /// No description provided for @statTechnologies.
  ///
  /// In en, this message translates to:
  /// **'Technologies'**
  String get statTechnologies;

  /// No description provided for @viewProjects.
  ///
  /// In en, this message translates to:
  /// **'View Projects'**
  String get viewProjects;

  /// No description provided for @contactMe.
  ///
  /// In en, this message translates to:
  /// **'Contact Me'**
  String get contactMe;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutMe;

  /// No description provided for @educationTitle.
  ///
  /// In en, this message translates to:
  /// **'Education & Certifications'**
  String get educationTitle;

  /// No description provided for @skillsTitle.
  ///
  /// In en, this message translates to:
  /// **'Skills & Expertise'**
  String get skillsTitle;

  /// No description provided for @skillsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Technologies and tools I specialize in:'**
  String get skillsSubtitle;

  /// No description provided for @featuredProjects.
  ///
  /// In en, this message translates to:
  /// **'Featured Projects'**
  String get featuredProjects;

  /// No description provided for @featuredProjectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Selected apps and platforms I designed and built.'**
  String get featuredProjectsSubtitle;

  /// No description provided for @privateRepo.
  ///
  /// In en, this message translates to:
  /// **'Private repo'**
  String get privateRepo;

  /// No description provided for @openSource.
  ///
  /// In en, this message translates to:
  /// **'Open source'**
  String get openSource;

  /// No description provided for @viewProject.
  ///
  /// In en, this message translates to:
  /// **'View project'**
  String get viewProject;

  /// No description provided for @getInTouch.
  ///
  /// In en, this message translates to:
  /// **'Get in Touch'**
  String get getInTouch;

  /// No description provided for @getInTouchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open to work — feel free to reach out anytime.'**
  String get getInTouchSubtitle;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @downloadCv.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get downloadCv;

  /// No description provided for @chatWithAI.
  ///
  /// In en, this message translates to:
  /// **'Chat with AI Assistant'**
  String get chatWithAI;

  /// No description provided for @builtWith.
  ///
  /// In en, this message translates to:
  /// **'Built with Flutter & ❤️'**
  String get builtWith;

  /// No description provided for @couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link'**
  String get couldNotOpenLink;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorGeneric(String message);

  /// No description provided for @techStack.
  ///
  /// In en, this message translates to:
  /// **'Tech Stack'**
  String get techStack;

  /// No description provided for @viewReadmeGitHub.
  ///
  /// In en, this message translates to:
  /// **'View README on GitHub'**
  String get viewReadmeGitHub;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @topics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topics;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @screenshotSoon.
  ///
  /// In en, this message translates to:
  /// **'Screenshot coming soon'**
  String get screenshotSoon;

  /// No description provided for @viewFull.
  ///
  /// In en, this message translates to:
  /// **'View full'**
  String get viewFull;

  /// No description provided for @pageOf.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String pageOf(int current, int total);

  /// No description provided for @privateRepoNotice.
  ///
  /// In en, this message translates to:
  /// **'Source code is hosted in a private GitHub repository. Contact Ahmed for access.'**
  String get privateRepoNotice;

  /// No description provided for @couldNotOpenGithub.
  ///
  /// In en, this message translates to:
  /// **'Could not open GitHub'**
  String get couldNotOpenGithub;

  /// No description provided for @privateRepoLabel.
  ///
  /// In en, this message translates to:
  /// **'Private Repo'**
  String get privateRepoLabel;

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @privateOnGithub.
  ///
  /// In en, this message translates to:
  /// **'Private on GitHub'**
  String get privateOnGithub;

  /// No description provided for @viewOnGithub.
  ///
  /// In en, this message translates to:
  /// **'View on GitHub'**
  String get viewOnGithub;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// No description provided for @suggestedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Suggested questions ({count})'**
  String suggestedQuestions(int count);

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello! I am Ahmed Ehab\'s portfolio AI assistant.\n\nData version: {version}\n\nI know everything on this site: About, 5 featured projects, 6 skill areas, education, contact, and more.\n\nTap a suggested question below, or ask: \"What can you help me with?\"'**
  String welcomeMessage(String version);

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message here...'**
  String get typeMessage;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Sorry, something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @emptyQuestion.
  ///
  /// In en, this message translates to:
  /// **'Type your question and I will help you right away.'**
  String get emptyQuestion;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @accreditedBy.
  ///
  /// In en, this message translates to:
  /// **'Accredited by'**
  String get accreditedBy;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @roleTag.
  ///
  /// In en, this message translates to:
  /// **'Mid-Level Flutter Engineer'**
  String get roleTag;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
