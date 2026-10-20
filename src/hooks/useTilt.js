import { useCallback, useRef } from 'react';

const tiltQuery =
  typeof window !== 'undefined' && window.matchMedia
    ? window.matchMedia('(hover: hover) and (pointer: fine) and (prefers-reduced-motion: no-preference)')
    : null;

/// Pointer-driven 3D tilt: writes --px / --py (-0.5…0.5) on the element so CSS
/// decides the rotation, depth and glare. Inert on touch and reduced motion.
export function useTilt() {
  const frame = useRef(0);

  const onPointerMove = useCallback((e) => {
    if (!tiltQuery?.matches || e.pointerType !== 'mouse') return;
    const el = e.currentTarget;
    const { clientX, clientY } = e;
    cancelAnimationFrame(frame.current);
    frame.current = requestAnimationFrame(() => {
      const rect = el.getBoundingClientRect();
      el.style.setProperty('--px', ((clientX - rect.left) / rect.width - 0.5).toFixed(3));
      el.style.setProperty('--py', ((clientY - rect.top) / rect.height - 0.5).toFixed(3));
    });
  }, []);

  const onPointerLeave = useCallback((e) => {
    cancelAnimationFrame(frame.current);
    e.currentTarget.style.setProperty('--px', '0');
    e.currentTarget.style.setProperty('--py', '0');
  }, []);

  return { onPointerMove, onPointerLeave };
}
