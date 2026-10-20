import { useEffect, useRef } from 'react';
import './PortfolioBackground.css';

/// Soft ambient backdrop: warm paper tone with slowly drifting color fields
/// that drift at different depths as the page scrolls.
export default function PortfolioBackground() {
  const ref = useRef(null);

  useEffect(() => {
    const el = ref.current;
    if (!el || window.matchMedia('(prefers-reduced-motion: reduce)').matches) return undefined;
    let raf;
    const onScroll = () => {
      cancelAnimationFrame(raf);
      raf = requestAnimationFrame(() => el.style.setProperty('--scroll', window.scrollY.toFixed(0)));
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
    return () => {
      window.removeEventListener('scroll', onScroll);
      cancelAnimationFrame(raf);
    };
  }, []);

  return (
    <div ref={ref} className="portfolio-background" aria-hidden="true">
      <span className="pb-orb pb-orb-a" />
      <span className="pb-orb pb-orb-b" />
      <span className="pb-orb pb-orb-c" />
      <span className="pb-dots" />
    </div>
  );
}
