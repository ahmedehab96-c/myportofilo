/// English UI copy for the portfolio (no i18n / code generation).
abstract final class UiStrings {
  static const appTitle = "Ahmed's Portfolio";
  static const navNavigation = 'Navigation';
  static const navAbout = 'About';
  static const navEducation = 'Education';
  static const navSkills = 'Skills';
  static const navProjects = 'Projects';
  static const navContact = 'Contact';
  static const navAI = 'AI Assistant';
  static const navAIShort = 'AI';
  static const heroTagline =
      'Crafting beautiful & functional mobile experiences\nwith a focus on clean architecture and great UX.';
  static const yearsExp = 'Years Exp.';
  static const statProjects = 'Projects';
  static const statTechnologies = 'Technologies';
  static const viewProjects = 'View Projects';
  static const contactMe = 'Contact Me';
  static const aboutMe = 'About Me';
  static const educationTitle = 'Education & Certifications';
  static const skillsTitle = 'Skills & Expertise';
  static const skillsSubtitle = 'Technologies and tools I specialize in:';
  static const featuredProjects = 'Featured Projects';
  static const featuredProjectsSubtitle =
      'Selected apps and platforms I designed and built.';
  static const privateRepo = 'Private repo';
  static const openSource = 'Open source';
  static const viewProject = 'View project';
  static const getInTouch = 'Get in Touch';
  static const getInTouchSubtitle =
      'Open to work — feel free to reach out anytime.';
  static const phone = 'Phone';
  static const email = 'Email';
  static const downloadCv = 'Download CV';
  static const chatWithAI = 'Chat with AI Assistant';
  static const builtWith = 'Built with Flutter & ❤️';
  static const couldNotOpenLink = 'Could not open link';
  static const techStack = 'Tech Stack';
  static const viewReadmeGitHub = 'View README on GitHub';
  static const about = 'About';
  static const topics = 'Topics';
  static const features = 'Features';
  static const overview = 'Overview';
  static const screenshotSoon = 'Screenshot coming soon';
  static const viewFull = 'View full';
  static const privateRepoNotice =
      'Source code is hosted in a private GitHub repository. Contact Ahmed for access.';
  static const couldNotOpenGithub = 'Could not open GitHub';
  static const privateRepoLabel = 'Private Repo';
  static const sourceCode = 'Source Code';
  static const code = 'Code';
  static const privateOnGithub = 'Private on GitHub';
  static const viewOnGithub = 'View on GitHub';
  static const aiAssistant = 'AI Assistant';
  static const typeMessage = 'Type your message here...';
  static const somethingWentWrong =
      'Sorry, something went wrong. Please try again.';
  static const emptyQuestion =
      'Type your question and I will help you right away.';
  static const description = 'Description';

  static String errorGeneric(String message) => 'Error: $message';

  static String pageOf(int current, int total) => '$current of $total';

  static String suggestedQuestions(int count) =>
      'Suggested questions ($count)';

  static String welcomeMessage(String version) =>
      "Hello! I am Ahmed Ehab's portfolio AI assistant.\n\n"
      'Data version: $version\n\n'
      'I know everything on this site: About, 5 featured projects, 6 skill areas, education, contact, and more.\n\n'
      'Tap a suggested question below, or ask: "What can you help me with?"';
}
