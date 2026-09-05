import { PortfolioKnowledge } from './portfolioKnowledge';

export const role = PortfolioKnowledge.role;
export const tagline = PortfolioKnowledge.tagline;
export const aboutParagraph1 = PortfolioKnowledge.aboutParagraph1;
export const aboutParagraph2 = PortfolioKnowledge.aboutParagraph2;

export const aboutHighlights = ['Flutter', 'Dart', 'Firebase', 'GetX', 'REST API', 'Clean Architecture', 'UI/UX'];

export const educationEntries = [
  {
    title: 'Bachelor of Information Technology',
    subtitle: 'Al-Mashriq University - Sudan',
    details: [['Year', '2018']],
    color: '#0099FF',
  },
  {
    title: 'Flutter Development Course',
    subtitle: 'Udemy - Online Platform',
    details: [['Description', 'Mobile App Development with Flutter']],
    color: '#00B0FF',
  },
  {
    title: 'One Million Prompters — Certificate of Completion',
    subtitle: 'Dubai Future Foundation · Dubai Centre for Artificial Intelligence',
    details: [
      ['Issued by', 'Dubai Future Foundation & Dubai Centre for Artificial Intelligence'],
      [
        'Description',
        'Completed the One Million Prompters initiative — developing skills in prompt engineering for AI systems, aligned with the Dubai Universal Blueprint for Artificial Intelligence.',
      ],
    ],
    color: '#00C853',
    certificateUrl: PortfolioKnowledge.dubaiCertificateUrl,
  },
  {
    title: 'Training Diploma in Artificial Intelligence',
    subtitle: 'ALBYAN Institute Education Support Services – Abu Dhabi, UAE',
    details: [
      ['Accredited by', 'ACTVET – Abu Dhabi Centre for Technical and Vocational Education and Training'],
      ['Date', '18 October 2026 • Grade: Excellent'],
      [
        'Description',
        'Completed a comprehensive 120-hour professional diploma covering applied Artificial Intelligence, machine learning concepts, and AI-driven system development for technical and vocational applications.',
      ],
    ],
    color: '#FF6B6B',
  },
];

/// icon: semantic key consumed by <FaIcon icon="..." />
export const skillCategories = [
  {
    category: 'Technical Skills',
    icon: 'code',
    color: '#0099FF',
    skills: [
      'Flutter & Dart',
      'Cross-platform mobile development (Android & iOS)',
      'State management: BLoC, GetX, Riverpod',
      'Widget-based UI design & custom components',
      'Animations and responsive layouts',
      'Working with pub.dev packages',
    ],
  },
  {
    category: 'Web Development (addition)',
    icon: 'code',
    color: '#61DAFB',
    skills: [
      'HTML, CSS, JavaScript',
      'React.js for admin dashboards and web, often with AI-powered features',
      'Responsive, component-based UI',
    ],
  },
  {
    category: 'Backend Integration',
    icon: 'database',
    color: '#00B0FF',
    skills: [
      'Firebase (Auth, Firestore, Realtime DB, Storage, Cloud Functions)',
      'Supabase integration',
      'RESTful API consumption using http or Dio',
      'Local storage: SQLite, Hive, SharedPreferences',
    ],
  },
  {
    category: 'Laravel',
    icon: 'laravel',
    color: '#FF2D20',
    skills: [
      'RESTful API development with Laravel',
      'Eloquent ORM & database migrations',
      'Authentication with Laravel Sanctum / Passport',
      'Role & permission management',
      'API integration with Flutter frontend',
    ],
  },
  {
    category: 'Authentication',
    icon: 'lock',
    color: '#0288D1',
    skills: [
      'Email/password login',
      'Google, Facebook, Apple sign-in',
      'Role-based access and route guarding',
    ],
  },
  {
    category: 'Tools & Platforms',
    icon: 'screwdriverWrench',
    color: '#0099FF',
    skills: [
      'Git/GitHub for version control',
      'VS Code, Android Studio',
      'Firebase Hosting / Play Store deployment',
      'Postman for API testing',
    ],
  },
  {
    category: 'UI/UX Skills',
    icon: 'palette',
    color: '#00B0FF',
    skills: [
      'Material Design & Cupertino widgets',
      'Clean architecture (MVC, MVVM)',
      'Light/Dark theme implementation',
      'Responsive design for mobile, tablet, web',
    ],
  },
  {
    category: 'Soft Skills',
    icon: 'lightbulb',
    color: '#0288D1',
    skills: [
      'Problem-solving & debugging',
      'Agile & team collaboration',
      'Time management',
      'Clean code writing & documentation',
      'Fast learning of new tools/libraries',
    ],
  },
];
