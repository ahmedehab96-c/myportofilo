import { useEffect } from 'react';
import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom';
import Home from './pages/Home';
import ProjectDetails from './pages/ProjectDetails';
import AIChat from './pages/AIChat';
import Toast from './components/Toast';
import { LanguageProvider, useLanguage } from './i18n/language';

function ScrollToTop() {
  const { pathname } = useLocation();
  useEffect(() => {
    window.scrollTo(0, 0);
  }, [pathname]);
  return null;
}

function AppRoutes() {
  // Content is patched in place on a language switch; remounting re-reads it.
  const { lang } = useLanguage();
  return (
    <Routes key={lang}>
      <Route path="/" element={<Home />} />
      <Route path="/project/:id" element={<ProjectDetails />} />
      <Route path="/ai" element={<AIChat />} />
    </Routes>
  );
}

export default function App() {
  return (
    <LanguageProvider>
      <BrowserRouter>
        <ScrollToTop />
        <AppRoutes />
        <Toast />
      </BrowserRouter>
    </LanguageProvider>
  );
}
