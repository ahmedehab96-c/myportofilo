import { useReveal } from '../hooks/useReveal';
import './Section.css';

/// Wraps a portfolio section with a subtle scroll entrance, mirrors SectionBlock.
export default function Section({ id, sectionRef, delay = 0, className = '', children }) {
  const { ref, className: revealClass } = useReveal(delay);

  return (
    <section
      id={id}
      ref={(el) => {
        ref.current = el;
        if (sectionRef) sectionRef.current = el;
      }}
      className={`section-block ${revealClass} ${className}`}
    >
      {children}
    </section>
  );
}
