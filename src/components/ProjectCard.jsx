import { Link } from 'react-router-dom';
import FaIcon from './icons/FaIcon';
import { useReveal } from '../hooks/useReveal';
import { useTilt } from '../hooks/useTilt';
import { UiStrings } from '../data/uiStrings';
import { showToast } from '../utils/toast';
import './ProjectCard.css';

const MAX_TECH = 5;

export default function ProjectCard({ project, featured, index = 0, onOpenGithub }) {
  const { ref, className: revealClass } = useReveal(featured ? 0 : (index % 2) * 120);
  const tilt = useTilt();
  const tech = project.tech.slice(0, MAX_TECH);

  return (
    <article ref={ref} className={`project-card tilt-3d ${featured ? 'featured' : ''} ${revealClass}`} {...tilt}>
      <Link to={`/project/${project.id}`} className="project-card-preview" tabIndex={-1} aria-hidden="true">
        <img src={project.cardImage} alt="" loading="lazy" />
      </Link>

      <div className="project-card-body">
        {project.categories.length > 0 && (
          <p className="project-card-categories">{project.categories.join(' · ')}</p>
        )}

        <h3 className="project-card-title">
          <Link to={`/project/${project.id}`}>{project.title}</Link>
        </h3>
        <p className="project-card-summary">{project.summary}</p>

        <ul className="project-card-tech">
          {tech.map((t) => (
            <li key={t}>{t}</li>
          ))}
          {project.tech.length > MAX_TECH && <li>+{project.tech.length - MAX_TECH}</li>}
        </ul>

        <div className="project-card-footer">
          <Link to={`/project/${project.id}`} className="project-card-view">
            {UiStrings.viewProject} <span aria-hidden="true">→</span>
          </Link>
          {project.githubUrl && (
            <button
              type="button"
              className="project-card-github"
              onClick={() => (project.isGithubPrivate ? showToast(UiStrings.privateRepoNotice) : onOpenGithub(project))}
              title={project.isGithubPrivate ? UiStrings.privateOnGithub : UiStrings.viewOnGithub}
            >
              <FaIcon icon={project.isGithubPrivate ? 'lock' : 'github'} size={13} />
              {project.isGithubPrivate ? UiStrings.privateRepo : UiStrings.sourceCode}
            </button>
          )}
        </div>
      </div>
    </article>
  );
}
