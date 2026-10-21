import { createContext, useCallback, useContext, useState } from 'react';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import { educationEntries, skillCategories } from '../data/portfolioProfileContent';
import { services } from '../data/portfolioServicesContent';
import { featuredProjects } from '../data/portfolioContent';
import { ar } from '../data/translations.ar';

const STORAGE_KEY = 'portfolio-lang';

const isObject = (v) => v !== null && typeof v === 'object';

/// Snapshot of the current (English) value of every field `patch` touches.
function capture(target, patch) {
  const saved = Array.isArray(patch) ? [] : {};
  for (const key of Object.keys(patch)) {
    if (patch[key] === undefined) continue;
    saved[key] = isObject(patch[key]) && isObject(target[key]) ? capture(target[key], patch[key]) : target[key];
  }
  return saved;
}

function assign(target, patch) {
  for (const key of Object.keys(patch)) {
    if (patch[key] === undefined) continue;
    if (isObject(patch[key]) && isObject(target[key])) assign(target[key], patch[key]);
    else target[key] = patch[key];
  }
}

// The content modules stay the single source of truth: switching language
// patches them in place, and the app remounts its routes to pick it up.
const layers = [
  [UiStrings, ar.ui],
  [PortfolioKnowledge, ar.profile],
  [educationEntries, ar.education],
  [skillCategories, ar.skills],
  [services, ar.services],
  [
    featuredProjects,
    featuredProjects.map((p) => ({
      ...ar.projects[p.id],
      categories: p.categories.map((c) => ar.categories[c] ?? c),
    })),
  ],
].map(([target, patch]) => ({ target, patch, english: capture(target, patch) }));

function applyLanguage(lang) {
  for (const { target, patch, english } of layers) assign(target, lang === 'ar' ? patch : english);
  const root = document.documentElement;
  root.lang = lang;
  root.dir = lang === 'ar' ? 'rtl' : 'ltr';
  document.title = UiStrings.pageTitle;
}

function initialLanguage() {
  try {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved === 'ar' || saved === 'en') return saved;
  } catch {
    // Storage blocked: fall back to the browser language.
  }
  return navigator.language?.toLowerCase().startsWith('ar') ? 'ar' : 'en';
}

const LanguageContext = createContext({ lang: 'en', toggleLanguage: () => {} });

export function LanguageProvider({ children }) {
  const [lang, setLang] = useState(() => {
    const initial = initialLanguage();
    applyLanguage(initial);
    return initial;
  });

  const toggleLanguage = useCallback(() => {
    setLang((prev) => {
      const next = prev === 'ar' ? 'en' : 'ar';
      applyLanguage(next);
      try {
        localStorage.setItem(STORAGE_KEY, next);
      } catch {
        // Not persisted; the toggle still works for this visit.
      }
      return next;
    });
  }, []);

  return <LanguageContext.Provider value={{ lang, toggleLanguage }}>{children}</LanguageContext.Provider>;
}

export const useLanguage = () => useContext(LanguageContext);
