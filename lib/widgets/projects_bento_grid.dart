import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';
import '../theme/portfolio_palette.dart';
import 'project_card.dart';
import 'section_block.dart';

/// Bento-style project grid: featured projects large on top, others compact below.
/// On mobile, uses a horizontal swipe carousel.
class ProjectsBentoGrid extends StatelessWidget {
  const ProjectsBentoGrid({
    super.key,
    required this.projects,
    required this.hoveredItems,
    required this.onHoverChanged,
    required this.onOpenProject,
    required this.onOpenGithub,
  });

  final List<PortfolioProject> projects;
  final Map<int, bool> hoveredItems;
  final void Function(int index, bool hovering) onHoverChanged;
  final void Function(PortfolioProject project) onOpenProject;
  final void Function(PortfolioProject project) onOpenGithub;

  static const double _gap = 16;

  PortfolioProject? _findById(String id) {
    for (final p in projects) {
      if (p.id == id) return p;
    }
    return null;
  }

  int _indexOf(PortfolioProject project) => projects.indexOf(project);

  Widget _wrapCard({
    required PortfolioProject project,
    required ProjectCardSize size,
    Duration delay = Duration.zero,
  }) {
    final index = _indexOf(project);
    return revealItem(
      MouseRegion(
        onEnter: (_) => onHoverChanged(index, true),
        onExit: (_) => onHoverChanged(index, false),
        child: ProjectCard(
          project: project,
          size: size,
          isHovered: hoveredItems[index] == true,
          onTap: () => onOpenProject(project),
          onGithub: project.githubUrl != null
              ? () => onOpenGithub(project)
              : null,
        ),
      ),
      delay: delay,
    );
  }

  Widget _mobileCarousel(BuildContext context) {
    const height = 420.0;

    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.9),
            padEnds: false,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              final featured =
                  PortfolioContent.bentoFeaturedIds.contains(project.id);
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 8,
                  right: 8,
                ),
                child: _wrapCard(
                  project: project,
                  size: featured
                      ? ProjectCardSize.featured
                      : ProjectCardSize.standard,
                  delay: Duration(milliseconds: 90 * index),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Swipe to explore projects →',
          style: TextStyle(
            fontSize: 12,
            color: context.palette.textMuted,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _tabletGrid(PortfolioProject hrm, PortfolioProject mezo) {
    final others = projects
        .where((p) => p.id != 'hrm' && p.id != 'mezo')
        .toList();

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _wrapCard(
                  project: hrm,
                  size: ProjectCardSize.featured,
                  delay: const Duration(milliseconds: 80),
                ),
              ),
              const SizedBox(width: _gap),
              Expanded(
                child: _wrapCard(
                  project: mezo,
                  size: ProjectCardSize.featured,
                  delay: const Duration(milliseconds: 160),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: _gap),
        Row(
          children: [
            for (var i = 0; i < others.length; i++) ...[
              if (i > 0) const SizedBox(width: _gap),
              Expanded(
                child: _wrapCard(
                  project: others[i],
                  size: ProjectCardSize.standard,
                  delay: Duration(milliseconds: 240 + 80 * i),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _desktopBento(
    PortfolioProject hrm,
    PortfolioProject mezo,
    List<PortfolioProject> others,
  ) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: _wrapCard(
                  project: hrm,
                  size: ProjectCardSize.featured,
                  delay: const Duration(milliseconds: 80),
                ),
              ),
              const SizedBox(width: _gap),
              Expanded(
                flex: 2,
                child: _wrapCard(
                  project: mezo,
                  size: ProjectCardSize.featured,
                  delay: const Duration(milliseconds: 160),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: _gap),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < others.length; i++) ...[
                if (i > 0) const SizedBox(width: _gap),
                Expanded(
                  child: _wrapCard(
                    project: others[i],
                    size: ProjectCardSize.standard,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final hrm = _findById('hrm');
    final mezo = _findById('mezo');

    if (hrm == null || mezo == null) {
      return const SizedBox.shrink();
    }

    final others = projects
        .where((p) => p.id != 'hrm' && p.id != 'mezo')
        .toList();

    if (width < 700) {
      return _mobileCarousel(context);
    }
    if (width < 1024) {
      return _tabletGrid(hrm, mezo);
    }
    return _desktopBento(hrm, mezo, others);
  }
}
