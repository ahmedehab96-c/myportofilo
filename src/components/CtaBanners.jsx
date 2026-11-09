import { Link } from 'react-router-dom';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import './CtaBanners.css';

export function ResumeButton({ onLaunch }) {
  return (
    <div className="cta-row">
      <div className="cta-row-text">
        <h2>{UiStrings.ctaTitle}</h2>
        <p>{UiStrings.getInTouchSubtitle}</p>
      </div>
      <div className="cta-row-actions">
        <button type="button" className="resume-btn" onClick={() => onLaunch(PortfolioKnowledge.cvUrl)}>
          <FaIcon icon="filePdf" size={14} />
          <span>{UiStrings.downloadCv}</span>
        </button>
        <AIChatLink />
      </div>
    </div>
  );
}

function AIChatLink() {
  return (
    <Link to="/ai" className="ai-chat-link">
      {UiStrings.chatWithAI} <span className="flip-rtl" aria-hidden="true">→</span>
    </Link>
  );
}

const socials = [
  { icon: 'linkedin', label: 'LinkedIn', url: 'https://www.linkedin.com/in/ahmed-ehab-ba8a63285' },
  { icon: 'github', label: 'GitHub', url: 'https://github.com/ahmedehab96-c' },
  { icon: 'envelope', label: 'Email', url: `mailto:${PortfolioKnowledge.email}` },
];

export function Footer() {
  const year = new Date().getFullYear();
  return (
    <footer className="portfolio-footer">
      <div className="footer-brand">
        <strong>{PortfolioKnowledge.fullName}</strong>
        <span>{PortfolioKnowledge.role}</span>
      </div>
      <p>© {year} {PortfolioKnowledge.fullName}</p>
      <div className="footer-socials">
        {socials.map((s) => (
          <a key={s.label} href={s.url} target="_blank" rel="noreferrer" aria-label={s.label}>
            <FaIcon icon={s.icon} size={15} />
          </a>
        ))}
      </div>
    </footer>
  );
}
