import { useEffect, useState } from 'react';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { useWindowWidth } from '../hooks/useWindowWidth';
import './NavBar.css';

const MOBILE_BREAKPOINT = 768;

const NAV_ITEMS = [
  UiStrings.navAbout,
  UiStrings.navEducation,
  UiStrings.navSkills,
  UiStrings.navServices,
  UiStrings.navProjects,
  UiStrings.navContact,
];

export { NAV_ITEMS };

function Brand() {
  return (
    <button type="button" className="nav-brand" onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}>
      <span className="nav-brand-mark" aria-hidden="true">A</span>
      Ahmed Ehab
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
        <button type="button" className="nav-drawer-close" onClick={onClose} aria-label="Close menu">
          <FaIcon icon="xmark" size={18} />
        </button>
        <div className="nav-drawer-items">
          {NAV_ITEMS.map((label, i) => (
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
        <button
          type="button"
          className="nav-hamburger"
          onClick={() => setDrawerOpen(true)}
          aria-label="Open menu"
          aria-expanded={drawerOpen}
        >
          <FaIcon icon="bars" size={18} />
        </button>
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
        {NAV_ITEMS.map((label, i) => (
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
      </div>
    </nav>
  );
}
