import Section from './Section';
import SectionHeader from './SectionHeader';
import ProjectCard from './ProjectCard';
import { UiStrings } from '../data/uiStrings';
import { featuredProjects, bentoFeaturedIds } from '../data/portfolioContent';
import './Projects.css';

export default function Projects({ sectionRef, onOpenGithub }) {
  return (
    <Section id="projects" sectionRef={sectionRef} delay={100} className="projects-section">
      <SectionHeader title={UiStrings.featuredProjects} subtitle={UiStrings.featuredProjectsSubtitle} />
      <div className="projects-bento-grid">
        {featuredProjects.map((project, i) => (
          <ProjectCard
            key={project.id}
            project={project}
            featured={bentoFeaturedIds.has(project.id)}
            delay={85 * i}
            onOpenGithub={onOpenGithub}
          />
        ))}
      </div>
    </Section>
  );
}
