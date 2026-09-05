import Section from './Section';
import SectionHeader from './SectionHeader';
import AnimatedIconBadge from './AnimatedIconBadge';
import { useReveal } from '../hooks/useReveal';
import { UiStrings } from '../data/uiStrings';
import { skillCategories } from '../data/portfolioProfileContent';
import './Skills.css';

function SkillCard({ category, delay }) {
  const { ref, className } = useReveal(delay);

  return (
    <div
      ref={ref}
      className={`skill-card ${className}`}
      style={{
        borderColor: `${category.color}47`,
        boxShadow: `0 12px 28px ${category.color}38, 0 8px 20px rgba(0,0,0,0.32)`,
      }}
    >
      <div className="skill-card-head">
        <AnimatedIconBadge icon={category.icon} color={category.color} size={24} boxSize={48} />
        <h3 className="skill-card-title" style={{ color: category.color }}>{category.category}</h3>
      </div>
      <ul className="skill-card-list">
        {category.skills.map((skill) => (
          <li key={skill}>
            <span className="skill-arrow" style={{ color: category.color }}>›</span>
            <span>{skill}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default function Skills({ sectionRef }) {
  return (
    <Section id="skills" sectionRef={sectionRef} delay={80}>
      <SectionHeader title={UiStrings.skillsTitle} subtitle={UiStrings.skillsSubtitle} />
      <div className="skills-grid">
        {skillCategories.map((category, i) => (
          <SkillCard key={category.category} category={category} delay={70 * i} />
        ))}
      </div>
    </Section>
  );
}
