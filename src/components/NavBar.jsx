import { forwardRef, useEffect, useRef, useState } from 'react';
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

const NavPill = forwardRef(function NavPill({ label, active, onClick }, ref) {
  const [hovering, setHovering] = useState(false);
  const highlighted = hovering && !active;

  return (
    <button
      ref={ref}
      type="button"
      className={`nav-pill ${active ? 'active' : ''} ${highlighted ? 'highlighted' : ''}`}
      onMouseEnter={() => setHovering(true)}
      onMouseLeave={() => setHovering(false)}
      onClick={onClick}
    >
      {label}
    </button>
  );
});

function NavAiButton({ onClick }) {
  const [hovering, setHovering] = useState(false);
  return (
    <button
      type="button"
      className={`nav-ai-button ${hovering ? 'hovering' : ''}`}
      onMouseEnter={() => setHovering(true)}
      onMouseLeave={() => setHovering(false)}
      onClick={onClick}
    >
      <FaIcon icon="robot" size={15} color="#fff" />
      <span>{UiStrings.navAIShort}</span>
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
        </div>
        <button
          type="button"
          className="nav-ai-button nav-drawer-ai"
          onClick={() => {
            onOpenAi();
            onClose();
          }}
        >
          <FaIcon icon="robot" size={15} color="#fff" />
          <span>{UiStrings.navAIShort}</span>
        </button>
      </div>
    </>
  );
}

/// Top navigation: horizontal pill bar on desktop/laptop, hamburger + slide-in
/// drawer on phones.
export default function NavBar({ activeIndex, onSelect, onOpenAi }) {
  const rowRef = useRef(null);
  const pillRefs = useRef([]);
  const [indicator, setIndicator] = useState({ left: 0, width: 0, ready: false });
  const width = useWindowWidth();
  const isMobile = width < MOBILE_BREAKPOINT;
  const [drawerOpen, setDrawerOpen] = useState(false);

  useEffect(() => {
    if (isMobile) return;
    const sync = () => {
      const row = rowRef.current;
      const pill = pillRefs.current[activeIndex];
      if (!row || !pill) return;
      const rowRect = row.getBoundingClientRect();
      const pillRect = pill.getBoundingClientRect();
      setIndicator({ left: pillRect.left - rowRect.left, width: pillRect.width, ready: true });
    };
    sync();
    window.addEventListener('resize', sync);
    return () => window.removeEventListener('resize', sync);
  }, [activeIndex, isMobile]);

  useEffect(() => {
    if (!isMobile) setDrawerOpen(false);
  }, [isMobile]);

  if (isMobile) {
    return (
      <div className="nav-bar-wrap">
        <div className="nav-bar-shell nav-bar-shell-mobile">
          <div className="nav-bar-sheen" />
          <div className="nav-bar-inner nav-bar-inner-mobile">
            <button
              type="button"
              className="nav-hamburger"
              onClick={() => setDrawerOpen(true)}
              aria-label="Open menu"
              aria-expanded={drawerOpen}
            >
              <FaIcon icon="bars" size={18} />
            </button>
            <NavAiButton onClick={onOpenAi} />
          </div>
        </div>
        <MobileDrawer
          open={drawerOpen}
          onClose={() => setDrawerOpen(false)}
          activeIndex={activeIndex}
          onSelect={onSelect}
          onOpenAi={onOpenAi}
        />
      </div>
    );
  }

  return (
    <div className="nav-bar-wrap">
      <div className="nav-bar-shell">
        <div className="nav-bar-sheen" />
        <div className="nav-bar-inner">
          <div className="nav-bar-scroll">
            <div className="nav-bar-row" ref={rowRef}>
              <span
                className="nav-bar-indicator"
                style={{
                  left: indicator.left,
                  width: indicator.width,
                  opacity: indicator.ready ? 1 : 0,
                }}
              />
              {NAV_ITEMS.map((label, i) => (
                <NavPill
                  key={label}
                  ref={(el) => (pillRefs.current[i] = el)}
                  label={label}
                  active={activeIndex === i}
                  onClick={() => onSelect(i)}
                />
              ))}
            </div>
          </div>
          <span className="nav-bar-divider" />
          <NavAiButton onClick={onOpenAi} />
        </div>
      </div>
    </div>
  );
}
