import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'project_details_screen.dart';
import 'ai_chat_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'widgets/brand_contact_icon.dart';
import 'widgets/portfolio_background.dart';
import 'data/portfolio_content.dart';
import 'data/portfolio_profile_content.dart';
import 'services/portfolio_knowledge.dart';
import 'core/locale_scope.dart';
import 'generated/l10n/app_localizations.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with TickerProviderStateMixin {
  AppLocalizations get l10n => AppLocalizations.of(context);
  Locale get appLocale => LocaleScope.of(context).locale;

  late AnimationController _controller;
  final Map<int, bool> hoveredItems = {};
  String displayedName = "";
  int currentLetterIndex = 0;
  Timer? _letterAnimationTimer;

  final ScrollController _scrollController = ScrollController();
  final aboutKey = GlobalKey();
  final educationKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  final spacing = 30.0;
  final dotSize = 2.0;
  final waveHeight = 20.0;
  final frequency = 0.02;

  static const contacts = [
    {
      'icon': FontAwesomeIcons.phone,
      'label': 'Phone',
      'value': '+971 58 915 4605',
      'url': 'tel:+971589154605',
    },
    {
      'icon': FontAwesomeIcons.envelope,
      'label': 'Email',
      'value': 'ahmed96it96@gmail.com',
      'url': 'mailto:ahmed96it96@gmail.com',
    },
    {
      'brand': 'github',
      'label': 'GitHub',
      'value': 'github.com/ahmedehab96-c',
      'url': 'https://github.com/ahmedehab96-c',
    },
    {
      'brand': 'linkedin',
      'label': 'LinkedIn',
      'value': 'Ahmed Ehab',
      'url': 'https://www.linkedin.com/in/ahmed-ehab-ba8a63285',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();

    // Start letter-by-letter animation
    _startLetterAnimation();

    // Add delay to start animations
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _startLetterAnimation() {
    _letterAnimationTimer?.cancel();
    const fullName = "AHMED EHAB MOHAMMED";
    _letterAnimationTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mounted) {
        if (currentLetterIndex < fullName.length) {
          setState(() {
            displayedName = fullName.substring(0, currentLetterIndex + 1);
            currentLetterIndex++;
          });
        } else {
          // Reset after showing full name for 3 seconds
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                displayedName = "";
                currentLetterIndex = 0;
              });
            }
          });
          timer.cancel();
          // Restart animation after 2 seconds
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              _startLetterAnimation();
            }
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _letterAnimationTimer?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void _openAssistant() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AIChatScreen()),
    );
  }

  Widget _buildLanguageToggle({bool compact = false}) {
    final controller = LocaleScope.of(context);
    return TextButton(
      onPressed: controller.toggle,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF0099FF),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 10 : 14,
          vertical: compact ? 6 : 8,
        ),
      ),
      child: Text(
        l10n.languageToggle,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: compact ? 13 : 14,
        ),
      ),
    );
  }

  String _contactLabel(String key) {
    switch (key) {
      case 'Phone':
        return l10n.phone;
      case 'Email':
        return l10n.email;
      case 'GitHub':
        return 'GitHub';
      case 'LinkedIn':
        return 'LinkedIn';
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAssistant,
        backgroundColor: const Color(0xFF0099FF),
        foregroundColor: Colors.white,
        icon: const FaIcon(FontAwesomeIcons.robot, size: 20),
        label: Text(
          l10n.navAI,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      drawer: MediaQuery.of(context).size.width < 600
          ? Drawer(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(color: Colors.blueAccent),
                      child: Text(
                        l10n.navNavigation,
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(l10n.navAbout),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToKey(aboutKey);
                      },
                    ),
                    ListTile(
                      title: Text(l10n.navEducation),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToKey(educationKey);
                      },
                    ),
                    ListTile(
                      title: Text(l10n.navSkills),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToKey(skillsKey);
                      },
                    ),
                    ListTile(
                      title: Text(l10n.navProjects),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToKey(projectsKey);
                      },
                    ),
                    ListTile(
                      title: Text(l10n.navContact),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToKey(contactKey);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const FaIcon(
                        FontAwesomeIcons.robot,
                        color: Color(0xFF0099FF),
                        size: 20,
                      ),
                      title: Text(l10n.navAI),
                      onTap: () {
                        Navigator.pop(context);
                        _openAssistant();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.language, color: Color(0xFF0099FF)),
                      title: Text(l10n.languageToggle),
                      onTap: () {
                        LocaleScope.of(context).toggle();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: PortfolioBackground(animation: _controller),
              ),
              // Content
              SafeArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      minWidth: constraints.maxWidth,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildNavigationBar(),
                        _buildHeader(),
                        Container(key: aboutKey, child: _buildAbout()),
                        Container(key: educationKey, child: _buildEducation()),
                        _buildSkills(),
                        _buildProjects(),
                        _buildContact(),
                      _buildResumeButton(),
                      _buildAIChatButton(),
                      _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfilePhoto(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF0099FF), Color(0xFF7C3AED), Color(0xFF00B4D8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0099FF).withValues(alpha: 0.45),
            blurRadius: 36,
            spreadRadius: 4,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: ColoredBox(
          color: const Color(0xFF020617),
          child: Image.asset(
            'assets/images/ahmed.jpg',
            fit: BoxFit.contain,
            width: size - 6,
            height: size - 6,
            alignment: Alignment.center,
            errorBuilder: (_, __, ___) => SizedBox(
              width: size - 6,
              height: size - 6,
              child: Icon(Icons.person, size: size * 0.35, color: Colors.white38),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF0099FF), Color(0xFF00D4FF)],
          ).createShader(bounds),
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white54,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {String? subtitle}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 4,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0099FF), Color(0xFF7C3AED)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: isSmall ? 22 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: isSmall ? 14 : 16,
                    color: Colors.white60,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final isSmall = constraints.maxWidth < 600;
        final photoSize = isDesktop ? 420.0 : isSmall ? 300.0 : 360.0;

        final badge = FadeInDown(
          duration: const Duration(milliseconds: 900),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0099FF), Color(0xFF7C3AED)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0099FF).withValues(alpha: 0.4),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FaIcon(FontAwesomeIcons.flutter, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  PortfolioProfileContent.role(appLocale),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: isSmall ? 14 : 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );

        final nameText = FadeInLeft(
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 200),
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: const Color(0xFF0099FF),
            period: const Duration(seconds: 3),
            child: Text(
              displayedName,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: isSmall ? 34 : isDesktop ? 54 : 44,
                color: Colors.white,
                letterSpacing: 1.5,
                height: 1.15,
              ),
            ),
          ),
        );

        final tagline = FadeInLeft(
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 400),
          child: Text(
            l10n.heroTagline,
            style: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.w400,
              height: 1.7,
              fontSize: isSmall ? 14 : 17,
            ),
          ),
        );

        final stats = FadeInUp(
          duration: const Duration(milliseconds: 900),
          delay: const Duration(milliseconds: 500),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: isDesktop ? MainAxisSize.min : MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(PortfolioKnowledge.yearsOfExperience, l10n.yearsExp),
                Container(width: 1, height: 40, color: Colors.white12),
                _buildStatItem("10+", l10n.statProjects),
                Container(width: 1, height: 40, color: Colors.white12),
                _buildStatItem("6+", l10n.statTechnologies),
              ],
            ),
          ),
        );

        final ctaButtons = FadeInUp(
          duration: const Duration(milliseconds: 900),
          delay: const Duration(milliseconds: 650),
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0099FF), Color(0xFF0077CC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0099FF).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () => _scrollToKey(projectsKey),
                  icon: const FaIcon(FontAwesomeIcons.briefcase, size: 18),
                  label: Text(
                    l10n.viewProjects,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _scrollToKey(contactKey),
                icon: const FaIcon(FontAwesomeIcons.envelope, size: 16),
                label: Text(
                  l10n.contactMe,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(
                    color: const Color(0xFF0099FF).withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ],
          ),
        );

        final textColumn = Column(
          crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            badge,
            const SizedBox(height: 20),
            nameText,
            const SizedBox(height: 16),
            tagline,
            const SizedBox(height: 28),
            stats,
            const SizedBox(height: 28),
            ctaButtons,
          ],
        );

        if (isDesktop) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 72),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: textColumn),
                const SizedBox(width: 48),
                Expanded(
                  flex: 4,
                  child: FadeIn(
                    duration: const Duration(milliseconds: 1200),
                    delay: const Duration(milliseconds: 300),
                    child: Center(child: _buildProfilePhoto(photoSize)),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 20 : 32,
            vertical: isSmall ? 36 : 48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: _buildProfilePhoto(photoSize),
              ),
              const SizedBox(height: 32),
              textColumn,
            ],
          ),
        );
      },
    );
  }

  Widget _buildAbout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;
        final pad = isSmall ? 20.0 : 32.0;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 8),
          child: FadeInUp(
            duration: const Duration(milliseconds: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(l10n.aboutMe),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0A1929).withValues(alpha: 0.9),
                        const Color(0xFF0D1F35).withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF0099FF).withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PortfolioProfileContent.aboutParagraph1(appLocale),
                        style: TextStyle(
                          fontSize: isSmall ? 15 : 17,
                          color: Colors.white70,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        PortfolioProfileContent.aboutParagraph2(appLocale),
                        style: TextStyle(
                          fontSize: isSmall ? 15 : 17,
                          color: Colors.white70,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: PortfolioProfileContent.aboutHighlights(appLocale)
                            .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0099FF).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF0099FF).withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: Color(0xFF0099FF),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEducation() {
    final entries = PortfolioProfileContent.educationEntries(appLocale);
    final icons = [
      FontAwesomeIcons.graduationCap,
      FontAwesomeIcons.flutter,
      FontAwesomeIcons.brain,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Container(
          padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(l10n.educationTitle),
              const SizedBox(height: 24),
              ...List.generate(entries.length, (index) {
                final entry = entries[index];
                final icon = icons[index];
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 20),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: 200 + index * 200),
                    child: Hover3dWrapper(
                      maxTilt: 0.12,
                      perspective: 0.001,
                      scale: 1.02,
                      glowColor: entry.color,
                      child: _buildEducationCard(
                        icon: icon,
                        iconColor: entry.color,
                        title: entry.title(appLocale),
                        subtitle: entry.subtitle(appLocale),
                        details: entry
                            .details(appLocale)
                            .map((d) => (d.$1, d.$2, entry.color))
                            .toList(),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEducationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required List<(String, String, Color)> details,
  }) {
    return Card(
      elevation: 12,
      shadowColor: iconColor.withValues(alpha: 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: iconColor.withValues(alpha: 50),
          width: 2,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0A1929),
              Color(0xFF1A1F3A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: iconColor.withValues(alpha: 0.6),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: iconColor.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: FaIcon(
                        icon,
                        color: iconColor,
                        size: 28,
                        semanticLabel: title,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withValues(alpha: 220),
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ...details.map((detail) {
                final (label, value, color) = detail;
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (label != l10n.description)
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 180),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      if (label != l10n.description) const SizedBox(height: 4),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: label == l10n.description ? 14 : 14,
                          color: color,
                          fontWeight: label == l10n.description ? FontWeight.normal : FontWeight.w600,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkills() {
    final skills = PortfolioProfileContent.skillCategories(appLocale);

    return Container(
      padding: const EdgeInsets.all(24.0),
      key: skillsKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            l10n.skillsTitle,
            subtitle: l10n.skillsSubtitle,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: skills.asMap().entries.map((entry) {
                  final index = entry.key;
                  final category = entry.value;
                  final hoverKey = 2000 + index;
                  final isHovered = hoveredItems[hoverKey] == true;

                  final cardWidget = AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: isHovered
                        ? (Matrix4.identity()..translateByVector3(Vector3(0, -6, 0)))
                        : Matrix4.identity(),
                    child: SizedBox(
                      width: constraints.maxWidth > 600
                          ? (constraints.maxWidth / 2) - 36
                          : constraints.maxWidth,
                      child: Card(
                        elevation: isHovered ? 10 : 4,
                        shadowColor: category.color.withValues(alpha: 0.25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isHovered ? category.color : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF0A1929),
                                const Color(0xFF0A1929).withValues(alpha: 0.9),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: category.color.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: FaIcon(
                                        category.icon,
                                        color: category.color,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        category.category(appLocale),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: category.color,
                                              fontSize: 20,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                ...category.skills(appLocale).map(
                                  (skill) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.arrow_right,
                                          color: category.color.withValues(alpha: 0.8),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            skill,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: Colors.white.withValues(alpha: 0.9),
                                                  height: 1.5,
                                                ),
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );

                  return MouseRegion(
                    onEnter: (_) => setState(() => hoveredItems[hoverKey] = true),
                    onExit: (_) => setState(() => hoveredItems[hoverKey] = false),
                    child: cardWidget,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjects() {
    const projects = PortfolioContent.featuredProjects;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final pad = isMobile ? 16.0 : 32.0;
        final columns = constraints.maxWidth >= 1200
            ? 3
            : constraints.maxWidth >= 900
                ? 2
                : 1;
        final cardWidth = columns == 1
            ? constraints.maxWidth - pad * 2
            : (constraints.maxWidth - pad * 2 - (columns - 1) * 24) / columns;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 48),
          key: projectsKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(
                l10n.featuredProjects,
                subtitle: l10n.featuredProjectsSubtitle,
              ),
              const SizedBox(height: 36),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: projects.asMap().entries.map((entry) {
                  return SizedBox(
                    width: cardWidth,
                    child: FadeInUp(
                      duration: Duration(milliseconds: 500 + entry.key * 100),
                      child: _buildModernProjectCard(entry.key, entry.value),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModernProjectCard(int index, PortfolioProject project) {
    final primary = Theme.of(context).colorScheme.primary;
    final isHovered = hoveredItems[index] == true;
    final visibleTech = project.tech.take(4).toList();
    final extraTech = project.tech.length - visibleTech.length;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredItems[index] = true),
      onExit: (_) => setState(() => hoveredItems[index] = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: isHovered
            ? (Matrix4.identity()..translateByVector3(Vector3(0, -6, 0)))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0F2744).withValues(alpha: 0.95),
              const Color(0xFF0A1929).withValues(alpha: 0.98),
            ],
          ),
          border: Border.all(
            color: isHovered
                ? primary.withValues(alpha: 0.55)
                : Colors.white.withValues(alpha: 0.08),
            width: isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? primary.withValues(alpha: 0.18)
                  : Colors.black.withValues(alpha: 0.25),
              blurRadius: isHovered ? 24 : 12,
              offset: Offset(0, isHovered ? 10 : 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _openProjectDetails(project),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Image.asset(
                        project.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFF0A1929),
                          child: const Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 48,
                              color: Colors.white24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: Text(
                          project.isGithubPrivate ? l10n.privateRepo : l10n.openSource,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primary,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        project.localizedCardDescription(appLocale),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...visibleTech.map(
                            (t) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: primary.withValues(alpha: 0.28),
                                ),
                              ),
                              child: Text(
                                t,
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          if (extraTech > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '+$extraTech more',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () => _openProjectDetails(project),
                              icon: const Icon(Icons.arrow_outward, size: 16),
                              label: Text(
                                l10n.viewProject,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          if (project.githubUrl != null) ...[
                            const SizedBox(width: 10),
                            IconButton.filledTonal(
                              onPressed: () => _launchUrl(project.githubUrl!),
                              icon: FaIcon(
                                FontAwesomeIcons.github,
                                size: 16,
                                color: project.isGithubPrivate
                                    ? Colors.white54
                                    : primary,
                              ),
                              tooltip: project.isGithubPrivate
                                  ? l10n.privateOnGithub
                                  : l10n.viewOnGithub,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withValues(alpha: 0.08),
                                padding: const EdgeInsets.all(12),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openProjectDetails(PortfolioProject project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDetailsScreen(project: project),
      ),
    );
  }

  Widget _buildContact() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final contactWidth = constraints.maxWidth > 900
            ? (constraints.maxWidth / 2) - 32
            : constraints.maxWidth;

        return Container(
          padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
          key: contactKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSectionTitle(
                  l10n.getInTouch,
                  subtitle: l10n.getInTouchSubtitle,
                ),
                SizedBox(height: isSmallScreen ? 24 : 32),
                AnimationLimiter(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contacts.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: isSmallScreen ? 12 : 20,
                    ),
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      final contactItemKey = 3000 + index;
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1200),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 1200),
                            child: Hover3dWrapper(
                              maxTilt: 0.1,
                              perspective: 0.001,
                              scale: 1.015,
                              glowColor: Theme.of(context).colorScheme.primary,
                              onHoverChanged: (hovering) =>
                                  setState(() => hoveredItems[contactItemKey] = hovering),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    if (!mounted) return;
                                    final messenger = ScaffoldMessenger.of(context);
                                    try {
                                      final url =
                                          Uri.parse(contact['url'] as String);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        if (!mounted) return;
                                        messenger.showSnackBar(
                                          SnackBar(content: Text(l10n.couldNotOpenLink)),
                                        );
                                      }
                                    } catch (e) {
                                      if (!mounted) return;
                                      messenger.showSnackBar(
                                        SnackBar(content: Text(l10n.errorGeneric(e.toString()))),
                                      );
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: contactWidth,
                                    padding:
                                        EdgeInsets.all(isSmallScreen ? 16 : 20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          const Color(0xFF1A1A1A)
                                              .withValues(alpha: 0.8),
                                          const Color(0xFF000B14)
                                              .withValues(alpha: 0.9),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: 0.1),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(
                                              isSmallScreen ? 8 : 12),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withValues(alpha: 0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: BrandContactIcon(
                                            brand: contact['brand'] as String?,
                                            icon: contact['icon'] as IconData?,
                                            size: isSmallScreen ? 20 : 24,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        SizedBox(width: isSmallScreen ? 12 : 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _contactLabel(contact['label'] as String),
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize:
                                                      isSmallScreen ? 12 : 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                contact['value'] as String,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontSize:
                                                      isSmallScreen ? 14 : 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: isSmallScreen ? 14 : 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        );
      },
    );
  }

  Widget _buildResumeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0099FF), Color(0xFF0077CC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0099FF).withValues(alpha: 0.45),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            icon: const FaIcon(FontAwesomeIcons.filePdf, size: 22),
            label: Text(
              l10n.downloadCv,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            onPressed: () async {
              try {
                final url = Uri.parse(PortfolioKnowledge.cvUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.couldNotOpenLink)),
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.errorGeneric(e.toString()))),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAIChatButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: FadeInUp(
        duration: const Duration(milliseconds: 1200),
        delay: const Duration(milliseconds: 400),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2D1B69),
                Color(0xFF1A1F3A),
                Color(0xFF0099FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0099FF).withValues(alpha: 40),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ElevatedButton.icon(
            icon: const FaIcon(FontAwesomeIcons.robot, size: 24),
            label: Text(
              l10n.chatWithAI,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            onPressed: _openAssistant,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    final currentYear = DateTime.now().year;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 8),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 20),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            "© $currentYear Ahmed's Portfolio",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.builtWith,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Container(
        constraints: const BoxConstraints(maxHeight: 56),
        child: AppBar(
          backgroundColor: const Color(0xFF050D14),
          title: const SizedBox(),
          iconTheme: const IconThemeData(
            color: Color(0xFF0099FF),
          ),
          elevation: 0,
          actions: [_buildLanguageToggle(compact: true)],
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 80),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF0099FF), Color(0xFF7C3AED)],
            ).createShader(bounds),
            child: const Text(
              "Ahmed Ehab",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Row(
            children: [
              _navButton(l10n.navAbout, aboutKey),
              _navButton(l10n.navEducation, educationKey),
              _navButton(l10n.navSkills, skillsKey),
              _navButton(l10n.navProjects, projectsKey),
              _navButton(l10n.navContact, contactKey),
              _buildLanguageToggle(),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF0099FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _openAssistant,
                  icon: const FaIcon(FontAwesomeIcons.robot, size: 16),
                  label: Text(
                    l10n.navAIShort,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _navButton(String label, GlobalKey key) {
  return Builder(
    builder: (context) {
      final isDesktop = kIsWeb || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux;
      
      final button = TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF0A1929),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: const Color(0xFF0099FF).withValues(alpha: 50),
              width: 1,
            ),
          ),
        ),
        onPressed: () {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        },
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      );
      
      if (isDesktop) {
        return Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            maxHeight: 48,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: button,
          ),
        );
      } else {
        return Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            maxHeight: 48,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: button,
        );
      }
    },
  );
}

class Hover3dWrapper extends StatefulWidget {
  final Widget child;
  final double maxTilt;
  final double perspective;
  final double scale;
  final Color glowColor;
  final ValueChanged<bool>? onHoverChanged;

  const Hover3dWrapper({
    super.key,
    required this.child,
    this.maxTilt = 0.12,
    this.perspective = 0.001,
    this.scale = 1.02,
    this.glowColor = const Color(0xFF0099FF),
    this.onHoverChanged,
  });

  @override
  State<Hover3dWrapper> createState() => _Hover3dWrapperState();
}

class _Hover3dWrapperState extends State<Hover3dWrapper> {
  double _tiltX = 0;
  double _tiltY = 0;
  bool _hovering = false;

  void _handlePointer(PointerEvent event) {
    final renderBox = context.findRenderObject();
    if (renderBox is! RenderBox) return;

    final size = renderBox.size;
    final localPos = renderBox.globalToLocal(event.position);
    final normX = ((localPos.dx / size.width) - 0.5) * 2; // -1..1
    final normY = ((localPos.dy / size.height) - 0.5) * 2; // -1..1

    setState(() {
      _tiltY = normX * widget.maxTilt;
      _tiltX = -normY * widget.maxTilt;
      _hovering = true;
    });

    widget.onHoverChanged?.call(true);
  }

  void _resetTilt() {
    setState(() {
      _tiltX = 0;
      _tiltY = 0;
      _hovering = false;
    });
    widget.onHoverChanged?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    final scaleValue = _hovering ? widget.scale : 1.0;
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, widget.perspective)
      ..rotateX(_tiltX)
      ..rotateY(_tiltY)
      ..scaleByVector3(Vector3(scaleValue, scaleValue, 1.0));

    return MouseRegion(
      onHover: _handlePointer,
      onExit: (_) => _resetTilt(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: widget.glowColor.withValues(
                alpha: _hovering ? 40 : 16,
              ),
              blurRadius: _hovering ? 28 : 14,
              spreadRadius: _hovering ? 6 : 2,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Transform(
          alignment: Alignment.center,
          transform: matrix,
          child: widget.child,
        ),
      ),
    );
  }
}

