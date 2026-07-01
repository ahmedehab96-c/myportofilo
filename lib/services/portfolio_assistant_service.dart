import 'dart:convert';

import 'package:http/http.dart' as http;

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
Reply in English only, briefly (3-6 sentences). Use ONLY these facts:

Name: ${PortfolioKnowledge.fullName}
Tagline: ${PortfolioKnowledge.tagline}
Email: ${PortfolioKnowledge.email} | Phone: ${PortfolioKnowledge.phone}
GitHub: ${PortfolioKnowledge.github} | LinkedIn: ${PortfolioKnowledge.linkedIn}

About: ${PortfolioKnowledge.aboutParagraph1}

Projects:
${_projectsSummaryForGemini()}

Skills: Flutter, Dart, Firebase, Supabase, GetX, BLoC, Riverpod, REST APIs, auth (Google/Facebook/Apple), UI/UX, Git, VS Code, Postman.

Education: BSc IT Al-Mashriq University 2018; Udemy Flutter Course; AI Diploma ALBYAN Institute Abu Dhabi (ACTVET accredited, Grade: Excellent, 120 hours).

If off-topic: short polite answer, then guide to Ahmed's projects or contact. Do not invent facts.
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

  static String _projectsSummaryForGemini() {
    return PortfolioKnowledge.projects
        .map((p) => '- ${p.title}: ${p.summary} (${p.tech.join(", ")})')
        .join('\n');
  }

  static String localReply(String message) {
    final m = _normalize(message);

    if (_any(m, ['hello', 'hi', 'hey', 'good morning', 'good evening'])) {
      return 'Hello! I am ${PortfolioKnowledge.fullName}\'s portfolio assistant.\n\nAsk about projects, skills, education, contact, or say "What can you help me with?" for a full topic list.';
    }

    if (_any(m, ['thanks', 'thank you', 'thx', 'appreciate'])) {
      return 'You\'re welcome! Ask anything else about the portfolio — projects, skills, education, or contact.';
    }

    final project = _findProject(m);
    if (project != null) {
      return '📱 ${project.title}\n\n${project.detailReply}\n\nTip: Ask about another project, or "What are your projects?" for the full list.';
    }

    if (_asksForAllProjects(m)) {
      return _allProjectsReply();
    }

    if (_mentionsProjectsTopic(m)) {
      return _projectsMenuReply();
    }

    // Match detailed FAQ entries (40+ topics)
    for (final entry in PortfolioKnowledge.faqEntries) {
      if (entry.matches(m)) {
        return entry.answer;
      }
    }

    return _offTopicReply(message, m);
  }

  static String _offTopicReply(String original, String m) {
    if (_any(m, ['learn', 'beginner', 'start coding', 'how to start programming'])) {
      return '''Learning path suggestion:
1) Programming basics
2) Dart
3) Flutter for mobile and web

Ahmed builds production apps like Mezo Food and HRM Saas. For professional delivery, contact him via the portfolio.''';
    }

    if (_any(m, ['weather', 'temperature', 'rain', 'forecast'])) {
      return 'I cannot show live weather — I am Ahmed\'s portfolio assistant. Ask me about his projects or contact details instead.';
    }

    if (_any(m, ['what time', 'current time', 'today date', 'date today'])) {
      final now = DateTime.now();
      final h = now.hour.toString().padLeft(2, '0');
      final min = now.minute.toString().padLeft(2, '0');
      return 'Today: ${now.day}/${now.month}/${now.year}\nTime: $h:$min\n\nWant info about Ahmed\'s projects or contact?';
    }

    if (_any(m, ['joke', 'funny'])) {
      return '😄 Why do developers love Flutter? One codebase, multiple platforms!\n\nAsk me: "What are your projects?"';
    }

    if (_any(m, ['chatgpt', 'gemini', 'openai', 'are you ai', 'who made you'])) {
      return 'I am the AI assistant built into this portfolio — focused on Ahmed\'s work, skills, and contact info.';
    }

    if (_any(m, ['flutter vs', 'react native', 'best framework'])) {
      return 'Flutter fits cross-platform apps with one UI codebase — Ahmed\'s specialty. See HRM Saas and SchoolConnectApp as examples.';
    }

    if (_any(m, ['medical', 'health advice', 'invest', 'stocks', 'crypto'])) {
      return 'That needs a specialist. I only cover Ahmed\'s technical portfolio. Ask about his Flutter projects or how to hire him.';
    }

    final hint = _guessTopicHint(original, m);
    return '''Thanks for your question!

$hint

I cover everything in this portfolio. Try:
• "What can you help me with?" — full topic list
• "What are your technical skills?"
• "Tell me about HRM Saas"
• "How can I contact you?"

Or tap a suggested question below.''';
  }

  static String _guessTopicHint(String original, String m) {
    if (_any(m, ['python', 'java', 'javascript', 'php', 'laravel'])) {
      return 'Your question seems about another stack. Ahmed focuses on Flutter/Dart with REST or Firebase backends.';
    }
    if (_any(m, ['football', 'movie', 'music', 'sport'])) {
      return 'That topic is outside the portfolio scope.';
    }
    if (original.length < 10) {
      return 'Your message was very short — try a specific question from the suggestions.';
    }
    return 'I could not find an exact match in the portfolio knowledge base.';
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
    const slots = [
      (['project 1', 'first project', '#1', 'number 1'], 0),
      (['project 2', 'second project', '#2', 'number 2'], 1),
      (['project 3', 'third project', '#3', 'number 3'], 2),
      (['project 4', 'fourth project', '#4', 'number 4'], 3),
      (['project 5', 'fifth project', '#5', 'number 5'], 4),
    ];

    for (final slot in slots) {
      if (_any(m, slot.$1)) return projects[slot.$2];
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
      '${PortfolioKnowledge.fullName}\'s featured projects (${projects.length}):\n\n',
    );
    for (var i = 0; i < projects.length; i++) {
      final p = projects[i];
      buffer.writeln('${i + 1}. ${p.title} — ${p.summary}');
    }
    buffer.writeln(
      '\nAsk "Tell me about [name]" or "project 2" for full details.',
    );
    return buffer.toString();
  }

  static String _projectsMenuReply() {
    final projects = PortfolioKnowledge.projects;
    final emojis = ['1️⃣', '2️⃣', '3️⃣', '4️⃣', '5️⃣'];
    final lines = List.generate(
      projects.length,
      (i) => '${emojis[i]} ${projects[i].title} — ${projects[i].summary}',
    ).join('\n');
    return 'Pick a project for details:\n\n$lines\n\nExample: "Tell me about ${projects[0].title}" or "project 2".';
  }

  static String _normalize(String input) => input.toLowerCase().trim();

  static bool _any(String text, List<String> keywords) {
    return keywords.any((k) => text.contains(k.toLowerCase()));
  }
}
