import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'project_details_screen.dart';
import 'ai_chat_screen.dart';
import 'widgets/fa_shim.dart';
import 'widgets/brand_contact_icon.dart';
import 'widgets/glass_panel.dart';
import 'widgets/hero_profile_visual.dart';
import 'widgets/hero_stats_strip.dart';
import 'widgets/nav_pill.dart';
import 'widgets/portfolio_background.dart';
import 'animations/motion_tokens.dart';
import 'widgets/motion/animated_icon_badge.dart';
import 'widgets/motion/premium_hover_card.dart';
import 'widgets/projects_bento_grid.dart';
import 'widgets/section_block.dart';
import 'data/portfolio_content.dart';
import 'data/portfolio_profile_content.dart';
import 'services/portfolio_knowledge.dart';
import 'theme/portfolio_palette.dart';
import 'ui_strings.dart';
import 'utils/responsive_helper.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with TickerProviderStateMixin {

  late AnimationController _controller;
  final bool _backgroundAnimate = false;
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
  double _heroNameScrollOpacity = 1.0;
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
    _scrollController.addListener(_onScrollChanged);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: kIsWeb ? 32 : 24),
    );

    if (_backgroundAnimate) {
      _controller.repeat();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
      _onScrollChanged();
    });
    _startLetterAnimation();
  }

  void _onScrollChanged() {
    _updateHeroNameOpacity();
    _updateActiveSection();
  }

  void _updateHeroNameOpacity() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final next = 1.0 - (offset / 280).clamp(0.0, 1.0);
    if ((next - _heroNameScrollOpacity).abs() > 0.008 && mounted) {
      setState(() => _heroNameScrollOpacity = next);
    }
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
    _scrollController.removeListener(_onScrollChanged);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAssistant,
        backgroundColor: PortfolioPalette.violet,
        foregroundColor: Colors.white,
        icon: const FaIcon(FontAwesomeIcons.robot, size: 20),
        label: const Text(
          UiStrings.navAI,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      drawer: ResponsiveHelper.of(context).useDrawerNav
          ? Drawer(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            palette.bgElevated,
                            palette.bgDeep,
                          ],
                        ),
                        border: Border(
                          bottom: BorderSide(color: palette.borderSubtle),
                        ),
                      ),
                      child: const Text(
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
                        color: PortfolioPalette.violet,
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
          final useDrawerNav =
              ResponsiveHelper.fromWidth(constraints.maxWidth).useDrawerNav;

          return Stack(
            children: [
              Positioned.fill(
                child: PortfolioBackground(
                  animation: _controller,
                  palette: palette,
                  animate: _backgroundAnimate,
                  lite: kIsWeb || constraints.maxWidth < 900,
                ),
              ),
              SafeArea(
                // Keep top inset on mobile browsers too (notch / status bar).
                top: true,
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

  Widget _buildSectionTitle(String title, {String? subtitle}) {
    return SectionHeader(title: title, subtitle: subtitle);
  }

  Widget _buildHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final r = ResponsiveHelper.fromWidth(constraints.maxWidth);
        final isDesktop = r.isDesktop || constraints.maxWidth >= 900;
        final isSmall = r.isMobile;
        final photoWidth = isDesktop
            ? (kIsWeb ? 520.0 : 560.0)
            : isSmall
                ? (kIsWeb ? 320.0 : 340.0)
                : (kIsWeb ? 400.0 : 420.0);
        const photoAspect = 704 / 729;
        final photoHeight = photoWidth / photoAspect;

        // Scale name to phone width — never clip mid-letter.
        final nameFontSize = isDesktop
            ? 54.0
            : isSmall
                ? (constraints.maxWidth * 0.065).clamp(22.0, 28.0)
                : 44.0;

        final badge = Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 14 : 18,
            vertical: isSmall ? 7 : 8,
          ),
          decoration: BoxDecoration(
            color: palette.surfaceRaised,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: PortfolioPalette.accent.withValues(alpha: 0.4),
            ),
            boxShadow: palette.accentGlow(alpha: 0.18, blur: 18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FaIcon(
                FontAwesomeIcons.flutter,
                size: 18,
                color: PortfolioPalette.accent,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  PortfolioProfileContent.role(const Locale('en')),
                  style: TextStyle(
                    color: PortfolioPalette.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: isSmall ? 13 : 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        );

        final nameStyle = TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: nameFontSize,
          color: palette.textPrimary,
          letterSpacing: isSmall ? 0.6 : 1.5,
          height: 1.2,
        );

        final showCursor = !_nameErasing &&
            currentLetterIndex < _heroFullName.length;

        // No Shimmer on web — ShaderMask breaks text on some Android Chrome builds.
        final nameText = Text(
          displayedName.isEmpty ? '\u00A0' : displayedName,
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: nameStyle,
        );

        final cursorHeight = isSmall ? 22.0 : isDesktop ? 48.0 : 40.0;
        final nameWithCursor = AnimatedOpacity(
          opacity: _heroNameScrollOpacity,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          child: Row(
            mainAxisAlignment:
                isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: nameText),
              if (showCursor)
                Padding(
                  padding: EdgeInsets.only(bottom: isSmall ? 3 : 6, left: 2),
                  child: _BlinkingCursor(
                    color: PortfolioPalette.accent,
                    height: cursorHeight,
                  ),
                ),
            ],
          ),
        );

        final tagline = Text(
          UiStrings.heroTagline,
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            color: palette.textSecondary,
            fontWeight: FontWeight.w400,
            height: 1.7,
            fontSize: isSmall ? 14 : 17,
          ),
        );

        final stats = HeroStatsStrip(
          scrollController: _scrollController,
          items: const [
            (
              value: PortfolioKnowledge.yearsOfExperience,
              label: UiStrings.yearsExp,
              icon: FontAwesomeIcons.briefcase,
            ),
            (
              value: '20+',
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

        // Explicit InkWell CTAs — ElevatedButton+transparent bg paints empty on some phones.
        Widget primaryCta({required bool fullWidth}) {
          final child = Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                FontAwesomeIcons.briefcase,
                size: 18,
                color: PortfolioPalette.onAccent,
              ),
              SizedBox(width: 10),
              Text(
                UiStrings.viewProjects,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: PortfolioPalette.onAccent,
                ),
              ),
            ],
          );
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _scrollToSection(3),
              borderRadius: BorderRadius.circular(14),
              child: Ink(
                width: fullWidth ? double.infinity : null,
                decoration: BoxDecoration(
                  gradient: PortfolioPalette.ctaGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: palette.accentGlow(alpha: 0.35, blur: 20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: fullWidth ? 20 : 28,
                    vertical: 16,
                  ),
                  child: child,
                ),
              ),
            ),
          );
        }

        Widget secondaryCta({required bool fullWidth}) {
          final child = Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.envelope,
                size: 16,
                color: palette.textPrimary,
              ),
              const SizedBox(width: 10),
              Text(
                UiStrings.contactMe,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: palette.textPrimary,
                ),
              ),
            ],
          );
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _scrollToSection(4),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: fullWidth ? double.infinity : null,
                padding: EdgeInsets.symmetric(
                  horizontal: fullWidth ? 20 : 28,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: palette.borderAccent, width: 1.5),
                ),
                child: child,
              ),
            ),
          );
        }

        final ctaButtons = isSmall
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  primaryCta(fullWidth: true),
                  const SizedBox(height: 12),
                  secondaryCta(fullWidth: true),
                ],
              )
            : Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
                children: [
                  primaryCta(fullWidth: false),
                  secondaryCta(fullWidth: false),
                ],
              );

        final textColumn = Column(
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            badge,
            const SizedBox(height: 16),
            nameWithCursor,
            const SizedBox(height: 12),
            tagline,
            const SizedBox(height: 20),
            stats,
            const SizedBox(height: 20),
            ctaButtons,
          ],
        );

        final profileVisual = HeroProfileVisual(
          width: photoWidth,
          palette: palette,
          bleedRight: isDesktop,
          alignment: isDesktop ? Alignment.centerRight : Alignment.center,
        );

        if (isDesktop) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kIsWeb ? 32 : 40,
              vertical: kIsWeb ? 16 : 44,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: kIsWeb ? -28 : -12,
                  top: -12,
                  child: profileVisual,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 6, child: textColumn),
                    const SizedBox(width: kIsWeb ? 32 : 48),
                    SizedBox(width: photoWidth * 0.72, height: photoHeight),
                  ],
                ),
              ],
            ),
          );
        }

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 16 : 28,
            vertical: kIsWeb ? 12 : (isSmall ? 28 : 36),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textColumn,
              const SizedBox(height: 20),
              Center(child: profileVisual),
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
              PremiumHoverCard(
                scrollController: _scrollController,
                entranceDelay: const Duration(milliseconds: 90),
                shellGlow: true,
                child: GlassPanel(
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
                                scrollController: _scrollController,
                              ))
                          .toList(),
                    ),
                  ],
                ),
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
      FontAwesomeIcons.robot,
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
                  padding: EdgeInsets.only(
                    top: index == 0 ? 4 : 22,
                    bottom: 8,
                    left: 4,
                    right: 4,
                  ),
                  child: PremiumHoverCard(
                    glowColor: entry.color,
                    scrollController: _scrollController,
                    entranceDelay: Duration(milliseconds: 80 * index),
                    borderRadius: MotionTokens.cardRadius,
                    floating: true,
                    shellGlow: true,
                    enableGlowPulse: true,
                    child: _buildEducationCard(
                      icon: icon,
                      iconColor: entry.color,
                      title: entry.title,
                      subtitle: entry.subtitle,
                      details: entry.details
                          .map((d) => (d.$1, d.$2, entry.color))
                          .toList(),
                      certificateUrl: entry.certificateUrl,
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
    required FaIconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required List<(String, String, Color)> details,
    String? certificateUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: palette.cardSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha: 0.35),
            blurRadius: 36,
            spreadRadius: 1,
            offset: const Offset(0, 18),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedIconBadge(
                    icon: icon,
                    color: iconColor,
                    size: 28,
                    semanticLabel: title,
                    flutterBrand: icon == FontAwesomeIcons.flutter,
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
              if (certificateUrl != null) ...[
                const SizedBox(height: 18),
                OutlinedButton.icon(
                  onPressed: () => _viewCertificate(certificateUrl),
                  icon: FaIcon(
                    FontAwesomeIcons.filePdf,
                    size: 18,
                    color: iconColor,
                  ),
                  label: Text(
                    UiStrings.viewCertificate,
                    style: TextStyle(
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: iconColor.withValues(alpha: 0.7)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ],
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

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 10,
                    ),
                    child: PremiumHoverCard(
                    glowColor: category.color,
                    scrollController: _scrollController,
                    entranceDelay: Duration(milliseconds: 70 * index),
                    borderRadius: MotionTokens.cardRadius,
                    floating: true,
                    shellGlow: true,
                    enableGlowPulse: true,
                    builder: (context, state) {
                      final isHovered = state.hovered;
                      return SizedBox(
                        width: constraints.maxWidth > 600
                            ? (constraints.maxWidth / 2) - 36
                            : constraints.maxWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: palette.cardSurface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isHovered
                                  ? category.color.withValues(alpha: 0.65)
                                  : category.color.withValues(alpha: 0.28),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: category.color.withValues(
                                  alpha: isHovered ? 0.38 : 0.22,
                                ),
                                blurRadius: isHovered ? 38 : 28,
                                spreadRadius: 1,
                                offset: Offset(0, isHovered ? 18 : 12),
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.32),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AnimatedIconBadge(
                                      icon: category.icon,
                                      color: category.color,
                                      size: 24,
                                      boxSize: 48,
                                      semanticLabel: category.category,
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
                                    padding:
                                        const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.arrow_right,
                                          color: category.color
                                              .withValues(alpha: 0.8),
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
                                                      .withValues(
                                                          alpha: 0.92),
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
                      );
                    },
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
                scrollController: _scrollController,
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

  Future<void> _viewCertificate(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
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
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contacts.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: isSmallScreen ? 12 : 20,
                    ),
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return PremiumHoverCard(
                        glowColor: Theme.of(context).colorScheme.primary,
                        scrollController: _scrollController,
                        entranceDelay: Duration(milliseconds: 80 * index),
                        borderRadius: 16,
                        onTap: () async {
                          if (!mounted) return;
                          final messenger = ScaffoldMessenger.of(context);
                          try {
                            final url = Uri.parse(contact['url'] as String);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              if (!mounted) return;
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text(UiStrings.couldNotOpenLink),
                                ),
                              );
                            }
                          } catch (e) {
                            if (!mounted) return;
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  UiStrings.errorGeneric(e.toString()),
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: contactWidth,
                          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.all(isSmallScreen ? 8 : 12),
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
                                  icon: contact['icon'] as FaIconData?,
                                  size: isSmallScreen ? 20 : 24,
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(width: isSmallScreen ? 12 : 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _contactLabel(
                                          contact['label'] as String),
                                      style: TextStyle(
                                        color: palette.textSecondary,
                                        fontSize: isSmallScreen ? 12 : 14,
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
                                        fontSize: isSmallScreen ? 14 : 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            try {
              final url = Uri.parse(PortfolioKnowledge.cvUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(UiStrings.couldNotOpenLink)),
                );
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(UiStrings.errorGeneric(e.toString()))),
                );
              }
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: PortfolioPalette.ctaGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: palette.accentGlow(alpha: 0.38, blur: 24),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.filePdf,
                    size: 22,
                    color: PortfolioPalette.onAccent,
                  ),
                  SizedBox(width: 12),
                  Text(
                    UiStrings.downloadCv,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: PortfolioPalette.onAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAIChatButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _openAssistant,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
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
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.robot, size: 24, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    UiStrings.chatWithAI,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
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
        final useDrawerNav =
            ResponsiveHelper.fromWidth(constraints.maxWidth).useDrawerNav;

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
