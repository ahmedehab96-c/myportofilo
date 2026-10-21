import { useEffect, useRef } from 'react';
import './PortfolioBackground.css';

/// Dark ambient backdrop: slowly drifting color fields
/// that drift at different depths as the page scrolls, plus a pointer spotlight.
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
    let pointerRaf;
    const onPointer = (e) => {
      cancelAnimationFrame(pointerRaf);
      pointerRaf = requestAnimationFrame(() => {
        el.style.setProperty('--mx', `${e.clientX}px`);
        el.style.setProperty('--my', `${e.clientY}px`);
      });
    };
    const finePointer = window.matchMedia('(hover: hover) and (pointer: fine)').matches;
    window.addEventListener('scroll', onScroll, { passive: true });
    if (finePointer) window.addEventListener('pointermove', onPointer, { passive: true });
    onScroll();
    return () => {
      window.removeEventListener('scroll', onScroll);
      window.removeEventListener('pointermove', onPointer);
      cancelAnimationFrame(raf);
      cancelAnimationFrame(pointerRaf);
    };
  }, []);

  return (
    <div ref={ref} className="portfolio-background" aria-hidden="true">
      <span className="pb-orb pb-orb-a" />
      <span className="pb-orb pb-orb-b" />
      <span className="pb-orb pb-orb-c" />
      <span className="pb-beam" />
      <span className="pb-dots" />
      <span className="pb-spot" />
    </div>
  );
}
