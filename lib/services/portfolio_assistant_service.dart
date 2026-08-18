import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/portfolio_content.dart';
import '../ui_strings.dart';
import 'portfolio_knowledge.dart';

/// Portfolio-aware assistant: comprehensive local knowledge + optional Gemini.
class PortfolioAssistantService {
  PortfolioAssistantService._();

  static const apiKey = String.fromEnvironment('GEMINI_API_KEY');

  static List<String> get suggestedQuestions =>
      PortfolioKnowledge.suggestedQuestions;

  static Future<String> reply(String message) async {
    final trimmed = message.trim();
    if (trimmed.isEmpty) {
      return UiStrings.emptyQuestion;
    }

    if (apiKey.isNotEmpty) {
      try {
        final remote = await _askGemini(trimmed);
        if (remote != null) return remote;
      } catch (_) {
        // Fall through to local knowledge base.
      }
    }

    return localReply(trimmed);
  }

  static Future<String?> _askGemini(String message) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey',
    );

    final systemContext = '''
You are the AI assistant for ${PortfolioKnowledge.fullName}'s portfolio (${PortfolioKnowledge.role}).
Reply in English only, clearly (3-8 sentences). Use ONLY these facts:

${PortfolioKnowledge.assistantSystemPrompt}

If off-topic: short polite answer, then guide to Ahmed's portfolio sections, projects, or contact. Do not invent facts.
''';

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': '$systemContext\n\nVisitor question: $message'},
            ],
          },
        ],
      }),
    );

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = data['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) return null;

    final parts = candidates[0]['content']?['parts'] as List<dynamic>?;
    if (parts == null || parts.isEmpty) return null;

    return parts[0]['text'] as String?;
  }

  static String localReply(String message) {
    final m = _normalize(message);

    if (_any(m, ['hello', 'hi', 'hey', 'good morning', 'good evening'])) {
      return 'Hello! I am ${PortfolioKnowledge.fullName}\'s portfolio assistant.\n\nI know every section: About, Education, Skills, all 7 projects, Contact, CV, and services. Ask anything or say "What can you help me with?"';
    }

    if (_any(m, ['thanks', 'thank you', 'thx', 'appreciate'])) {
      return 'You\'re welcome! Ask about any portfolio section, project, skill category, education, or contact details.';
    }

    final project = _findProject(m);
    if (project != null) {
      return '📱 ${project.title}\n\n${_fullProjectReply(project.id)}\n\nTip: Ask about another project or "What are your projects?" for the full list.';
    }

    if (_asksForAllProjects(m)) {
      return _allProjectsReply();
    }

    if (_mentionsProjectsTopic(m)) {
      return _projectsMenuReply();
    }

    for (final entry in PortfolioKnowledge.faqEntries) {
      if (entry.matches(m)) {
        return entry.answer;
      }
    }

    return _offTopicReply(message, m);
  }

  static String _fullProjectReply(String projectId) {
    PortfolioProject? p;
    for (final project in PortfolioContent.featuredProjects) {
      if (project.id == projectId) {
        p = project;
        break;
      }
    }
    if (p == null) return 'Project not found.';

    final buffer = StringBuffer('${p.summary}\n\n');
    if (p.features.isNotEmpty) {
      buffer.writeln('Features:');
      for (final f in p.features.take(8)) {
        buffer.writeln('• $f');
      }
      buffer.writeln('');
    }
    buffer.writeln('Tech: ${p.tech.join(", ")}');
    if (p.liveDemoUrl != null) buffer.writeln('\n🌐 Live demo: ${p.liveDemoUrl}');
    if (p.playStoreUrl != null) {
      buffer.writeln('\n📲 Google Play: ${p.playStoreUrl}');
    }
    if (p.apkUrl != null) buffer.writeln('📦 APK: ${p.apkUrl}');
    if (p.githubUrl != null) {
      buffer.writeln(
        '\n🔗 GitHub: ${p.githubUrl}${p.isGithubPrivate ? " (private)" : ""}',
      );
    } else if (p.isGithubPrivate) {
      buffer.writeln('\n🔒 Private repo — contact ${PortfolioKnowledge.email}');
    }
    return buffer.toString();
  }

  static String _offTopicReply(String original, String m) {
    if (_any(m, ['learn', 'beginner', 'start coding', 'how to start programming'])) {
      return '''Learning path suggestion:
1) Programming basics
2) Dart
3) Flutter for mobile and web

Ahmed builds production apps like Mezo Food and HRM NAWA TECH. For professional delivery, contact him via the portfolio.''';
    }

    if (_any(m, ['weather', 'temperature', 'rain', 'forecast'])) {
      return 'I cannot show live weather — I am Ahmed\'s portfolio assistant. Ask about any section: projects, skills, education, or contact.';
    }

    if (_any(m, ['what time', 'current time', 'today date', 'date today'])) {
      final now = DateTime.now();
      final h = now.hour.toString().padLeft(2, '0');
      final min = now.minute.toString().padLeft(2, '0');
      return 'Today: ${now.day}/${now.month}/${now.year}\nTime: $h:$min\n\nAsk about Ahmed\'s projects, skills, education, or contact details.';
    }

    if (_any(m, ['joke', 'funny'])) {
      return '😄 Why do developers love Flutter? One codebase, multiple platforms!\n\nAsk me: "What are your projects?" or "What sections are in this portfolio?"';
    }

    if (_any(m, ['chatgpt', 'gemini', 'openai', 'are you ai', 'who made you'])) {
      return 'I am the AI assistant built into this portfolio — I answer questions about every section: About, Education, Skills, Projects, Contact, and more.';
    }

    if (_any(m, ['flutter vs', 'react native', 'best framework'])) {
      return 'Flutter fits cross-platform apps with one UI codebase — Ahmed\'s specialty. See HRM NAWA TECH, Life OS, and Mezo Food as examples on this portfolio.';
    }

    if (_any(m, ['medical', 'health advice', 'invest', 'stocks', 'crypto'])) {
      return 'That needs a specialist. I only cover Ahmed\'s portfolio content. Ask about his Flutter projects, skills, or how to hire him.';
    }

    final hint = _guessTopicHint(original, m);
    return '''Thanks for your question!

$hint

I cover every point on this portfolio. Try:
• "What can you help me with?" — full topic list
• "What sections are in this portfolio?"
• "Tell me about StepZone" or "Tell me about BankX"
• "What are your technical skills?"
• "How can I contact you?"

Or tap a suggested question below.''';
  }

  static String _guessTopicHint(String original, String m) {
    if (_any(m, ['python', 'java', 'javascript', 'php'])) {
      return 'Your question seems about another stack. Ahmed focuses on Flutter/Dart with Laravel, Firebase, or Supabase backends.';
    }
    if (_any(m, ['football', 'movie', 'music', 'sport'])) {
      return 'That topic is outside the portfolio scope.';
    }
    if (original.length < 10) {
      return 'Your message was very short — try a specific question from the suggestions.';
    }
    return 'I could not find an exact match — try naming a section (About, Skills, Education) or a project by name.';
  }

  static ProjectKnowledge? _findProject(String m) {
    final byNumber = _projectByNumber(m);
    if (byNumber != null) return byNumber;

    for (final project in PortfolioKnowledge.projects) {
      if (project.keywords.any((k) => m.contains(k.toLowerCase()))) {
        return project;
      }
    }
    return null;
  }

  static ProjectKnowledge? _projectByNumber(String m) {
    final projects = PortfolioKnowledge.projects;
    for (var i = 0; i < projects.length; i++) {
      final n = i + 1;
      if (_any(m, [
        'project $n',
        if (n == 1) 'first project',
        if (n == 2) 'second project',
        if (n == 3) 'third project',
        if (n == 4) 'fourth project',
        if (n == 5) 'fifth project',
        if (n == 6) 'sixth project',
        if (n == 7) 'seventh project',
        '#$n',
        'number $n',
      ])) {
        return projects[i];
      }
    }
    return null;
  }

  static bool _asksForAllProjects(String m) {
    return _any(m, [
      'what are your projects',
      'your projects',
      'all projects',
      'list projects',
      'show projects',
      'how many projects',
      'featured projects',
    ]);
  }

  static bool _mentionsProjectsTopic(String m) {
    return _any(m, ['project', 'projects', 'your apps', 'your work', 'portfolio work']);
  }

  static String _allProjectsReply() {
    final projects = PortfolioKnowledge.projects;
    final buffer = StringBuffer(
      '${PortfolioKnowledge.fullName}\'s projects (${projects.length}):\n\n',
    );
    for (var i = 0; i < projects.length; i++) {
      final p = projects[i];
      buffer.writeln('${i + 1}. ${p.title} — ${p.summary}');
    }
    buffer.writeln(
      '\nAsk "Tell me about [name]" or "project 3" for full details with demo/APK links.',
    );
    return buffer.toString();
  }

  static String _projectsMenuReply() {
    final projects = PortfolioKnowledge.projects;
    final lines = List.generate(
      projects.length,
      (i) => '${i + 1}. ${projects[i].title} — ${projects[i].summary}',
    ).join('\n');
    return 'Pick a project for details:\n\n$lines\n\nExample: "Tell me about ${projects[0].title}" or "project 2".';
  }

  static String _normalize(String input) => input.toLowerCase().trim();

  static bool _any(String text, List<String> keywords) {
    return keywords.any((k) => text.contains(k.toLowerCase()));
  }
}
