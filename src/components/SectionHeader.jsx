import './SectionHeader.css';

export default function SectionHeader({ eyebrow, title, subtitle, center = false }) {
  return (
    <div className={`section-header ${center ? 'center' : ''}`}>
      {eyebrow && <p className="section-header-eyebrow">{eyebrow}</p>}
      <h2 className="section-header-title">{title}</h2>
      {subtitle && <p className="section-header-subtitle">{subtitle}</p>}
    </div>
  );
}
