import './GlassPanel.css';

/// Frosted glass container used across portfolio sections.
export default function GlassPanel({ children, accentTop = true, borderRadius = 20, className = '' }) {
  return (
    <div className={`glass-panel ${className}`} style={{ borderRadius }}>
      {accentTop && <div className="glass-panel-accent" />}
      <div className="glass-panel-body">{children}</div>
    </div>
  );
}
