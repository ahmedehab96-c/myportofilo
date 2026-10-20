import './HeroStatsStrip.css';

export default function HeroStatsStrip({ items }) {
  return (
    <dl className="hero-stats">
      {items.map((item) => (
        <div className="hero-stat" key={item.label}>
          <dt>{item.value}</dt>
          <dd>{item.label}</dd>
        </div>
      ))}
    </dl>
  );
}
