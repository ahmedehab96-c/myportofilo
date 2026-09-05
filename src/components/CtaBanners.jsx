import { Link } from 'react-router-dom';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import './CtaBanners.css';

export function ResumeButton({ onLaunch }) {
  return (
    <div className="cta-banner-wrap">
      <button type="button" className="resume-btn" onClick={() => onLaunch(PortfolioKnowledge.cvUrl)}>
        <FaIcon icon="filePdf" size={22} color="var(--on-accent)" />
        <span>{UiStrings.downloadCv}</span>
      </button>
    </div>
  );
}

export function AIChatBanner() {
  return (
    <div className="cta-banner-wrap">
      <Link to="/ai" className="ai-chat-btn">
        <FaIcon icon="robot" size={24} color="#fff" />
        <span>{UiStrings.chatWithAI}</span>
      </Link>
    </div>
  );
}

export function Footer() {
  const year = new Date().getFullYear();
  return (
    <footer className="portfolio-footer">
      <p>© {year} Ahmed&apos;s Portfolio</p>
    </footer>
  );
}
