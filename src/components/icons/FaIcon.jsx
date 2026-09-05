import { iconMap } from './iconMap';

/// Renders a portfolio icon. `icon="flutter"` uses the official logo asset
/// (matches the special case in the original fa_shim.dart), everything else
/// maps to a Font Awesome Free class.
export default function FaIcon({ icon, size = 16, color, className = '', style }) {
  if (icon === 'flutter') {
    return (
      <img
        src="/assets/images/flutterlogo.jpeg"
        alt="Flutter"
        width={size}
        height={size}
        style={{ borderRadius: size * 0.22, objectFit: 'cover', ...style }}
        className={className}
      />
    );
  }

  const cls = iconMap[icon] || 'fa-solid fa-circle';

  return (
    <i
      className={`${cls} ${className}`}
      style={{ fontSize: size, width: size, color, lineHeight: 1, ...style }}
      aria-hidden="true"
    />
  );
}
