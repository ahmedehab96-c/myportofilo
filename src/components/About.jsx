import Section from './Section';
import SectionHeader from './SectionHeader';
import GlassPanel from './GlassPanel';
import { UiStrings } from '../data/uiStrings';
import { aboutParagraph1, aboutParagraph2, aboutHighlights } from '../data/portfolioProfileContent';
import './About.css';

export default function About({ sectionRef }) {
  return (
    <Section id="about" sectionRef={sectionRef}>
      <SectionHeader title={UiStrings.aboutMe} />
      <GlassPanel>
        <p className="about-paragraph">{aboutParagraph1}</p>
        <p className="about-paragraph">{aboutParagraph2}</p>
        <div className="about-highlights">
          {aboutHighlights.map((h) => (
            <span className="about-chip" key={h}>{h}</span>
          ))}
        </div>
      </GlassPanel>
    </Section>
  );
}
