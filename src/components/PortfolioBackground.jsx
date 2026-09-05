import './PortfolioBackground.css';

/// Professional static backdrop — soft navy gradient with gentle accent glows.
export default function PortfolioBackground() {
  return (
    <div className="portfolio-background" aria-hidden="true">
      <div className="pb-layer pb-gradient" />
      <div className="pb-layer pb-violet-glow" />
      <div className="pb-layer pb-cyan-glow" />
      <div className="pb-layer pb-vignette" />
      <div className="pb-layer pb-fade" />
      <div className="pb-layer pb-grid" />
    </div>
  );
}
