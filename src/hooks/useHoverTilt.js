import { useCallback, useRef, useState } from 'react';

/// Hover / tilt / lift interaction shell, mirrors PremiumHoverCard.
export function useHoverTilt({ maxTilt = 5, lift = 8, scale = 1.02 } = {}) {
  const ref = useRef(null);
  const [hovered, setHovered] = useState(false);
  const [tilt, setTilt] = useState({ x: 0, y: 0 });

  const onMouseMove = useCallback((e) => {
    const el = ref.current;
    if (!el) return;
    const rect = el.getBoundingClientRect();
    const px = (e.clientX - rect.left) / rect.width - 0.5;
    const py = (e.clientY - rect.top) / rect.height - 0.5;
    setTilt({ x: px * 2, y: py * 2 });
  }, []);

  const onMouseEnter = useCallback(() => setHovered(true), []);
  const onMouseLeave = useCallback(() => {
    setHovered(false);
    setTilt({ x: 0, y: 0 });
  }, []);

  const style = {
    transform: hovered
      ? `perspective(900px) rotateX(${(-tilt.y * maxTilt).toFixed(2)}deg) rotateY(${(tilt.x * maxTilt).toFixed(2)}deg) translateY(-${lift}px) scale(${scale})`
      : 'perspective(900px) rotateX(0deg) rotateY(0deg) translateY(0) scale(1)',
  };

  return { ref, hovered, style, handlers: { onMouseMove, onMouseEnter, onMouseLeave } };
}
