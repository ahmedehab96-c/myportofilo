import { Link } from 'react-router-dom';
import FaIcon from './icons/FaIcon';
import { useHoverTilt } from '../hooks/useHoverTilt';
import { useReveal } from '../hooks/useReveal';
import { categoryColor } from '../theme/palette';
import { UiStrings } from '../data/uiStrings';
import './ProjectCard.css';

export default function ProjectCard({ project, featured, delay, onOpenGithub }) {
  const { ref: revealRef, className: revealClass } = useReveal(delay);
  const { ref: tiltRef, style: tiltStyle, handlers } = useHoverTilt({ maxTilt: 3, lift: 6, scale: 1.01 });

  return (
    <div
      ref={(el) => {
        revealRef.current = el;
        tiltRef.current = el;
      }}
      className={`project-card-wrap ${revealClass}`}
      style={tiltStyle}
      {...handlers}
    >
      <Link to={`/project/${project.id}`} className={`project-card ${featured ? 'featured' : ''}`}>
        <div className={`project-card-preview ${featured ? 'ratio-16-9' : 'ratio-16-10'}`}>
          <img src={project.cardImage} alt={project.title} loading="lazy" />
          <span className="project-card-repo-badge">
            {project.isGithubPrivate ? UiStrings.privateRepo : UiStrings.openSource}
          </span>
        </div>

        <div className="project-card-body">
          {project.categories.length > 0 && (
            <div className="project-card-categories">
              {project.categories.map((c) => (
                <span
                  key={c}
                  className="project-category-pill"
                  style={{ color: categoryColor(c), borderColor: `${categoryColor(c)}66`, background: `${categoryColor(c)}1F` }}
                >
                  {c}
                </span>
              ))}
            </div>
          )}

          <h3 className="project-card-title">{project.title}</h3>
          <p className={`project-card-summary ${featured ? 'two-lines' : 'one-line'}`}>{project.summary}</p>

          <div className="project-card-footer">
            <span className="project-card-view">{UiStrings.viewProject}</span>
            {project.githubUrl && (
              <button
                type="button"
                className="project-card-github"
                title={project.isGithubPrivate ? UiStrings.privateOnGithub : UiStrings.viewOnGithub}
                onClick={(e) => {
                  e.preventDefault();
                  e.stopPropagation();
                  onOpenGithub(project);
                }}
              >
                <FaIcon icon="github" size={16} color={project.isGithubPrivate ? 'var(--text-muted)' : 'var(--text-secondary)'} />
              </button>
            )}
          </div>
        </div>
      </Link>
    </div>
  );
}
