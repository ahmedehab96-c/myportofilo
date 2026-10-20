import './PortfolioBackground.css';

/// Soft ambient backdrop: warm paper tone with slowly drifting color fields.
export default function PortfolioBackground() {
  return (
    <div className="portfolio-background" aria-hidden="true">
      <span className="pb-orb pb-orb-a" />
      <span className="pb-orb pb-orb-b" />
      <span className="pb-orb pb-orb-c" />
      <span className="pb-dots" />
    </div>
  );
}
