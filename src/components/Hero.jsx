import FaIcon from './icons/FaIcon';
import HeroStatsStrip from './HeroStatsStrip';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import './Hero.css';

const HERO_TECH_HIGHLIGHTS = ['React.js', 'Flutter', 'Laravel', 'Firebase', 'Supabase', 'AI', 'REST APIs'];

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

// Each word fades in, holds, fades out and comes back, on a loop.
function AnimatedName({ name }) {
  return (
    <h1 className="hero-name">
      {name.split(' ').map((word, i) => (
        <span className="hero-name-word" style={{ '--i': i }} key={word}>
          {word}{' '}
        </span>
      ))}
    </h1>
  );
}

export default function Hero({ onScrollToSection, onLaunch }) {
  return (
    <section className="hero">
      <div className="hero-text-col">
        <p className="hero-role">
          {PortfolioKnowledge.role}
        </p>

        <AnimatedName name={PortfolioKnowledge.fullName} />

        <p className="hero-tagline">{UiStrings.heroTagline}</p>

        <p className="hero-tech">{HERO_TECH_HIGHLIGHTS.join(' / ')}</p>

        <div className="hero-actions">
          <button type="button" className="hero-btn primary" onClick={() => onScrollToSection(4)}>
            {UiStrings.viewProjects}
            <span className="hero-btn-arrow flip-rtl" aria-hidden="true">→</span>
          </button>
          <button type="button" className="hero-link" onClick={() => onLaunch(PortfolioKnowledge.cvUrl)}>
            <FaIcon icon="filePdf" size={14} />
            <span>{UiStrings.downloadCv}</span>
          </button>
        </div>

        <HeroStatsStrip
          items={[
            { value: PortfolioKnowledge.yearsOfExperience, label: UiStrings.statYears },
            { value: '20+', label: UiStrings.statShipped },
            { value: '6+', label: UiStrings.statCore },
          ]}
        />
      </div>

      <div className="hero-photo-col">
        <div className="hero-photo-frame">
          <img className="hero-photo" src="/assets/images/ahmed_profile_cutout.webp" alt={PortfolioKnowledge.fullName} />
        </div>
      </div>
    </section>
  );
}
