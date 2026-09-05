import { useState } from 'react';
import FaIcon from './icons/FaIcon';
import { useCountUp } from '../hooks/useCountUp';
import { useReveal } from '../hooks/useReveal';
import './HeroStatsStrip.css';

function StatCell({ value, label, icon }) {
  const [hovered, setHovered] = useState(false);
  const display = useCountUp(value);

  return (
    <div
      className={`stat-cell ${hovered ? 'hovered' : ''}`}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      <FaIcon icon={icon} size={16} color="var(--accent)" style={{ opacity: hovered ? 1 : 0.75 }} />
      <span className="stat-value">{display}</span>
      <span className="stat-label">{label}</span>
    </div>
  );
}

export default function HeroStatsStrip({ items }) {
  const { ref, className } = useReveal(170);

  return (
    <div ref={ref} className={`hero-stats-strip ${className}`}>
      <div className="hero-stats-accent" />
      <div className="hero-stats-row">
        {items.map((item, i) => (
          <div className="hero-stats-item" key={item.label}>
            {i > 0 && <span className="hero-stats-divider" />}
            <StatCell {...item} />
          </div>
        ))}
      </div>
    </div>
  );
}
