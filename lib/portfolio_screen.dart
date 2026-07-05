import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'project_details_screen.dart';
import 'ai_chat_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'widgets/brand_contact_icon.dart';
import 'widgets/deferred_asset_image.dart';
import 'widgets/glass_panel.dart';
import 'widgets/hero_stats_strip.dart';
import 'widgets/nav_pill.dart';
import 'widgets/portfolio_background.dart';
import 'widgets/projects_bento_grid.dart';
import 'widgets/section_block.dart';
import 'data/portfolio_content.dart';
import 'data/portfolio_profile_content.dart';
import 'services/portfolio_knowledge.dart';
import 'theme/portfolio_palette.dart';
import 'ui_strings.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with TickerProviderStateMixin {
  static const double _navDrawerBreakpoint = 1280;

  late AnimationController _controller;
  final bool _backgroundAnimate = false;
  final Map<int, bool> hoveredItems = {};
  String displayedName = "";
  int currentLetterIndex = 0;
  bool _nameErasing = false;
  Timer? _letterAnimationTimer;

  static const _heroFullName = 'AHMED EHAB MOHAMMED';
  static const _nameTypeMs = 42;
  static const _nameEraseMs = 28;
  static const _nameHoldMs = 450;
  static const _namePauseMs = 220;

  final ScrollController _scrollController = ScrollController();
  final aboutKey = GlobalKey();
  final educationKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  int _activeNavIndex = 0;
  final _sectionKeys = <GlobalKey>[];

  static const _stickyNavHeight = 72.0;

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

  PortfolioPalette get palette => context.palette;

  @override
  void initState() {
    super.initState();
    _sectionKeys.addAll([aboutKey, educationKey, skillsKey, projectsKey, contactKey]);
    _scrollController.addListener(_updateActiveSection);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: kIsWeb ? 32 : 24),
    );

    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
        _updateActiveSection();
      });
    } else {
      _controller.repeat();
    }
    _startLetterAnimation();
  }

  void _startLetterAnimation() {
    _letterAnimationTimer?.cancel();

    void tick() {
      if (!mounted) return;

      if (!_nameErasing) {
        if (currentLetterIndex < _heroFullName.length) {
          setState(() {
            currentLetterIndex++;
            displayedName = _heroFullName.substring(0, currentLetterIndex);
          });
          _letterAnimationTimer = Timer(
            const Duration(milliseconds: _nameTypeMs),
            tick,
          );
          return;
        }

        _letterAnimationTimer = Timer(
          const Duration(milliseconds: _nameHoldMs),
          () {
            if (!mounted) return;
            setState(() => _nameErasing = true);
            tick();
          },
        );
        return;
      }

      if (currentLetterIndex > 0) {
        setState(() {
          currentLetterIndex--;
          displayedName = _heroFullName.substring(0, currentLetterIndex);
        });
        _letterAnimationTimer = Timer(
          const Duration(milliseconds: _nameEraseMs),
          tick,
        );
        return;
      }

      setState(() {
        displayedName = "";
        _nameErasing = false;
      });
      _letterAnimationTimer = Timer(
        const Duration(milliseconds: _namePauseMs),
        tick,
      );
    }

    tick();
  }

  void _updateActiveSection() {
    if (!_scrollController.hasClients) return;

    var active = 0;
    for (var i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject();
      if (box is! RenderBox || !box.hasSize) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= 160) {
        active = i;
        break;
      }
    }

    if (active != _activeNavIndex && mounted) {
      setState(() => _activeNavIndex = active);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _letterAnimationTimer?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    if (index < 0 || index >= _sectionKeys.length) return;
    setState(() => _activeNavIndex = index);
    _scrollToKey(_sectionKeys[index]);
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 1050),
        curve: Curves.easeInOutCubicEmphasized,
        alignment: 0.07,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      ).whenComplete(() {
        if (mounted) _updateActiveSection();
      });
    }
  }

  void _openAssistant() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AIChatScreen()),
    );
  }

  String _contactLabel(String key) {
    switch (key) {
      case 'Phone':
        return UiStrings.phone;
      case 'Email':
        return UiStrings.email;
      case 'GitHub':
        return 'GitHub';
      case 'LinkedIn':
        return 'LinkedIn';
      default:
        return key;
    }
  }

  Widget _reveal(Widget child, {Duration delay = Duration.zero}) => FadeInUp(
        duration: const Duration(milliseconds: kIsWeb ? 520 : 800),
        delay: delay,
        from: 20,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAssistant,
        backgroundColor: PortfolioPalette.accent,
        foregroundColor: Colors.white,
        icon: const FaIcon(FontAwesomeIcons.robot, size: 20),
        label: const Text(
          UiStrings.navAI,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      drawer: MediaQuery.sizeOf(context).width < _navDrawerBreakpoint
          ? Drawer(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: PortfolioPalette.accentGradient,
                      ),
                      child: Text(
                        UiStrings.navNavigation,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text(UiStrings.navAbout),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection(0);
                      },
                    ),
                    ListTile(
                      title: const Text(UiStrings.navEducation),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection(1);
                      },
                    ),
                    ListTile(
                      title: const Text(UiStrings.navSkills),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection(2);
                      },
                    ),
                    ListTile(
                      title: const Text(UiStrings.navProjects),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection(3);
                      },
                    ),
                    ListTile(
                      title: const Text(UiStrings.navContact),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection(4);
                      },
                    ),
                    ListTile(
                      leading: const FaIcon(
                        FontAwesomeIcons.robot,
                        color: Color(0xFF0099FF),
                        size: 20,
                      ),
                      title: const Text(UiStrings.navAI),
                      onTap: () {
                        Navigator.pop(context);
                        _openAssistant();
                      },
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final useDrawerNav = constraints.maxWidth < _navDrawerBreakpoint;

          return Stack(
            children: [
              Positioned.fill(
                child: PortfolioBackground(
                  animation: _controller,
                  palette: palette,
                  animate: _backgroundAnimate,
                ),
              ),
              SafeArea(
                top: !kIsWeb,
                bottom: false,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    top: useDrawerNav ? 0 : _stickyNavHeight,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      minWidth: constraints.maxWidth,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (useDrawerNav) _buildNavigationBar(),
                        _buildHeader(),
                        _buildAbout(),
                        _buildEducation(),
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
              if (!useDrawerNav)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    bottom: false,
                    child: _buildNavigationBar(),
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
        gradient: PortfolioPalette.photoRingGradient,
        boxShadow: palette.accentGlow(alpha: 0.35, blur: 40),
      ),
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: ColoredBox(
          color: palette.bgDeep,
          child: DeferredAssetImage(
            asset: 'assets/images/ahmed.jpg',
            fit: BoxFit.contain,
            width: size - 6,
            height: size - 6,
            alignment: Alignment.center,
            placeholderColor: palette.bgDeep,
            borderRadius: BorderRadius.circular(25),
            errorBuilder: (_, __, ___) => SizedBox(
              width: size - 6,
              height: size - 6,
              child: Icon(Icons.person, size: size * 0.35, color: palette.textMuted),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {String? subtitle}) {
    return SectionHeader(title: title, subtitle: subtitle);
  }

  Widget _buildHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final isSmall = constraints.maxWidth < 600;
        final photoSize = isDesktop
            ? (kIsWeb ? 360.0 : 420.0)
            : isSmall
                ? (kIsWeb ? 220.0 : 300.0)
                : (kIsWeb ? 280.0 : 360.0);

        final badge = Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            gradient: PortfolioPalette.accentGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: palette.accentGlow(alpha: 0.32, blur: 18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FaIcon(FontAwesomeIcons.flutter, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                PortfolioProfileContent.role(const Locale('en')),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: isSmall ? 14 : 16,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );

        final nameStyle = TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: isSmall ? 34 : isDesktop ? 54 : 44,
          color: palette.textPrimary,
          letterSpacing: 1.5,
          height: 1.15,
        );

        final showCursor = !_nameErasing &&
            currentLetterIndex < _heroFullName.length;
        final nameText = AnimatedOpacity(
          opacity: displayedName.isEmpty ? 0 : 1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Shimmer.fromColors(
            enabled: displayedName.isNotEmpty,
            baseColor: palette.textPrimary.withValues(alpha: 0.88),
            highlightColor: PortfolioPalette.accentBright,
            period: const Duration(milliseconds: 1800),
            child: Text(
              displayedName.isEmpty ? '\u00A0' : displayedName,
              maxLines: 2,
              textAlign: isDesktop ? TextAlign.start : TextAlign.center,
              style: nameStyle,
            ),
          ),
        );

        final cursorHeight = isSmall ? 28.0 : isDesktop ? 48.0 : 40.0;
        final nameWithCursor = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(child: nameText),
            if (showCursor)
              Padding(
                padding: EdgeInsets.only(bottom: isSmall ? 4 : 6, left: 2),
                child: _BlinkingCursor(
                  color: PortfolioPalette.accent,
                  height: cursorHeight,
                ),
              ),
          ],
        );

        final tagline = Text(
          UiStrings.heroTagline,
          style: TextStyle(
            color: palette.textSecondary,
            fontWeight: FontWeight.w400,
            height: 1.7,
            fontSize: isSmall ? 14 : 17,
          ),
        );

        const stats = HeroStatsStrip(
          items: [
            (
              value: PortfolioKnowledge.yearsOfExperience,
              label: UiStrings.yearsExp,
              icon: FontAwesomeIcons.briefcase,
            ),
            (
              value: '10+',
              label: UiStrings.statProjects,
              icon: FontAwesomeIcons.folderOpen,
            ),
            (
              value: '6+',
              label: UiStrings.statTechnologies,
              icon: FontAwesomeIcons.code,
            ),
          ],
        );

        final ctaButtons = Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: PortfolioPalette.ctaGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: palette.accentGlow(alpha: 0.35, blur: 20),
              ),
              child: ElevatedButton.icon(
                onPressed: () => _scrollToSection(3),
                icon: const FaIcon(FontAwesomeIcons.briefcase, size: 18),
                label: const Text(
                  UiStrings.viewProjects,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
              onPressed: () => _scrollToSection(4),
              icon: const FaIcon(FontAwesomeIcons.envelope, size: 16),
              label: const Text(
                UiStrings.contactMe,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: palette.textPrimary,
                side: BorderSide(
                  color: palette.borderAccent,
                  width: 1.5,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        );

        final textColumn = Column(
          crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            revealItem(badge),
            const SizedBox(height: 16),
            revealItem(nameWithCursor, delay: const Duration(milliseconds: 70)),
            const SizedBox(height: 12),
            revealItem(tagline, delay: const Duration(milliseconds: 120)),
            const SizedBox(height: 20),
            stats,
            const SizedBox(height: 20),
            revealItem(ctaButtons, delay: const Duration(milliseconds: 220)),
          ],
        );

        final profilePhoto = Center(
          child: revealItem(
            _buildProfilePhoto(photoSize),
            delay: const Duration(milliseconds: 150),
          ),
        );

        if (isDesktop) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kIsWeb ? 32 : 40,
              vertical: kIsWeb ? 16 : 44,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: textColumn),
                const SizedBox(width: kIsWeb ? 32 : 48),
                Expanded(flex: 4, child: profilePhoto),
              ],
            ),
          );
        }

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 20 : 28,
            vertical: kIsWeb ? 12 : (isSmall ? 28 : 36),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: kIsWeb
                ? [
                    textColumn,
                    const SizedBox(height: 20),
                    profilePhoto,
                  ]
                : [
                    FadeIn(
                      duration: const Duration(milliseconds: 1000),
                      child: _buildProfilePhoto(photoSize),
                    ),
                    const SizedBox(height: 24),
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

        return SectionBlock(
          sectionKey: aboutKey,
          scrollController: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(UiStrings.aboutMe),
              const SizedBox(height: 18),
              GlassPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      PortfolioProfileContent.aboutParagraph1(const Locale('en')),
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 17,
                        color: palette.textSecondary,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      PortfolioProfileContent.aboutParagraph2(const Locale('en')),
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 17,
                        color: palette.textSecondary,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: PortfolioProfileContent.aboutHighlights(const Locale('en'))
                          .asMap()
                          .entries
                          .map((entry) => revealItem(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: PortfolioPalette.accent
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: palette.borderAccent,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    entry.value,
                                    style: const TextStyle(
                                      color: PortfolioPalette.accentBright,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                delay: Duration(milliseconds: 60 * entry.key),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEducation() {
    final entries = PortfolioProfileContent.educationEntries(const Locale('en'));
    final icons = [
      FontAwesomeIcons.graduationCap,
      FontAwesomeIcons.flutter,
      FontAwesomeIcons.brain,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SectionBlock(
          sectionKey: educationKey,
          scrollController: _scrollController,
          delay: const Duration(milliseconds: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(UiStrings.educationTitle),
              const SizedBox(height: 18),
              ...List.generate(entries.length, (index) {
                final entry = entries[index];
                final icon = icons[index];
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 14),
                  child: _reveal(
                    Hover3dWrapper(
                      maxTilt: 0.12,
                      perspective: 0.001,
                      scale: 1.02,
                      glowColor: entry.color,
                      child: _buildEducationCard(
                        icon: icon,
                        iconColor: entry.color,
                        title: entry.title,
                        subtitle: entry.subtitle,
                        details: entry.details
                            .map((d) => (d.$1, d.$2, entry.color))
                            .toList(),
                      ),
                    ),
                    delay: Duration(milliseconds: 80 * index),
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
          color: palette.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: palette.borderSubtle),
          boxShadow: palette.panelShadow,
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
                      color: palette.bgMid,
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: palette.textPrimary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 15,
                            color: palette.textSecondary,
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
                      if (label != UiStrings.description)
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            color: palette.textMuted,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      if (label != UiStrings.description) const SizedBox(height: 4),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: label == UiStrings.description ? 14 : 14,
                          color: color,
                          fontWeight: label == UiStrings.description ? FontWeight.normal : FontWeight.w600,
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
    final skills = PortfolioProfileContent.skillCategories(const Locale('en'));

    return SectionBlock(
      sectionKey: skillsKey,
      scrollController: _scrollController,
      delay: const Duration(milliseconds: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            UiStrings.skillsTitle,
            subtitle: UiStrings.skillsSubtitle,
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 18,
                runSpacing: 18,
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
                            color: palette.surface,
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
                                        category.category,
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
                                ...category.skills.map(
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
                                                  color: palette.textPrimary
                                                      .withValues(alpha: 0.92),
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
                    child: _reveal(
                      cardWidget,
                      delay: Duration(milliseconds: 70 * index),
                    ),
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
        final pad = isMobile ? 16.0 : 28.0;

        return SectionBlock(
          sectionKey: projectsKey,
          scrollController: _scrollController,
          delay: const Duration(milliseconds: 100),
          padding: EdgeInsets.fromLTRB(pad, 20, pad, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(
                UiStrings.featuredProjects,
                subtitle: UiStrings.featuredProjectsSubtitle,
              ),
              const SizedBox(height: 20),
              ProjectsBentoGrid(
                projects: projects,
                hoveredItems: hoveredItems,
                onHoverChanged: (index, hovering) {
                  setState(() => hoveredItems[index] = hovering);
                },
                onOpenProject: _openProjectDetails,
                onOpenGithub: (project) {
                  if (project.githubUrl != null) {
                    _launchUrl(project.githubUrl!);
                  }
                },
              ),
            ],
          ),
        );
      },
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

        return SectionBlock(
          sectionKey: contactKey,
          scrollController: _scrollController,
          delay: const Duration(milliseconds: 120),
          padding: EdgeInsets.fromLTRB(
            isSmallScreen ? 16 : 24,
            12,
            isSmallScreen ? 16 : 24,
            24,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSectionTitle(
                  UiStrings.getInTouch,
                  subtitle: UiStrings.getInTouchSubtitle,
                ),
                SizedBox(height: isSmallScreen ? 16 : 20),
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
                      final card = Hover3dWrapper(
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
                                    const SnackBar(content: Text(UiStrings.couldNotOpenLink)),
                                  );
                                }
                              } catch (e) {
                                if (!mounted) return;
                                messenger.showSnackBar(
                                  SnackBar(content: Text(UiStrings.errorGeneric(e.toString()))),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: contactWidth,
                              padding:
                                  EdgeInsets.all(isSmallScreen ? 16 : 20),
                              decoration: BoxDecoration(
                                color: palette.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: palette.borderAccent,
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
                                      color: palette.bgMid,
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
                                            color: palette.textSecondary,
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
                      );
                      if (kIsWeb) {
                        return _reveal(
                          card,
                          delay: Duration(milliseconds: 80 * index),
                        );
                      }
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1200),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 1200),
                            child: card,
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
      child: _reveal(
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: PortfolioPalette.ctaGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: palette.accentGlow(alpha: 0.38, blur: 24),
          ),
          child: ElevatedButton.icon(
            icon: const FaIcon(FontAwesomeIcons.filePdf, size: 22),
            label: const Text(
              UiStrings.downloadCv,
              style: TextStyle(
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
                      const SnackBar(content: Text(UiStrings.couldNotOpenLink)),
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(UiStrings.errorGeneric(e.toString()))),
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
        delay: const Duration(milliseconds: 140),
      ),
    );
  }

  Widget _buildAIChatButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: _reveal(
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: PortfolioPalette.aiGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: PortfolioPalette.violet.withValues(alpha: 0.35),
                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ElevatedButton.icon(
            icon: const FaIcon(FontAwesomeIcons.robot, size: 24),
            label: const Text(
              UiStrings.chatWithAI,
              style: TextStyle(
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
        delay: const Duration(milliseconds: 180),
      ),
    );
  }

  Widget _buildFooter() {
    final currentYear = DateTime.now().year;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: PortfolioPalette.accent.withValues(alpha: 0.06),
        border: Border(
          top: BorderSide(
            color: palette.borderAccent,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            "© $currentYear Ahmed's Portfolio",
            style: TextStyle(
              color: palette.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    const navItems = [
      UiStrings.navAbout,
      UiStrings.navEducation,
      UiStrings.navSkills,
      UiStrings.navProjects,
      UiStrings.navContact,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final useDrawerNav = constraints.maxWidth < _navDrawerBreakpoint;

        if (useDrawerNav) {
          return Container(
            constraints: const BoxConstraints(maxHeight: 56),
            child: AppBar(
              backgroundColor: palette.bgDeep.withValues(alpha: 0.92),
              title: const SizedBox.shrink(),
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: PortfolioPalette.accent,
              ),
              elevation: 0,
            ),
          );
        }

        return PortfolioNavBar(
          items: navItems,
          activeIndex: _activeNavIndex,
          onSelected: _scrollToSection,
          onOpenAi: _openAssistant,
        );
      },
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor({required this.color, this.height = 36});

  final Color color;
  final double height;

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.2, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Container(
        width: 3,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha: 0.55),
              blurRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
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
    this.glowColor = PortfolioPalette.accent,
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

