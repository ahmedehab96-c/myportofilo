import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';
import '../animations/motion_tokens.dart';
import '../theme/portfolio_palette.dart';
import '../ui_strings.dart';
import '../utils/responsive_helper.dart';
import 'deferred_asset_image.dart';
import 'fa_shim.dart';

enum ProjectCardSize { featured, standard }

/// Unified project card — image on top, single concise line below.
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.isHovered,
    required this.onTap,
    this.onGithub,
    this.size = ProjectCardSize.standard,
  });

  final PortfolioProject project;
  final bool isHovered;
  final VoidCallback onTap;
  final VoidCallback? onGithub;
  final ProjectCardSize size;

  bool get _featured => size == ProjectCardSize.featured;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final r = ResponsiveHelper.of(context);
    final primary = Theme.of(context).colorScheme.primary;
    final pad = r.isMobile ? 12.0 : 14.0;

    return AnimatedContainer(
      duration: MotionTokens.hoverDuration,
      curve: MotionTokens.hoverCurve,
      decoration: p.projectCard(
        hovered: isHovered,
        featured: _featured,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _ProjectPreview(
                palette: p,
                imagePath: project.cardImage,
                isPrivate: project.isGithubPrivate,
                featured: _featured,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(pad, 10, pad, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (project.categories.isNotEmpty) ...[
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: project.categories
                            .map((c) => _CategoryPill(category: c))
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: r.adaptiveFont(16),
                        fontWeight: FontWeight.w700,
                        color: p.textPrimary,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      project.summary,
                      maxLines: _featured ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: r.adaptiveFont(13),
                        height: 1.4,
                        color: p.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: onTap,
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              minimumSize: const Size(48, 36),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              UiStrings.viewProject,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.w600,
                                fontSize: r.adaptiveFont(13),
                              ),
                            ),
                          ),
                        ),
                        if (onGithub != null)
                          IconButton(
                            onPressed: onGithub,
                            icon: BrandMarkIcon(
                              brand: 'github',
                              size: 16,
                              color: project.isGithubPrivate
                                  ? p.textMuted
                                  : p.textSecondary,
                            ),
                            tooltip: project.isGithubPrivate
                                ? UiStrings.privateOnGithub
                                : UiStrings.viewOnGithub,
                            style: IconButton.styleFrom(
                              backgroundColor: p.bgMid,
                              minimumSize: const Size(36, 36),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectPreview extends StatelessWidget {
  const _ProjectPreview({
    required this.palette,
    required this.imagePath,
    required this.isPrivate,
    required this.featured,
  });

  final PortfolioPalette palette;
  final String imagePath;
  final bool isPrivate;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    const pad = PortfolioPalette.projectImagePadding;

    return Padding(
      padding: const EdgeInsets.fromLTRB(pad, pad, pad, 0),
      child: AspectRatio(
        aspectRatio: featured ? 16 / 9 : 16 / 10,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        palette.bgMid,
                        palette.imagePlaceholder,
                        palette.bgDeep,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      PortfolioPalette.projectImageRadius,
                    ),
                    border: Border.all(color: palette.borderSubtle),
                    boxShadow: [
                      BoxShadow(
                        color: PortfolioPalette.accent.withValues(alpha: 0.08),
                        blurRadius: featured ? 20 : 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      PortfolioPalette.projectImageRadius - 1,
                    ),
                    child: DeferredAssetImage(
                      asset: imagePath,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      useShimmer: false,
                      placeholderColor: palette.imagePlaceholder,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 36,
                          color: palette.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: _RepoBadge(isPrivate: isPrivate, palette: palette),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final color = PortfolioPalette.categoryColor(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _RepoBadge extends StatelessWidget {
  const _RepoBadge({required this.isPrivate, required this.palette});

  final bool isPrivate;
  final PortfolioPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: palette.cardSurface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        isPrivate ? UiStrings.privateRepo : UiStrings.openSource,
        style: TextStyle(
          color: palette.textSecondary,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
