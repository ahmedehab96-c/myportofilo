import Section from './Section';
import SectionHeader from './SectionHeader';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { educationEntries } from '../data/portfolioProfileContent';
import './Education.css';

function EducationItem({ entry, onOpenCertificate }) {
  const meta = entry.details.filter(([label]) => label !== UiStrings.description);
  const description = entry.details.find(([label]) => label === UiStrings.description)?.[1];

  return (
    <li className="education-item">
      <h3 className="education-title">{entry.title}</h3>
      <p className="education-subtitle">{entry.subtitle}</p>

      {meta.length > 0 && (
        <dl className="education-meta">
          {meta.map(([label, value]) => (
            <div key={label}>
              <dt>{label}</dt>
              <dd>{value}</dd>
            </div>
          ))}
        </dl>
      )}

      {description && <p className="education-desc">{description}</p>}

      {entry.certificateUrl && (
        <button type="button" className="education-cert" onClick={() => onOpenCertificate(entry.certificateUrl)}>
          <FaIcon icon="filePdf" size={13} />
          {UiStrings.viewCertificate}
        </button>
      )}
    </li>
  );
}

export default function Education({ sectionRef, onOpenCertificate }) {
  return (
    <Section id="education" sectionRef={sectionRef} className="split">
      <SectionHeader title={UiStrings.educationTitle} />
      <ul className="education-list stagger">
        {educationEntries.map((entry) => (
          <EducationItem key={entry.title} entry={entry} onOpenCertificate={onOpenCertificate} />
        ))}
      </ul>
    </Section>
  );
}
