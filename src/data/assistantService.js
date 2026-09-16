import { PortfolioKnowledge } from './portfolioKnowledge';
import { featuredProjects, assistantDetail } from './portfolioContent';
import { UiStrings } from './uiStrings';

const apiKey = import.meta.env.VITE_GEMINI_API_KEY || '';

export const suggestedQuestions = PortfolioKnowledge.suggestedQuestions;

export async function reply(message) {
  const trimmed = message.trim();
  if (!trimmed) return UiStrings.emptyQuestion;

  if (apiKey) {
    try {
      const remote = await askGemini(trimmed);
      if (remote) return remote;
    } catch {
      // Fall through to local knowledge base.
    }
  }

  return localReply(trimmed);
}

async function askGemini(message) {
  const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${apiKey}`;

  const systemContext = `You are the AI assistant for ${PortfolioKnowledge.fullName}'s portfolio (${PortfolioKnowledge.role}).
Reply in English only, clearly (3-8 sentences). Use ONLY these facts:

${PortfolioKnowledge.assistantSystemPrompt}

If off-topic: short polite answer, then guide to Ahmed's portfolio sections, projects, or contact. Do not invent facts.`;

  const response = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [{ parts: [{ text: `${systemContext}\n\nVisitor question: ${message}` }] }],
    }),
  });

  if (!response.ok) return null;

  const data = await response.json();
  const candidates = data.candidates;
  if (!candidates || candidates.length === 0) return null;
  const parts = candidates[0]?.content?.parts;
  if (!parts || parts.length === 0) return null;
  return parts[0]?.text ?? null;
}

export function localReply(message) {
  const m = normalize(message);

  if (any(m, ['hello', 'hi', 'hey', 'good morning', 'good evening'])) {
    return `Hello! I am ${PortfolioKnowledge.fullName}'s portfolio assistant.\n\nI know every section: About, Education, Skills, all 8 projects, Contact, CV, and services. Ask anything or say "What can you help me with?"`;
  }

  if (any(m, ['thanks', 'thank you', 'thx', 'appreciate'])) {
    return "You're welcome! Ask about any portfolio section, project, skill category, education, or contact details.";
  }

  const project = findProject(m);
  if (project) {
    return `📱 ${project.title}\n\n${fullProjectReply(project.id)}\n\nTip: Ask about another project or "What are your projects?" for the full list.`;
  }

  if (asksForAllProjects(m)) return allProjectsReply();
  if (mentionsProjectsTopic(m)) return projectsMenuReply();

  for (const entry of PortfolioKnowledge.faqEntries) {
    if (entry.matches(m)) return entry.answer;
  }

  return offTopicReply(message, m);
}

function fullProjectReply(projectId) {
  const p = featuredProjects.find((project) => project.id === projectId);
  if (!p) return 'Project not found.';

  let buffer = `${p.summary}\n\n`;
  if (p.features.length > 0) {
    buffer += 'Features:\n';
    for (const f of p.features.slice(0, 8)) buffer += `• ${f}\n`;
    buffer += '\n';
  }
  buffer += `Tech: ${p.tech.join(', ')}`;
  if (p.liveDemoUrl) buffer += `\n\n🌐 Live demo: ${p.liveDemoUrl}`;
  if (p.playStoreUrl) buffer += `\n📲 Google Play: ${p.playStoreUrl}`;
  if (p.apkUrl) buffer += `\n📦 APK: ${p.apkUrl}`;
  if (p.githubUrl) {
    buffer += `\n🔗 GitHub: ${p.githubUrl}${p.isGithubPrivate ? ' (private)' : ''}`;
  } else if (p.isGithubPrivate) {
    buffer += `\n🔒 Private repo — contact ${PortfolioKnowledge.email}`;
  }
  return buffer;
}

