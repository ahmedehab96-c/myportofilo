import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';

import 'core/locale_scope.dart';
import 'data/portfolio_content.dart';
import 'package:myportofilo/gen/l10n/app_localizations.dart';
import 'widgets/zoomable_image.dart';
import 'widgets/github_repo_button.dart';

const _ghBg = Color(0xFF0D1117);
const _ghSurface = Color(0xFF161B22);
const _ghBorder = Color(0xFF30363D);
const _ghBlue = Color(0xFF58A6FF);
const _ghText = Color(0xFFC9D1D9);
const _ghMuted = Color(0xFF8B949E);

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  final PortfolioProject project;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int _currentPage = 0;
  late final PageController _pageController;

  static const _techColors = {
    'Flutter': Color(0xFF54C5F8),
    'Dart': Color(0xFF00B4AB),
    'Laravel': Color(0xFFFF2D20),
    'PHP/MySQL': Color(0xFF777BB4),
    'MySQL': Color(0xFF4479A1),
    'Firebase': Color(0xFFFFA000),
    'REST API': Color(0xFF6E40C9),
    'GetX': Color(0xFFFF6B6B),
    'Provider': Color(0xFF00C853),
    'Supabase': Color(0xFF3ECF8E),
    'BLoC': Color(0xFF0175C2),
    'SQLite': Color(0xFF0064A5),
    'Socket.IO': Color(0xFF9B59B6),
    'go_router': Color(0xFF607D8B),
    'Dio': Color(0xFF26C6DA),
    'Stripe': Color(0xFF635BFF),
    'Google Maps': Color(0xFF34A853),
    'Cloud Functions': Color(0xFFFFCA28),
    'Groq AI': Color(0xFFF55036),
    'OpenAI': Color(0xFF10A37F),
    'Drift': Color(0xFF00BFA5),
    'just_audio': Color(0xFFE91E63),
    'flutter_screenutil': Color(0xFF78909C),
  };

  AppLocalizations get l10n => AppLocalizations.of(context);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Color _techColor(String t) => _techColors[t] ?? const Color(0xFF58A6FF);

  Future<void> _launch(BuildContext ctx, String url) async {
    final messenger = ScaffoldMessenger.of(ctx);
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
        );
      } else {
        if (!ctx.mounted) return;
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.couldNotOpenLink)),
        );
      }
    } catch (e) {
      if (!ctx.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.errorGeneric(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = LocaleScope.of(context).locale;
    final isWide = MediaQuery.of(context).size.width >= 960;

    return Scaffold(
      backgroundColor: _ghBg,
      appBar: _buildAppBar(context, locale),
      body: SingleChildScrollView(
        child: isWide
            ? _buildWideLayout(context, locale)
            : _buildNarrowLayout(context, locale),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Locale locale) {
    return AppBar(
      backgroundColor: _ghSurface,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: _ghBorder),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _ghText),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        widget.project.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: _ghText,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context, Locale locale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: _buildProjectPanel(context, locale)),
          const SizedBox(width: 24),
          SizedBox(width: 280, child: _buildSidebar(context, locale)),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context, Locale locale) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSidebar(context, locale),
          const SizedBox(height: 20),
          _buildProjectPanel(context, locale),
        ],
      ),
    );
  }

  Widget _buildProjectPanel(BuildContext context, Locale locale) {
    final project = widget.project;
    final readme = project.localizedReadme(locale).trim();
    final features = project.localizedFeatures(locale);

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          color: _ghSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ghBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: const TextStyle(
                  color: _ghText,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
              Container(
                height: 1,
                color: _ghBorder,
                margin: const EdgeInsets.symmetric(vertical: 16),
              ),
              if (project.screenshots.isNotEmpty) ...[
                _buildScreenshotGallery(context),
                const SizedBox(height: 28),
              ],
              Text(
                l10n.overview,
                style: const TextStyle(
                  color: _ghText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                height: 1,
                color: _ghBorder,
                margin: const EdgeInsets.symmetric(vertical: 12),
              ),
              Text(
                readme,
                style: const TextStyle(
                  color: _ghMuted,
                  fontSize: 14,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.features,
                style: const TextStyle(
                  color: _ghText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                height: 1,
                color: _ghBorder,
                margin: const EdgeInsets.symmetric(vertical: 12),
              ),
              ...features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: _ghBlue)),
                      Expanded(
                        child: Text(
                          f,
                          style: const TextStyle(
                            color: _ghMuted,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.techStack,
                style: const TextStyle(
                  color: _ghText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                height: 1,
                color: _ghBorder,
                margin: const EdgeInsets.symmetric(vertical: 12),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: project.tech.map((t) => _buildTechBadge(t)).toList(),
              ),
              if (project.githubUrl != null) ...[
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () => _launch(context, project.githubUrl!),
                  icon: const FaIcon(FontAwesomeIcons.github, size: 14),
                  label: Text(
                    l10n.viewReadmeGitHub,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _ghBlue,
                    side: const BorderSide(color: _ghBorder),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenshotGallery(BuildContext context) {
    if (widget.project.screenshots.isEmpty) return const SizedBox.shrink();

    if (widget.project.screenshots.length == 1) {
      return _buildSingleScreenshot(context, widget.project.screenshots.first);
    }

    return Column(
      children: [
        SizedBox(
          height: 380,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: widget.project.screenshots.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildSingleScreenshot(context, widget.project.screenshots[i]),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _currentPage > 0
                  ? () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      )
                  : null,
              icon: const Icon(Icons.chevron_left, color: _ghMuted, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            ...List.generate(widget.project.screenshots.length, (i) {
              final active = i == _currentPage;
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? _ghBlue : _ghBorder,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _currentPage < widget.project.screenshots.length - 1
                  ? () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      )
                  : null,
              icon: const Icon(Icons.chevron_right, color: _ghMuted, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            Text(
              l10n.pageOf(_currentPage + 1, widget.project.screenshots.length),
              style: const TextStyle(color: _ghMuted, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSingleScreenshot(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: SafeArea(child: ZoomableImage(imagePath: imagePath)),
            ),
          ),
        );
      },
      child: Hero(
        tag: imagePath,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 380),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _ghBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: const Color(0xFF0D1117),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image_outlined,
                            color: _ghMuted, size: 48),
                        const SizedBox(height: 8),
                        Text(l10n.screenshotSoon,
                            style: const TextStyle(
                                color: _ghMuted, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.zoom_in, color: Colors.white70, size: 14),
                    const SizedBox(width: 4),
                    Text(l10n.viewFull,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechBadge(String t) {
    final color = _techColor(t);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            t,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, Locale locale) {
    final project = widget.project;

    return FadeInRight(
      duration: const Duration(milliseconds: 500),
      delay: const Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: _ghBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.about,
                  style: const TextStyle(
                    color: _ghText,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  project.localizedCardDescription(locale).trim(),
                  style: const TextStyle(
                    color: _ghMuted,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: _ghBorder, height: 1),
                const SizedBox(height: 16),
                Text(
                  l10n.topics,
                  style: const TextStyle(
                    color: _ghText,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: project.tech
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF388BFD).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xFF388BFD)
                                    .withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            t.toLowerCase().replaceAll('/', '-').replaceAll(' ', '-'),
                            style: const TextStyle(
                              color: _ghBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (project.githubUrl != null)
            SizedBox(
              width: double.infinity,
              child: GithubRepoButton(
                githubUrl: project.githubUrl,
                isPrivate: project.isGithubPrivate,
                outlined: false,
              ),
            ),
        ],
      ),
    );
  }
}
