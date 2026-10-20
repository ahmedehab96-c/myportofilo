import FaIcon from './icons/FaIcon';
import './AnimatedIconBadge.css';

/// Small neutral icon tile.
export default function AnimatedIconBadge({ icon, size = 18, boxSize = 36 }) {
  return (
    <div className="icon-badge" style={{ width: boxSize, height: boxSize }}>
      <FaIcon icon={icon} size={size} color="var(--text-secondary)" />
    </div>
  );
}