function offTopicReply(original, m) {
  if (any(m, ['learn', 'beginner', 'start coding', 'how to start programming'])) {
    return `Learning path suggestion:\n1) Programming basics\n2) Dart\n3) Flutter for mobile and web\n\nAhmed builds production apps like Mezo Food and HRM NAWA TECH. For professional delivery, contact him via the portfolio.`;
  }

  if (any(m, ['weather', 'temperature', 'rain', 'forecast'])) {
    return "I cannot show live weather — I am Ahmed's portfolio assistant. Ask about any section: projects, skills, education, or contact.";
  }

  if (any(m, ['what time', 'current time', 'today date', 'date today'])) {
    const now = new Date();
    const h = String(now.getHours()).padStart(2, '0');
    const min = String(now.getMinutes()).padStart(2, '0');
    return `Today: ${now.getDate()}/${now.getMonth() + 1}/${now.getFullYear()}\nTime: ${h}:${min}\n\nAsk about Ahmed's projects, skills, education, or contact details.`;
  }

  if (any(m, ['joke', 'funny'])) {
    return '😄 Why do developers love Flutter? One codebase, multiple platforms!\n\nAsk me: "What are your projects?" or "What sections are in this portfolio?"';
  }

  if (any(m, ['chatgpt', 'gemini', 'openai', 'are you ai', 'who made you'])) {
    return 'I am the AI assistant built into this portfolio — I answer questions about every section: About, Education, Skills, Projects, Contact, and more.';
  }

  if (any(m, ['flutter vs', 'react native', 'best framework'])) {
    return "Flutter fits cross-platform apps with one UI codebase — Ahmed's specialty. See HRM NAWA TECH, Life OS, and Mezo Food as examples on this portfolio.";
  }

  if (any(m, ['medical', 'health advice', 'invest', 'stocks', 'crypto'])) {
    return "That needs a specialist. I only cover Ahmed's portfolio content. Ask about his Flutter projects, skills, or how to hire him.";
  }

  const hint = guessTopicHint(original, m);
  return `Thanks for your question!\n\n${hint}\n\nI cover every point on this portfolio. Try:\n• "What can you help me with?" — full topic list\n• "What sections are in this portfolio?"\n• "Tell me about StepZone" or "Tell me about BankX"\n• "What are your technical skills?"\n• "How can I contact you?"\n\nOr tap a suggested question below.`;
}

function guessTopicHint(original, m) {
  if (any(m, ['python', 'java', 'javascript', 'php'])) {
    return 'Your question seems about another stack. Ahmed focuses on Flutter/Dart with Laravel, Firebase, or Supabase backends.';
  }
  if (any(m, ['football', 'movie', 'music', 'sport'])) {
    return 'That topic is outside the portfolio scope.';
  }
  if (original.length < 10) {
    return 'Your message was very short — try a specific question from the suggestions.';
  }
  return 'I could not find an exact match — try naming a section (About, Skills, Education) or a project by name.';
}

function findProject(m) {
  const byNumber = projectByNumber(m);
  if (byNumber) return byNumber;

  return PortfolioKnowledge.projects.find((project) =>
    project.keywords.some((k) => m.includes(k.toLowerCase())),
  ) || null;
}

function projectByNumber(m) {
  const projects = PortfolioKnowledge.projects;
  const ordinals = ['first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh'];
  for (let i = 0; i < projects.length; i++) {
    const n = i + 1;
    const keys = [`project ${n}`, `#${n}`, `number ${n}`];
    if (ordinals[n - 1]) keys.push(`${ordinals[n - 1]} project`);
    if (any(m, keys)) return projects[i];
  }
  return null;
}

function asksForAllProjects(m) {
  return any(m, [
    'what are your projects', 'your projects', 'all projects', 'list projects',
    'show projects', 'how many projects', 'featured projects',
  ]);
}

function mentionsProjectsTopic(m) {
  return any(m, ['project', 'projects', 'your apps', 'your work', 'portfolio work']);
}

function allProjectsReply() {
  const projects = PortfolioKnowledge.projects;
  let buffer = `${PortfolioKnowledge.fullName}'s projects (${projects.length}):\n\n`;
  projects.forEach((p, i) => {
    buffer += `${i + 1}. ${p.title} — ${p.summary}\n`;
  });
  buffer += '\nAsk "Tell me about [name]" or "project 3" for full details with demo/APK links.';
  return buffer;
}

function projectsMenuReply() {
  const projects = PortfolioKnowledge.projects;
  const lines = projects.map((p, i) => `${i + 1}. ${p.title} — ${p.summary}`).join('\n');
  return `Pick a project for details:\n\n${lines}\n\nExample: "Tell me about ${projects[0].title}" or "project 2".`;
}

function normalize(input) {
  return input.toLowerCase().trim();
}

function any(text, keywords) {
  return keywords.some((k) => text.includes(k.toLowerCase()));
}

export { assistantDetail };
