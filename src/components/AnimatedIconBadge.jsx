import FaIcon from './icons/FaIcon';
import './AnimatedIconBadge.css';

/// Small tinted icon tile.
export default function AnimatedIconBadge({ icon, size = 18, boxSize = 44 }) {
  return (
    <div className="icon-badge" style={{ width: boxSize, height: boxSize }}>
      <FaIcon icon={icon} size={size} color="var(--accent)" />
    </div>
  );
}
