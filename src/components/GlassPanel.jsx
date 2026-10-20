import './GlassPanel.css';

/// Plain content container used across portfolio sections.
export default function GlassPanel({ children, className = '' }) {
  return <div className={`glass-panel ${className}`}>{children}</div>;
}
