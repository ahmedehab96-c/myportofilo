import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import './Hero.css';

const HERO_TECH_HIGHLIGHTS = ['React.js', 'Flutter', 'Laravel', 'Firebase', 'Supabase', 'REST APIs'];

/// Words wipe in, hold, then wipe out on a loop. Whole words keep Arabic letters joined.
function AnimatedName({ name }) {
  return (
    <h1 className="hero-name" aria-label={name}>
      {name.split(' ').map((word, i) => (
        <span className="hero-name-word" style={{ '--i': i }} key={word} aria-hidden="true">
          {word}
        </span>
      ))}
    </h1>
  );
}

export default function Hero({ onScrollToSection, onLaunch }) {
  return (
    <section className="hero">
      <div className="hero-text-col">
        <p className="hero-hello">{UiStrings.helloIm}</p>
        <AnimatedName name={PortfolioKnowledge.fullName} />
        <p className="hero-role">{PortfolioKnowledge.role}</p>
        <p className="hero-tagline">{UiStrings.heroTagline}</p>

        <div className="hero-actions">
          <button type="button" className="hero-btn primary" onClick={() => onScrollToSection(4)}>
            {UiStrings.viewProjects}
            <span className="hero-btn-arrow flip-rtl" aria-hidden="true">→</span>
          </button>
          <button type="button" className="hero-btn" onClick={() => onLaunch(PortfolioKnowledge.cvUrl)}>
            <FaIcon icon="filePdf" size={14} />
            {UiStrings.downloadCv}
          </button>
        </div>

        <ul className="hero-tech">
          {HERO_TECH_HIGHLIGHTS.map((t) => (
            <li key={t}>{t}</li>
          ))}
        </ul>
      </div>

      <div className="hero-photo-col">
        <img className="hero-photo" src="/assets/images/ahmed_profile_cutout.webp" alt={PortfolioKnowledge.fullName} />
      </div>
    </section>
  );
}
