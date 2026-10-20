import FaIcon from './icons/FaIcon';
import HeroStatsStrip from './HeroStatsStrip';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import { role } from '../data/portfolioProfileContent';
import './Hero.css';

const HERO_TECH_HIGHLIGHTS = ['React.js', 'Flutter', 'Laravel', 'Firebase', 'Supabase', 'AI', 'REST APIs'];

export default function Hero({ onScrollToSection, onLaunch }) {
  return (
    <section className="hero">
      <div className="hero-text-col">
        <p className="hero-role">{role}</p>

        <h1 className="hero-name">{PortfolioKnowledge.fullName}</h1>

        <p className="hero-tagline">{UiStrings.heroTagline}</p>

        <p className="hero-tech">{HERO_TECH_HIGHLIGHTS.join(' · ')}</p>

        <div className="hero-actions">
          <button type="button" className="hero-btn primary" onClick={() => onScrollToSection(4)}>
            {UiStrings.viewProjects}
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
            {UiStrings.downloadCv}
          </button>
          <button type="button" className="hero-link" onClick={() => onScrollToSection(5)}>
            {UiStrings.contactMe}
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
        <img className="hero-photo" src="/assets/images/ahmed_profile.png" alt={PortfolioKnowledge.fullName} />
      </div>
    </section>
  );
}
