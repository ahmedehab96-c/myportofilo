import { useEffect, useState } from 'react';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { useWindowWidth } from '../hooks/useWindowWidth';
import { useLanguage } from '../i18n/language';
import './NavBar.css';

const MOBILE_BREAKPOINT = 768;

// Read at render time so the labels follow the active language.
const navItems = () => [
  UiStrings.navAbout,
  UiStrings.navEducation,
  UiStrings.navSkills,
  UiStrings.navServices,
  UiStrings.navProjects,
  UiStrings.navContact,
];

function LanguageToggle() {
  const { lang, toggleLanguage } = useLanguage();
  return (
    <button
      type="button"
      className="nav-lang"
      onClick={toggleLanguage}
      aria-label={UiStrings.switchLanguage}
      lang={lang === 'ar' ? 'en' : 'ar'}
    >
      <FaIcon icon="globe" size={13} />
      {UiStrings.languageToggle}
    </button>
  );
}

function Brand() {
  return (
    <button type="button" className="nav-brand" onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}>
      <span className="nav-brand-mark" aria-hidden="true">A</span>
      {UiStrings.brandName}
    </button>
  );
}

function MobileDrawer({ open, onClose, activeIndex, onSelect, onOpenAi }) {
  return (
    <>
      <div
        className={`nav-drawer-scrim ${open ? 'open' : ''}`}
        onClick={onClose}
        aria-hidden={!open}
      />
      <div className={`nav-drawer ${open ? 'open' : ''}`} role="dialog" aria-modal="true">
        <button type="button" className="nav-drawer-close" onClick={onClose} aria-label={UiStrings.closeMenu}>
          <FaIcon icon="xmark" size={18} />
        </button>
        <div className="nav-drawer-items">
          {navItems().map((label, i) => (
            <button
              key={label}
              type="button"
              className={`nav-drawer-item ${activeIndex === i ? 'active' : ''}`}
              onClick={() => {
                onSelect(i);
                onClose();
              }}
            >
              {label}
            </button>
          ))}
          <button
            type="button"
            className="nav-drawer-item"
            onClick={() => {
              onOpenAi();
              onClose();
            }}
          >
            {UiStrings.navAI}
          </button>
        </div>
      </div>
    </>
  );
}

/// Top navigation: inline text links on desktop/laptop, hamburger + slide-in
/// drawer on phones.
export default function NavBar({ activeIndex, onSelect, onOpenAi }) {
  const width = useWindowWidth();
  const isMobile = width < MOBILE_BREAKPOINT;
  const [drawerOpen, setDrawerOpen] = useState(false);

  useEffect(() => {
    if (!isMobile) setDrawerOpen(false);
  }, [isMobile]);

  if (isMobile) {
    return (
      <nav className="nav-bar">
        <Brand />
        <div className="nav-mobile-actions">
          <LanguageToggle />
          <button
          type="button"
          className="nav-hamburger"
          onClick={() => setDrawerOpen(true)}
          aria-label={UiStrings.openMenu}
          aria-expanded={drawerOpen}
        >
          <FaIcon icon="bars" size={18} />
          </button>
        </div>
        <MobileDrawer
          open={drawerOpen}
          onClose={() => setDrawerOpen(false)}
          activeIndex={activeIndex}
          onSelect={onSelect}
          onOpenAi={onOpenAi}
        />
      </nav>
    );
  }

  return (
    <nav className="nav-bar">
      <Brand />
      <div className="nav-links">
        {navItems().map((label, i) => (
          <button
            key={label}
            type="button"
            className={`nav-link ${activeIndex === i ? 'active' : ''}`}
            onClick={() => onSelect(i)}
          >
            {label}
          </button>
        ))}
        <button type="button" className="nav-link nav-link-ai" onClick={onOpenAi}>
          {UiStrings.navAI}
        </button>
        <LanguageToggle />
      </div>
    </nav>
  );
}
