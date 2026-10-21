import Section from './Section';
import SectionHeader from './SectionHeader';
import GlassPanel from './GlassPanel';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import { aboutHighlights } from '../data/portfolioProfileContent';
import './About.css';

export default function About({ sectionRef }) {
  return (
    <Section id="about" sectionRef={sectionRef} className="split">
      <SectionHeader title={UiStrings.aboutMe} />
      <GlassPanel>
        <p className="about-paragraph lead">{PortfolioKnowledge.aboutParagraph1}</p>
        <p className="about-paragraph">{PortfolioKnowledge.aboutParagraph2}</p>
        <div className="about-highlights stagger">
          {aboutHighlights.map((h) => (
            <span className="about-chip" key={h}>{h}</span>
          ))}
        </div>
      </GlassPanel>
    </Section>
  );
}
