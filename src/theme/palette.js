// Brand accents (shared) — Midnight Navy + Electric Cyan + AI Violet.
export const accent = '#22D3EE';
export const accentBright = '#67E8F9';
export const accentDeep = '#0E7490';
export const violet = '#8B5CF6';
export const violetDeep = '#6D28D9';
export const sky = '#38BDF8';
export const teal = '#14B8A6';
export const gold = '#B45309';
export const onAccent = '#0B1120';

export const categoryColors = {
  Mobile: accent,
  Web: sky,
  Backend: '#FF2D20',
  SaaS: gold,
  AI: violet,
};

export function categoryColor(category) {
  return categoryColors[category] || accent;
}

// Tech badge colors used on the project details page.
export const techColors = {
  Flutter: '#54C5F8',
  Dart: '#00B4AB',
  Laravel: '#FF2D20',
  'PHP/MySQL': '#777BB4',
  MySQL: '#4479A1',
  Firebase: '#FFA000',
  'REST API': '#6E40C9',
  GetX: '#FF6B6B',
  Provider: '#00C853',
  Supabase: '#3ECF8E',
  BLoC: '#0175C2',
  SQLite: '#0064A5',
  'Socket.IO': '#9B59B6',
  go_router: '#607D8B',
  Dio: '#26C6DA',
  Stripe: '#635BFF',
  'Google Maps': '#34A853',
  'Cloud Functions': '#FFCA28',
  'Groq AI': '#F55036',
  OpenAI: '#10A37F',
  Drift: '#00BFA5',
  just_audio: '#E91E63',
  flutter_screenutil: '#78909C',
};

export function techColor(t) {
  return techColors[t] || '#58A6FF';
}
