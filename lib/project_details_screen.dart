import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/fa_shim.dart';
import 'package:animate_do/animate_do.dart';

import 'ui_strings.dart';
import 'data/portfolio_content.dart';
import 'utils/responsive_helper.dart';
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

  /// Credentials / notes only — no repeated button or APK instructions.
  String? _compactTryNotes(PortfolioProject project) {
    final guide = project.webSetupGuide?.trim();
    if (guide == null || guide.isEmpty) return null;

    final lines = guide
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .where((l) {
          final lower = l.toLowerCase();
          if (lower.startsWith('**android apk**')) return false;
          if (lower.startsWith('**live demo')) return false;
          if (lower.startsWith('**live web')) return false;
          if (lower.contains('tap **download apk**')) return false;
          if (lower.contains('tap **open live demo**')) return false;
          if (lower.startsWith('1. tap')) return false;
          if (lower.startsWith('2. install')) return false;
          if (lower.startsWith('3. sign in') && lower.contains('demo')) {
            return false;
          }
          return true;
        })
        .map((l) => l.replaceAll(RegExp(r'\*\*'), ''))
        .toList();

    if (lines.isEmpty) return null;
    return lines.join('\n');
  }

  Widget _buildTrySection(BuildContext context) {
    final project = widget.project;
    if (!project.hasTrySection) return const SizedBox.shrink();
    final r = ResponsiveHelper.of(context);
    final pad = r.adaptivePadding.clamp(12.0, 20.0);
    final notes = _compactTryNotes(project);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: const Color(0xFF388BFD).withValues(alpha: 0.08),
        border: Border.all(
          color: const Color(0xFF388BFD).withValues(alpha: 0.25),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            UiStrings.tryThisProject,
            style: TextStyle(
              color: _ghText,
              fontSize: r.adaptiveFont(15),
              fontWeight: FontWeight.w700,
            ),
          ),
          if (project.liveDemoUrl != null ||
              project.apkUrl != null ||
              project.playStoreUrl != null) ...[
            SizedBox(height: r.adaptiveSpacing),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (project.liveDemoUrl != null)
                  FilledButton.icon(
                    onPressed: () => _launch(context, project.liveDemoUrl!),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text(UiStrings.openLiveDemo),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF388BFD),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(48, 44),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                if (project.playStoreUrl != null)
                  FilledButton.icon(
                    onPressed: () => _launch(context, project.playStoreUrl!),
                    icon: const Icon(Icons.shop, size: 16),
                    label: const Text(UiStrings.getOnGooglePlay),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF01875F),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(48, 44),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                if (project.apkUrl != null)
                  FilledButton.icon(
                    onPressed: () => _launch(context, project.apkUrl!),
                    icon: const FaIcon(FontAwesomeIcons.android, size: 16),
                    label: const Text(UiStrings.downloadApk),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF238636),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(48, 44),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          if (notes != null) ...[
            SizedBox(height: r.adaptiveSpacing),
            Text(
              notes,
              style: TextStyle(
                color: _ghMuted,
                fontSize: r.adaptiveFont(12),
                height: 1.65,
              ),
            ),
          ],
        ],
      ),
    );
  }

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
          const SnackBar(content: Text(UiStrings.couldNotOpenLink)),
        );
      }
    } catch (e) {
      if (!ctx.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(UiStrings.errorGeneric(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper.of(context);

    return Scaffold(
      backgroundColor: _ghBg,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: r.isWideLayout
                    ? _buildWideLayout(context, r)
                    : _buildNarrowLayout(context, r),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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

  Widget _buildWideLayout(BuildContext context, ResponsiveHelper r) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: r.adaptivePadding + 8,
        vertical: r.adaptiveSpacing + 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: _buildProjectPanel(
              context,
              r,
              showTrySection: false,
              showGithubButton: false,
            ),
          ),
          SizedBox(width: r.adaptiveSpacing + 4),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: r.isDesktop ? 300 : 260,
              minWidth: 220,
            ),
            child: _buildSidebar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context, ResponsiveHelper r) {
    return Padding(
      padding: EdgeInsets.all(r.adaptivePadding),
      child: _buildProjectPanel(
        context,
        r,
        showTrySection: true,
        showGithubButton: true,
      ),
    );
  }

  Widget _buildProjectPanel(
    BuildContext context,
    ResponsiveHelper r, {
    required bool showTrySection,
    required bool showGithubButton,
  }) {
    final project = widget.project;
    final features = project.features;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: _ghSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ghBorder),
        ),
        child: Padding(
          padding: EdgeInsets.all(r.isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (project.screenshots.isNotEmpty) ...[
                _buildScreenshotGallery(context),
                SizedBox(height: r.adaptiveSpacing),
              ],
              Text(
                project.summary,
                style: TextStyle(
                  color: _ghMuted,
                  fontSize: r.adaptiveFont(14),
                  height: 1.55,
                ),
              ),
              if (showTrySection && project.hasTrySection) ...[
                SizedBox(height: r.adaptiveSpacing),
                _buildTrySection(context),
              ],
              SizedBox(height: r.adaptiveSpacing + 4),
              Text(
                UiStrings.features,
                style: TextStyle(
                  color: _ghText,
                  fontSize: r.adaptiveFont(18),
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
                          style: TextStyle(
                            color: _ghMuted,
                            fontSize: r.adaptiveFont(14),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: r.adaptiveSpacing + 4),
              Text(
                UiStrings.techStack,
                style: TextStyle(
                  color: _ghText,
                  fontSize: r.adaptiveFont(18),
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
              if (showGithubButton && project.githubUrl != null) ...[
                SizedBox(height: r.adaptiveSpacing + 4),
                SizedBox(
                  width: double.infinity,
                  child: GithubRepoButton(
                    githubUrl: project.githubUrl,
                    isPrivate: project.isGithubPrivate,
                    outlined: false,
                  ),
                ),
              ],
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final r = ResponsiveHelper.fromWidth(constraints.maxWidth);
        final galleryHeight = (constraints.maxWidth * 0.55)
            .clamp(220.0, r.isMobile ? 280.0 : 380.0);

        return Column(
          children: [
            SizedBox(
              height: galleryHeight,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: widget.project.screenshots.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildSingleScreenshot(
                    context,
                    widget.project.screenshots[i],
                    galleryHeight: galleryHeight,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
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
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                ),
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
                IconButton(
                  onPressed: _currentPage < widget.project.screenshots.length - 1
                      ? () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          )
                      : null,
                  icon:
                      const Icon(Icons.chevron_right, color: _ghMuted, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                ),
                const SizedBox(width: 8),
                Text(
                  UiStrings.pageOf(
                    _currentPage + 1,
                    widget.project.screenshots.length,
                  ),
                  style: const TextStyle(color: _ghMuted, fontSize: 12),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSingleScreenshot(
    BuildContext context,
    String imagePath, {
    double? galleryHeight,
  }) {
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
          height: galleryHeight,
          constraints: galleryHeight == null
              ? const BoxConstraints(maxHeight: 380)
              : null,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0D1117), Color(0xFF161B22), Color(0xFF0D1117)],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _ghBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: galleryHeight != null ? StackFit.expand : StackFit.loose,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                width: double.infinity,
                filterQuality: FilterQuality.medium,
                cacheWidth: (MediaQuery.sizeOf(context).width *
                        MediaQuery.devicePixelRatioOf(context))
                    .clamp(400, 1400)
                    .round(),
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: const Color(0xFF0D1117),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined,
                            color: _ghMuted, size: 48),
                        SizedBox(height: 8),
                        Text(UiStrings.screenshotSoon,
                            style: TextStyle(
                                color: _ghMuted, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.zoom_in, color: Colors.white70, size: 14),
                      SizedBox(width: 4),
                      Text(UiStrings.viewFull,
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ],
                  ),
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

  Widget _buildSidebar(BuildContext context) {
    final project = widget.project;

    return FadeInRight(
      duration: const Duration(milliseconds: 500),
      delay: const Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrySection(context),
          if (project.githubUrl != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: GithubRepoButton(
                githubUrl: project.githubUrl,
                isPrivate: project.isGithubPrivate,
                outlined: false,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
