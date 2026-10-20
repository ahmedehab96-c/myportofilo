import Section from './Section';
import SectionHeader from './SectionHeader';
import { UiStrings } from '../data/uiStrings';
import { skillCategories } from '../data/portfolioProfileContent';
import './Skills.css';

export default function Skills({ sectionRef }) {
  return (
    <Section id="skills" sectionRef={sectionRef}>
      <SectionHeader title={UiStrings.skillsTitle} subtitle={UiStrings.skillsSubtitle} />
      <div className="skills-grid stagger">
        {skillCategories.map((category) => (
          <div className="skill-group" key={category.category}>
            <h3 className="skill-group-title">{category.category}</h3>
            <ul className="skill-group-list">
              {category.skills.map((skill) => (
                <li key={skill}>{skill}</li>
              ))}
            </ul>
          </div>
        ))}
      </div>
    </Section>
  );
}
