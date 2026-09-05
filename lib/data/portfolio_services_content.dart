import 'package:flutter/material.dart';
import '../widgets/fa_shim.dart';
import '../theme/portfolio_palette.dart';

class PortfolioServiceItem {
  const PortfolioServiceItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final FaIconData icon;
  final Color color;
}

/// Services offered — derived from the skills and projects already on the
/// portfolio (Mobile / Web / Backend / AI). No fabricated offerings.
class PortfolioServicesContent {
  PortfolioServicesContent._();

  static const services = <PortfolioServiceItem>[
    PortfolioServiceItem(
      title: 'Mobile App Development',
      description:
          'Flutter applications for Android and iOS, from UI to state '
          'management and release.',
      icon: FontAwesomeIcons.flutter,
      color: Color(0xFF54C5F8),
    ),
    PortfolioServiceItem(
      title: 'Web Development',
      description:
          'Modern, responsive web applications and dashboards built with '
          'React.js.',
      icon: FontAwesomeIcons.code,
      color: Color(0xFF61DAFB),
    ),
    PortfolioServiceItem(
      title: 'Backend Development',
      description:
          'Laravel REST APIs, databases, authentication, and business logic.',
      icon: FontAwesomeIcons.laravel,
      color: Color(0xFFFF2D20),
    ),
    PortfolioServiceItem(
      title: 'Full-Stack Development',
      description:
          'Complete applications from frontend and mobile through backend '
          'and database, delivered end to end.',
      icon: FontAwesomeIcons.database,
      color: Color(0xFF00B0FF),
    ),
    PortfolioServiceItem(
      title: 'AI Integration',
      description:
          'Integrating AI-powered features — chat assistants and automation '
          '— into mobile and web applications.',
      icon: FontAwesomeIcons.brain,
      color: PortfolioPalette.violet,
    ),
    PortfolioServiceItem(
      title: 'API Integration',
      description:
          'REST API and third-party service integrations connecting your '
          'app to the backends it needs.',
      icon: FontAwesomeIcons.screwdriverWrench,
      color: Color(0xFF0099FF),
    ),
  ];
}
