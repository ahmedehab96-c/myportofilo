import { useEffect, useRef, useState } from 'react';

/// Scroll-triggered entrance (fade + 3D tilt + slide), mirrors PremiumEntrance.
export function useReveal(delayMs = 0) {
  const ref = useRef(null);
  const [inView, setInView] = useState(false);

  useEffect(() => {
    const el = ref.current;
    if (!el) return undefined;
    if (typeof IntersectionObserver === 'undefined') {
      setInView(true);
      return undefined;
    }

    let delayTimer;
    const fallbackTimer = setTimeout(() => setInView(true), 2400);

    const observer = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          if (entry.isIntersecting) {
            delayTimer = setTimeout(() => setInView(true), delayMs);
            observer.disconnect();
          }
        }
      },
      { threshold: 0.05, rootMargin: '0px 0px -6% 0px' },
    );
    observer.observe(el);

    return () => {
      observer.disconnect();
      clearTimeout(delayTimer);
      clearTimeout(fallbackTimer);
    };
  }, [delayMs]);

  return { ref, className: `reveal${inView ? ' in-view' : ''}` };
}
