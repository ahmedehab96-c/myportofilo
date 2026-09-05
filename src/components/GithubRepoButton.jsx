import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import { showToast } from '../utils/toast';
import './GithubRepoButton.css';

/// GitHub action: opens the public repo, or shows a private-repo notice.
export default function GithubRepoButton({ githubUrl, isPrivate }) {
  if (!githubUrl) return null;

  const onClick = () => {
    if (isPrivate) {
      showToast(UiStrings.privateRepoNotice);
    } else {
      window.open(githubUrl, '_blank', 'noopener,noreferrer');
    }
  };

  return (
    <button type="button" className="github-repo-btn" onClick={onClick}>
      <FaIcon icon={isPrivate ? 'lock' : 'github'} size={16} color="#fff" />
      <span>{isPrivate ? UiStrings.privateOnGithub : UiStrings.viewOnGithub}</span>
    </button>
  );
}
