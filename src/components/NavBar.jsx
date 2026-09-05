import { forwardRef, useEffect, useRef, useState } from 'react';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import './NavBar.css';

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

/// Top navigation bar with sliding active indicator, mirrors PortfolioNavBar.
export default function NavBar({ activeIndex, onSelect, onOpenAi }) {
  const rowRef = useRef(null);
  const pillRefs = useRef([]);
  const [indicator, setIndicator] = useState({ left: 0, width: 0, ready: false });

  useEffect(() => {
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
  }, [activeIndex]);

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
