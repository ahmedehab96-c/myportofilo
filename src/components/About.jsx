import Section from './Section';
import SectionHeader from './SectionHeader';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import { aboutHighlights } from '../data/portfolioProfileContent';
import './About.css';

export default function About({ sectionRef }) {
  return (
    <Section id="about" sectionRef={sectionRef} className="split">
      <SectionHeader title={UiStrings.aboutMe} />
      <div className="about-body">
        <p className="about-paragraph lead">{PortfolioKnowledge.aboutParagraph1}</p>
        <p className="about-paragraph">{PortfolioKnowledge.aboutParagraph2}</p>
        <p className="about-highlights">{aboutHighlights.join(' · ')}</p>
      </div>
    </Section>
  );
}
