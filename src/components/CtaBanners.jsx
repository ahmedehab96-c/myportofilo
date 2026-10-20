import { Link } from 'react-router-dom';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import './CtaBanners.css';

export function ResumeButton({ onLaunch }) {
  return (
    <div className="cta-row">
      <button type="button" className="resume-btn" onClick={() => onLaunch(PortfolioKnowledge.cvUrl)}>
        <FaIcon icon="filePdf" size={14} />
        <span>{UiStrings.downloadCv}</span>
      </button>
      <AIChatLink />
    </div>
  );
}

function AIChatLink() {
  return (
    <Link to="/ai" className="ai-chat-link">
      {UiStrings.chatWithAI} <span aria-hidden="true">→</span>
    </Link>
  );
}

export function Footer() {
  const year = new Date().getFullYear();
  return (
    <footer className="portfolio-footer">
      <p>© {year} {PortfolioKnowledge.fullName}</p>
    </footer>
  );
}
