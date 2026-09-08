import FaIcon from './icons/FaIcon';
import HeroStatsStrip from './HeroStatsStrip';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import { role } from '../data/portfolioProfileContent';
import { useTypewriter } from '../hooks/useTypewriter';
import './Hero.css';

const HERO_FULL_NAME = 'AHMED EHAB MOHAMMED';

const HERO_TECH_HIGHLIGHTS = ['React.js', 'Flutter', 'Laravel', 'Firebase', 'Supabase', 'AI', 'REST APIs'];

export default function Hero({ onScrollToSection, onLaunch }) {
  const { text: displayedName, showCursor } = useTypewriter(HERO_FULL_NAME);

  const ctaSpecs = [
    { icon: 'briefcase', label: UiStrings.viewProjects, primary: true, onClick: () => onScrollToSection(4) },
    {
      icon: 'envelope',
      label: UiStrings.hireMe,
      primary: true,
      onClick: () => onLaunch(`mailto:${PortfolioKnowledge.email}?subject=Project%20Inquiry`),
    },
    { icon: 'phone', label: UiStrings.contactMe, primary: false, onClick: () => onScrollToSection(5) },
    { icon: 'filePdf', label: UiStrings.downloadCv, primary: false, onClick: () => onLaunch(PortfolioKnowledge.cvUrl) },
  ];

  return (
    <section className="hero">
      <div className="hero-text-col">
        <div className="hero-badge">
          <FaIcon icon="webMobile" size={18} color="var(--accent)" />
          <span>{role}</span>
        </div>

        <h1 className="hero-name">
          {displayedName || ' '}
          {showCursor && <span className="blinking-cursor hero-cursor" />}
        </h1>

        <p className="hero-tagline">{UiStrings.heroTagline}</p>

        <div className="hero-tech-strip">
          {HERO_TECH_HIGHLIGHTS.map((t) => (
            <span className="hero-tech-chip" key={t}>{t}</span>
          ))}
        </div>

        <HeroStatsStrip
          items={[
            { value: PortfolioKnowledge.yearsOfExperience, label: UiStrings.yearsExp, icon: 'briefcase' },
            { value: '20+', label: UiStrings.statProjects, icon: 'folderOpen' },
            { value: '6+', label: UiStrings.statTechnologies, icon: 'code' },
          ]}
        />

        <div className="hero-cta-grid">
          {ctaSpecs.map((c) => (
            <button
              key={c.label}
              type="button"
              className={`hero-cta ${c.primary ? 'primary' : 'outline'}`}
              onClick={c.onClick}
            >
              <FaIcon icon={c.icon} size={16} color={c.primary ? 'var(--on-accent)' : 'var(--text-primary)'} />
              <span>{c.label}</span>
            </button>
          ))}
        </div>
      </div>

      <div className="hero-photo-col">
        <div className="hero-photo-frame">
          <img src="/assets/images/ahmed_profile.png" alt={PortfolioKnowledge.fullName} />
        </div>
      </div>
    </section>
  );
}
