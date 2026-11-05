import './PortfolioBackground.css';

/// Light grid backdrop with slow signals travelling along the grid lines.
export default function PortfolioBackground() {
  return (
    <div className="portfolio-background" aria-hidden="true">
      <span className="pb-trace h pb-trace-1" />
      <span className="pb-trace h pb-trace-2" />
      <span className="pb-trace v pb-trace-3" />
      <span className="pb-trace v pb-trace-4" />
    </div>
  );
}
