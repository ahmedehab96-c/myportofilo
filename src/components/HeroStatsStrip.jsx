import { useEffect, useState } from 'react';
import './HeroStatsStrip.css';

const COUNT_MS = 900;

/// Counts the numeric part up on load; any suffix such as "+" stays put.
function CountUp({ value }) {
  const [, digits, suffix] = String(value).match(/^(\d+)(.*)$/) ?? [];
  const target = Number(digits);
  const [current, setCurrent] = useState(() =>
    window.matchMedia('(prefers-reduced-motion: reduce)').matches ? target : 0,
  );

  useEffect(() => {
    if (digits === undefined || current === target) return undefined;
    const start = performance.now();
    let raf;
    const tick = (now) => {
      const t = Math.min((now - start) / COUNT_MS, 1);
      setCurrent(Math.round(target * (1 - (1 - t) ** 3)));
      if (t < 1) raf = requestAnimationFrame(tick);
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
    // Runs once per value; `current` only seeds the reduced-motion case.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [digits, target]);

  return digits === undefined ? value : `${current}${suffix}`;
}

export default function HeroStatsStrip({ items }) {
  return (
    <dl className="hero-stats">
      {items.map((item) => (
        <div className="hero-stat" key={item.label}>
          <dt><CountUp value={item.value} /></dt>
          <dd>{item.label}</dd>
        </div>
      ))}
    </dl>
  );
}
