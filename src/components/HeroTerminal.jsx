import { useEffect, useState } from 'react';
import './HeroTerminal.css';

const STEPS = [
  { cmd: 'flutter build apk --release', out: '✓ Built app-release.apk' },
  { cmd: 'php artisan test', out: 'PASS  all tests' },
  { cmd: 'npm run build', out: '✓ built for production' },
  { cmd: 'git push origin main', out: 'main -> main' },
];

const TYPE_MS = 45;
const HOLD_MS = 2200;

/// Small terminal over the portrait, cycling through everyday build commands.
export default function HeroTerminal() {
  const [reduced] = useState(() => window.matchMedia('(prefers-reduced-motion: reduce)').matches);
  const [step, setStep] = useState(0);
  const [typed, setTyped] = useState(reduced ? STEPS[0].cmd.length : 0);

  const { cmd, out } = STEPS[step];
  const done = typed >= cmd.length;

  useEffect(() => {
    if (reduced) return undefined;
    const timer = done
      ? setTimeout(() => {
          setStep((s) => (s + 1) % STEPS.length);
          setTyped(0);
        }, HOLD_MS)
      : setTimeout(() => setTyped((n) => n + 1), TYPE_MS);
    return () => clearTimeout(timer);
  }, [reduced, done, typed]);

  return (
    <div className="hero-terminal" dir="ltr" aria-hidden="true">
      <div className="hero-terminal-line">
        <span className="hero-terminal-prompt">$</span> {cmd.slice(0, typed)}
        {!done && <span className="hero-terminal-cursor" />}
      </div>
      <div className={`hero-terminal-out ${done ? 'show' : ''}`}>{out}</div>
    </div>
  );
}
