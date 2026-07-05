import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import '../data/portfolio_content.dart';
import '../theme/portfolio_palette.dart';
import '../ui_strings.dart';
import 'deferred_asset_image.dart';

enum ProjectCardSize { featured, standard }

/// Unified project card — same layout for all sizes; featured is taller with badge.
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

  double get _cardHeight => _featured ? 420 : 360;

  double get _imageHeight => _featured ? 188 : 158;

  int get _descriptionLines => _featured ? 3 : 2;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final primary = Theme.of(context).colorScheme.primary;
    final tech = project.tech.take(_featured ? 4 : 3).toList();
    final extraTech = project.tech.length - tech.length;

    return SizedBox(
      height: _cardHeight,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: isHovered
            ? (Matrix4.identity()..translateByVector3(Vector3(0, -3, 0)))
            : Matrix4.identity(),
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
              children: [
                _ProjectPreview(
                  palette: p,
                  imagePath: project.cardImage,
                  isPrivate: project.isGithubPrivate,
                  height: _imageHeight,
                  featured: _featured,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (_featured) ...[
                              const _FeaturedBadge(),
                              const SizedBox(width: 8),
                            ],
                            Expanded(
                              child: Text(
                                project.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: p.textPrimary,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          project.cardDescription,
                          maxLines: _descriptionLines,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.45,
                            color: p.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            ...tech.map(
                              (t) => _TechChip(label: t, color: primary, palette: p),
                            ),
                            if (extraTech > 0)
                              _TechChip(
                                label: '+$extraTech',
                                color: p.textMuted,
                                palette: p,
                                muted: true,
                              ),
                          ],
                        ),
                        const Spacer(),
                        Divider(height: 1, color: p.borderSubtle),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: onTap,
                                icon: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: primary,
                                ),
                                label: Text(
                                  UiStrings.viewProject,
                                  style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ),
                            if (onGithub != null)
                              IconButton(
                                onPressed: onGithub,
                                icon: FaIcon(
                                  FontAwesomeIcons.github,
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
                                  minimumSize: const Size(34, 34),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                          ],
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
    );
  }
}

class _FeaturedBadge extends StatelessWidget {
  const _FeaturedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: PortfolioPalette.gold.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: PortfolioPalette.gold.withValues(alpha: 0.35),
        ),
      ),
      child: const Text(
        UiStrings.featuredProject,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: PortfolioPalette.gold,
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
    required this.height,
    required this.featured,
  });

  final PortfolioPalette palette;
  final String imagePath;
  final bool isPrivate;
  final double height;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    const pad = PortfolioPalette.projectImagePadding;

    return Padding(
      padding: const EdgeInsets.fromLTRB(pad, pad, pad, 0),
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: palette.imagePlaceholder,
                borderRadius: BorderRadius.circular(
                  PortfolioPalette.projectImageRadius,
                ),
                border: Border.all(color: palette.borderSubtle),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  PortfolioPalette.projectImageRadius - 1,
                ),
                child: DeferredAssetImage(
                  asset: imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
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

class _TechChip extends StatelessWidget {
  const _TechChip({
    required this.label,
    required this.color,
    required this.palette,
    this.muted = false,
  });

  final String label;
  final Color color;
  final PortfolioPalette palette;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: muted ? palette.bgMid : color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: muted ? palette.borderSubtle : color.withValues(alpha: 0.22),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: muted ? palette.textMuted : color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
