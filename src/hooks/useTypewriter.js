import { useEffect, useState } from 'react';

function prefersReducedMotion() {
  return typeof window !== 'undefined' && window.matchMedia?.('(prefers-reduced-motion: reduce)').matches;
}

/// Types `text` one character at a time. With `loop`, it holds the full text,
/// erases it, and types it again indefinitely. With reduced motion the full
/// text is returned immediately and nothing animates.
export function useTypewriter(
  text,
  { startDelay = 400, speed = 65, deleteSpeed = 35, hold = 2600, pause = 500, loop = false } = {},
) {
  const [reduced] = useState(prefersReducedMotion);
  const [count, setCount] = useState(reduced ? text.length : 0);
  const [phase, setPhase] = useState(reduced ? 'done' : 'typing');

  useEffect(() => {
    if (reduced) return undefined;
    let timer;
    let i = 0;

    const type = () => {
      i += 1;
      setCount(i);
      if (i < text.length) {
        // Slight jitter, with a short pause after spaces, reads as natural typing.
        timer = setTimeout(type, speed + Math.random() * 40 + (text[i - 1] === ' ' ? 90 : 0));
      } else if (loop) {
        setPhase('holding');
        timer = setTimeout(erase, hold);
      } else {
        setPhase('done');
      }
    };

    const erase = () => {
      setPhase('deleting');
      i -= 1;
      setCount(i);
      if (i > 0) {
        timer = setTimeout(erase, deleteSpeed);
      } else {
        timer = setTimeout(() => {
          setPhase('typing');
          type();
        }, pause);
      }
    };

    setCount(0);
    setPhase('typing');
    timer = setTimeout(type, startDelay);
    return () => clearTimeout(timer);
  }, [text, startDelay, speed, deleteSpeed, hold, pause, loop, reduced]);

  return { text: text.slice(0, count), phase, done: phase === 'done', reduced };
}
