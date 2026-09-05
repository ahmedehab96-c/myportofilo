import Section from './Section';
import SectionHeader from './SectionHeader';
import AnimatedIconBadge from './AnimatedIconBadge';
import FaIcon from './icons/FaIcon';
import { useReveal } from '../hooks/useReveal';
import { UiStrings } from '../data/uiStrings';
import { educationEntries } from '../data/portfolioProfileContent';
import './Education.css';

const ICONS = ['graduationCap', 'flutter', 'robot', 'brain'];

function EducationCard({ entry, icon, delay, onOpenCertificate }) {
  const { ref, className } = useReveal(delay);

  return (
    <div
      ref={ref}
      className={`education-card ${className}`}
      style={{
        borderColor: `${entry.color}59`,
        boxShadow: `0 18px 36px ${entry.color}59, 0 10px 24px rgba(0,0,0,0.35)`,
      }}
    >
      <div className="education-card-head">
        <AnimatedIconBadge icon={icon} color={entry.color} size={28} boxSize={56} />
        <div className="education-card-title-wrap">
          <h3 className="education-card-title">{entry.title}</h3>
          <p className="education-card-subtitle">{entry.subtitle}</p>
        </div>
      </div>

      {entry.details.map(([label, value]) => (
        <div className="education-card-detail" key={label}>
          {label !== UiStrings.description && <span className="education-detail-label">{label}</span>}
          <span
            className="education-detail-value"
            style={{ color: entry.color, fontWeight: label === UiStrings.description ? 400 : 600 }}
          >
            {value}
          </span>
        </div>
      ))}

      {entry.certificateUrl && (
        <button
          type="button"
          className="education-cert-btn"
          style={{ borderColor: `${entry.color}B3`, color: entry.color }}
          onClick={() => onOpenCertificate(entry.certificateUrl)}
        >
          <FaIcon icon="filePdf" size={18} color={entry.color} />
          <span>{UiStrings.viewCertificate}</span>
        </button>
      )}
    </div>
  );
}

export default function Education({ sectionRef, onOpenCertificate }) {
  return (
    <Section id="education" sectionRef={sectionRef} delay={60}>
      <SectionHeader title={UiStrings.educationTitle} />
      <div className="education-list">
        {educationEntries.map((entry, i) => (
          <EducationCard
            key={entry.title}
            entry={entry}
            icon={ICONS[i]}
            delay={80 * i}
            onOpenCertificate={onOpenCertificate}
          />
        ))}
      </div>
    </Section>
  );
}
