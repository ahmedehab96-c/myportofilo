import { useEffect, useRef, useState } from 'react';

/// Parses values like `4+`, `95%`, `12,540` and counts up to them,
/// mirrors AnimatedStatValue.
function parseStat(raw) {
  const trimmed = raw.trim();
  const match = /^([\d,]+(?:\.\d+)?)(.*)$/.exec(trimmed);
  if (!match) return { text: trimmed };
  const numberPart = match[1].replace(/,/g, '');
  const suffix = match[2] || '';
  const target = parseFloat(numberPart);
  if (Number.isNaN(target)) return { text: trimmed };
  return { target, suffix, hasCommas: raw.includes(',') };
}

function withCommas(n) {
  return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function easeOutCubic(t) {
  return 1 - Math.pow(1 - t, 3);
}

export function useCountUp(value, { duration = 900 } = {}) {
  const parsed = parseStat(value);
  const [display, setDisplay] = useState(parsed.target == null ? value : `0${parsed.suffix}`);
  const startedRef = useRef(false);

  useEffect(() => {
    if (parsed.target == null || startedRef.current) return undefined;
    startedRef.current = true;
    let raf;
    const start = performance.now();

    const tick = (now) => {
      const t = Math.min(1, (now - start) / duration);
      const n = parsed.target * easeOutCubic(t);
      const rounded = Math.round(n);
      const body = parsed.hasCommas ? withCommas(rounded) : String(rounded);
      setDisplay(`${body}${parsed.suffix}`);
      if (t < 1) raf = requestAnimationFrame(tick);
    };

    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return display;
}
