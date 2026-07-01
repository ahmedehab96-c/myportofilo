import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui_strings.dart';

/// GitHub action: opens public repo or shows private-repo notice.
class GithubRepoButton extends StatelessWidget {
  const GithubRepoButton({
    super.key,
    required this.githubUrl,
    required this.isPrivate,
    this.compact = false,
    this.outlined = true,
  });

  final String? githubUrl;
  final bool isPrivate;
  final bool compact;
  final bool outlined;

  void _showPrivateNotice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(UiStrings.privateRepoNotice),
        duration: Duration(seconds: 4),
      ),
    );
  }

  Future<void> _openPublicRepo(BuildContext context) async {
    if (githubUrl == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final uri = Uri.parse(githubUrl!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!context.mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text(UiStrings.couldNotOpenGithub)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (githubUrl == null) return const SizedBox.shrink();

    final label = isPrivate
        ? UiStrings.privateRepoLabel
        : (compact ? UiStrings.code : UiStrings.sourceCode);
    final icon = isPrivate
        ? FaIcon(FontAwesomeIcons.lock, size: compact ? 14 : 16, color: Colors.white)
        : FaIcon(FontAwesomeIcons.github, size: compact ? 14 : 16, color: Colors.white);

    final onPressed =
        isPrivate ? () => _showPrivateNotice(context) : () => _openPublicRepo(context);

    if (outlined) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          label,
          style: TextStyle(
            fontSize: compact ? 13 : 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
          padding: EdgeInsets.symmetric(vertical: compact ? 10 : 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        isPrivate ? UiStrings.privateOnGithub : UiStrings.viewOnGithub,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrivate ? const Color(0xFF30363D) : const Color(0xFF238636),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: isPrivate ? const Color(0xFF484F58) : const Color(0xFF2EA043),
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
