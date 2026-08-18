import 'package:flutter/material.dart';

import '../animations/motion_tokens.dart';
import '../data/portfolio_content.dart';
import '../utils/responsive_helper.dart';
import 'motion/premium_hover_card.dart';
import 'project_card.dart';

/// Responsive project grid via Wrap — cards size to content, no fixed cell height.
class ProjectsBentoGrid extends StatelessWidget {
  const ProjectsBentoGrid({
    super.key,
    required this.projects,
    required this.onOpenProject,
    required this.onOpenGithub,
    this.scrollController,
  });

  final List<PortfolioProject> projects;
  final void Function(PortfolioProject project) onOpenProject;
  final void Function(PortfolioProject project) onOpenGithub;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const Text(
        'No projects loaded.',
        style: TextStyle(color: Colors.white70),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final r = ResponsiveHelper.fromWidth(constraints.maxWidth);
        final cols = r.gridColumns.clamp(1, 3);
        final gap = r.adaptiveSpacing;
        final usable = constraints.maxWidth;
        final itemWidth = cols == 1
            ? usable
            : (usable - gap * (cols - 1)) / cols;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < projects.length; i++)
              SizedBox(
                width: itemWidth,
                child: PremiumHoverCard(
                  scrollController: scrollController,
                  entranceDelay: Duration(
                    milliseconds: MotionTokens.entranceStagger.inMilliseconds * i,
                  ),
                  glowColor: Theme.of(context).colorScheme.primary,
                  borderRadius: MotionTokens.cardRadiusLarge,
                  builder: (context, state) {
                    final featured = PortfolioContent.bentoFeaturedIds
                        .contains(projects[i].id);
                    return ProjectCard(
                      project: projects[i],
                      size: featured
                          ? ProjectCardSize.featured
                          : ProjectCardSize.standard,
                      isHovered: state.hovered || state.pressed,
                      onTap: () => onOpenProject(projects[i]),
                      onGithub: projects[i].githubUrl != null
                          ? () => onOpenGithub(projects[i])
                          : null,
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
