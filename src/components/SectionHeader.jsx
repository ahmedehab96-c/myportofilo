import './SectionHeader.css';

export default function SectionHeader({ title, subtitle }) {
  return (
    <div className="section-header">
      <h2 className="section-header-title">{title}</h2>
      {subtitle && <p className="section-header-subtitle">{subtitle}</p>}
    </div>
  );
}
