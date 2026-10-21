import { useMemo, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import FaIcon from '../components/icons/FaIcon';
import GithubRepoButton from '../components/GithubRepoButton';
import { useWindowWidth } from '../hooks/useWindowWidth';
import { findProjectById, hasTrySection as hasTry } from '../data/portfolioContent';
import { UiStrings } from '../data/uiStrings';
import './ProjectDetails.css';

function compactTryNotes(project) {
  const guide = project.webSetupGuide?.trim();
  if (!guide) return null;

  const lines = guide
    .split('\n')
    .map((l) => l.trim())
    .filter((l) => l.length > 0)
    .filter((l) => {
      const lower = l.toLowerCase();
      if (lower.startsWith('**android apk**')) return false;
      if (lower.startsWith('**live demo')) return false;
      if (lower.startsWith('**live web')) return false;
      if (lower.includes('tap **download apk**')) return false;
      if (lower.includes('tap **open live demo**')) return false;
      if (lower.startsWith('1. tap')) return false;
      if (lower.startsWith('2. install')) return false;
      if (lower.startsWith('3. sign in') && lower.includes('demo')) return false;
      return true;
    })
    .map((l) => l.replace(/\*\*/g, ''));

  return lines.length ? lines.join('\n') : null;
}

function TrySection({ project }) {
  if (!hasTry(project)) return null;
  const notes = compactTryNotes(project);

  return (
    <div className="pd-try-section">
      <h2>{UiStrings.tryThisProject}</h2>
      {(project.websiteUrl || project.liveDemoUrl || project.apkUrl || project.playStoreUrl) && (
        <div className="pd-try-buttons">
          {project.websiteUrl && (
            <a className="pd-try-btn website" href={project.websiteUrl} target="_blank" rel="noreferrer">
              {UiStrings.visitWebsite} <span aria-hidden="true">↗</span>
            </a>
          )}
          {project.liveDemoUrl && (
            <a className="pd-try-btn demo" href={project.liveDemoUrl} target="_blank" rel="noreferrer">
              {UiStrings.openLiveDemo} <span aria-hidden="true">↗</span>
            </a>
          )}
          {project.playStoreUrl && (
            <a className="pd-try-btn play" href={project.playStoreUrl} target="_blank" rel="noreferrer">
              {UiStrings.getOnGooglePlay}
            </a>
          )}
          {project.apkUrl && (
            <a className="pd-try-btn apk" href={project.apkUrl} target="_blank" rel="noreferrer">
              <FaIcon icon="android" size={14} /> {UiStrings.downloadApk}
            </a>
          )}
        </div>
      )}
      {notes && <pre className="pd-try-notes">{notes}</pre>}
    </div>
  );
}

function ScreenshotGallery({ screenshots, onOpen }) {
  const [page, setPage] = useState(0);
  if (screenshots.length === 0) return null;

  return (
    <div className="pd-gallery">
      <button type="button" className="pd-screenshot" onClick={() => onOpen(screenshots[page])}>
        <img src={screenshots[page]} alt="" loading="lazy" />
        <span className="pd-zoom-hint">{UiStrings.viewFull}</span>
      </button>
      {screenshots.length > 1 && (
        <div className="pd-gallery-nav">
          <button type="button" disabled={page === 0} onClick={() => setPage((p) => p - 1)}>‹</button>
          {screenshots.map((_, i) => (
            <button
              type="button"
              key={i}
              className={`pd-dot ${i === page ? 'active' : ''}`}
              onClick={() => setPage(i)}
              aria-label={`Screenshot ${i + 1}`}
            />
          ))}
          <button type="button" disabled={page === screenshots.length - 1} onClick={() => setPage((p) => p + 1)}>›</button>
          <span className="pd-page-of">{UiStrings.pageOf(page + 1, screenshots.length)}</span>
        </div>
      )}
    </div>
  );
}

function Lightbox({ src, onClose }) {
  const [zoomed, setZoomed] = useState(false);
  if (!src) return null;

  return (
    <div className="pd-lightbox" onClick={onClose}>
      <button type="button" className="pd-lightbox-close" onClick={onClose}>✕</button>
      <img
        src={src}
        alt=""
        className={zoomed ? 'zoomed' : ''}
        onClick={(e) => {
          e.stopPropagation();
          setZoomed((z) => !z);
        }}
      />
    </div>
  );
}

export default function ProjectDetails() {
  const { id } = useParams();
  const project = useMemo(() => findProjectById(id), [id]);
  const width = useWindowWidth();
  const isWide = width >= 960;
  const [lightbox, setLightbox] = useState(null);

  if (!project) {
    return (
      <div className="pd-page pd-not-found">
        <p>{UiStrings.projectNotFound}</p>
        <Link to="/"><span className="flip-rtl">←</span> {UiStrings.backToPortfolio}</Link>
      </div>
    );
  }

  return (
    <div className="pd-page">
      <header className="pd-appbar">
        <Link to="/" className="pd-back"><span className="flip-rtl">←</span> {UiStrings.brandName}</Link>
      </header>

      <div className={`pd-body ${isWide ? 'wide' : 'narrow'}`}>
        <div className="pd-main">
          {project.categories.length > 0 && (
            <p className="pd-categories">{project.categories.join(' · ')}</p>
          )}

          <h1 className="pd-title">{project.title}</h1>
          <p className="pd-summary">{project.summary}</p>

          <ScreenshotGallery screenshots={project.screenshots} onOpen={setLightbox} />

          {!isWide && <TrySection project={project} />}

          <h2 className="pd-heading">{UiStrings.features}</h2>
          <ul className="pd-features">
            {project.features.map((f) => (
              <li key={f}>{f}</li>
            ))}
          </ul>

          <h2 className="pd-heading">{UiStrings.techStack}</h2>
          <div className="pd-tech-badges">
            {project.tech.map((t) => (
              <span key={t} className="pd-tech-badge">{t}</span>
            ))}
          </div>

          {!isWide && project.githubUrl && (
            <div className="pd-github-wrap">
              <GithubRepoButton githubUrl={project.githubUrl} isPrivate={project.isGithubPrivate} />
            </div>
          )}
        </div>

        {isWide && (
          <aside className="pd-sidebar">
            <TrySection project={project} />
            {project.githubUrl && (
              <div className="pd-github-wrap">
                <GithubRepoButton githubUrl={project.githubUrl} isPrivate={project.isGithubPrivate} />
              </div>
            )}
          </aside>
        )}
      </div>

      <Lightbox src={lightbox} onClose={() => setLightbox(null)} />
    </div>
  );
}
