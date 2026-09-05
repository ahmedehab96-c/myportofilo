import { useState } from 'react';
import FaIcon from './icons/FaIcon';
import { useReveal } from '../hooks/useReveal';
import './AnimatedIconBadge.css';

export default function AnimatedIconBadge({ icon, color, size = 28, boxSize = 56 }) {
  const [hovered, setHovered] = useState(false);
  const { ref, className } = useReveal(0);

  return (
    <div
      ref={ref}
      className={`icon-badge ${className}`}
      style={{
        width: boxSize,
        height: boxSize,
        background: `${color}14`,
        borderColor: hovered ? `${color}A6` : `${color}59`,
        boxShadow: `0 0 ${hovered ? 16 : 10}px ${hovered ? 1 : 0}px ${color}${hovered ? '59' : '2E'}`,
        transform: hovered ? 'scale(1.08)' : 'scale(1)',
      }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      <FaIcon icon={icon} size={size} color={color} />
    </div>
  );
}
