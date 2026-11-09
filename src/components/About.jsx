import Section from './Section';
import SectionHeader from './SectionHeader';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { PortfolioKnowledge } from '../data/portfolioKnowledge';
import './About.css';

export default function About({ sectionRef, onLaunch }) {
  const highlights = [
    `${PortfolioKnowledge.yearsOfExperience} ${UiStrings.statYears}`,
    `20+ ${UiStrings.statShipped}`,
    `6+ ${UiStrings.statCore}`,
    UiStrings.openToWork,
  ];
  const info = [
    { icon: 'location', label: UiStrings.location, value: UiStrings.locationValue },
    { icon: 'envelope', label: UiStrings.email, value: PortfolioKnowledge.email, ltr: true },
    { icon: 'phone', label: UiStrings.phone, value: '+971 58 915 4605', ltr: true },
    { icon: 'language', label: UiStrings.languages, value: UiStrings.languagesValue },
  ];

  return (
    <Section id="about" sectionRef={sectionRef} className="about">
      <div className="about-text">
        <SectionHeader eyebrow={UiStrings.navAbout} title={UiStrings.aboutMe} />
        <p className="about-paragraph">{PortfolioKnowledge.aboutParagraph1}</p>
        <p className="about-paragraph">{PortfolioKnowledge.aboutParagraph2}</p>
        <ul className="about-highlights">
          {highlights.map((h) => (
            <li key={h}>
              <FaIcon icon="check" size={15} color="var(--accent-bright)" />
              {h}
            </li>
          ))}
        </ul>
        <button type="button" className="about-cv" onClick={() => onLaunch(PortfolioKnowledge.cvUrl)}>
          {UiStrings.downloadCv}
          <FaIcon icon="download" size={13} />
        </button>
      </div>

      <dl className="about-card">
        {info.map((item) => (
          <div className="about-card-row" key={item.label}>
            <FaIcon icon={item.icon} size={20} color="var(--accent-bright)" />
            <div>
              <dt>{item.label}</dt>
              <dd dir={item.ltr ? 'ltr' : undefined}>{item.value}</dd>
            </div>
          </div>
        ))}
      </dl>
    </Section>
  );
}
