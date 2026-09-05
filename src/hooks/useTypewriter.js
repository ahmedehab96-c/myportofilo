import { useEffect, useState } from 'react';

/// Type / hold / erase / pause loop for the hero name, mirrors
/// _startLetterAnimation in the original portfolio_screen.dart.
export function useTypewriter(
  fullText,
  { typeMs = 42, eraseMs = 28, holdMs = 450, pauseMs = 220 } = {},
) {
  const [text, setText] = useState('');
  const [showCursor, setShowCursor] = useState(true);

  useEffect(() => {
    let index = 0;
    let erasing = false;
    let timer;

    const tick = () => {
      if (!erasing) {
        if (index < fullText.length) {
          index += 1;
          setText(fullText.slice(0, index));
          setShowCursor(index < fullText.length);
          timer = setTimeout(tick, typeMs);
          return;
        }
        setShowCursor(false);
        timer = setTimeout(() => {
          erasing = true;
          tick();
        }, holdMs);
        return;
      }

      if (index > 0) {
        index -= 1;
        setText(fullText.slice(0, index));
        timer = setTimeout(tick, eraseMs);
        return;
      }

      setText('');
      erasing = false;
      timer = setTimeout(tick, pauseMs);
    };

    tick();
    return () => clearTimeout(timer);
  }, [fullText, typeMs, eraseMs, holdMs, pauseMs]);

  return { text, showCursor };
}
