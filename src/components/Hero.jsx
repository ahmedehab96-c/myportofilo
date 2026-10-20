import FaIcon from './icons/FaIcon';
import HeroStatsStrip from './HeroStatsStrip';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import { role } from '../data/portfolioProfileContent';
import { useTypewriter } from '../hooks/useTypewriter';
import './Hero.css';

const HERO_TECH_HIGHLIGHTS = ['React.js', 'Flutter', 'Laravel', 'Firebase', 'Supabase', 'AI', 'REST APIs'];

function TypedName({ name }) {
  const { text, phase, reduced } = useTypewriter(name, { loop: true });

  return (
    <h1 className="hero-name" aria-label={name}>
      {/* Invisible copy reserves the final size so nothing shifts while typing. */}
      <span className="hero-name-ghost" aria-hidden="true">{name}</span>
      <span className="hero-name-typed" aria-hidden="true">
        {text}
        {!reduced && <span className={`hero-cursor ${phase}`} />}
      </span>
    </h1>
  );
}

export default function Hero({ onScrollToSection, onLaunch }) {
  return (
    <section className="hero">
      <div className="hero-text-col">
        <p className="hero-role">
          <span className="hero-role-dot" aria-hidden="true" />
          {role}
        </p>

        <TypedName name={PortfolioKnowledge.fullName} />

        <p className="hero-tagline">{UiStrings.heroTagline}</p>

        <ul className="hero-tech">
          {HERO_TECH_HIGHLIGHTS.map((t) => (
            <li key={t}>{t}</li>
          ))}
        </ul>

        <div className="hero-actions">
          <button type="button" className="hero-btn primary" onClick={() => onScrollToSection(4)}>
            {UiStrings.viewProjects}
            <span className="hero-btn-arrow" aria-hidden="true">→</span>
          </button>
          <button
            type="button"
            className="hero-btn"
            onClick={() => onLaunch(`mailto:${PortfolioKnowledge.email}?subject=Project%20Inquiry`)}
          >
            {UiStrings.hireMe}
          </button>
          <button type="button" className="hero-link" onClick={() => onLaunch(PortfolioKnowledge.cvUrl)}>
            <FaIcon icon="filePdf" size={14} />
            <span>{UiStrings.downloadCv}</span>
          </button>
          <button type="button" className="hero-link" onClick={() => onScrollToSection(5)}>
            <span>{UiStrings.contactMe}</span>
          </button>
        </div>

        <HeroStatsStrip
          items={[
            { value: PortfolioKnowledge.yearsOfExperience, label: 'years building software' },
            { value: '20+', label: 'projects shipped' },
            { value: '6+', label: 'core technologies' },
          ]}
        />
      </div>

      <div className="hero-photo-col">
        <div className="hero-photo-frame">
          <img className="hero-photo" src="/assets/images/ahmed_profile.png" alt={PortfolioKnowledge.fullName} />
        </div>
      </div>
    </section>
  );
}
