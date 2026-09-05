import './SectionHeader.css';

export default function SectionHeader({ title, subtitle }) {
  return (
    <div className="section-header">
      <div className="section-header-row">
        <span className="section-header-bar" />
        <h2 className="section-header-title">{title}</h2>
      </div>
      {subtitle && <p className="section-header-subtitle">{subtitle}</p>}
      <div className="section-header-divider" />
    </div>
  );
}
