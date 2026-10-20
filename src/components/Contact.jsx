import Section from './Section';
import SectionHeader from './SectionHeader';
import FaIcon from './icons/FaIcon';
import { UiStrings } from '../data/uiStrings';
import './Contact.css';

const CONTACTS = [
  { icon: 'phone', label: UiStrings.phone, value: '+971 58 915 4605', url: 'tel:+971589154605' },
  { icon: 'envelope', label: UiStrings.email, value: 'ahmed96it96@gmail.com', url: 'mailto:ahmed96it96@gmail.com' },
  { icon: 'github', label: 'GitHub', value: 'github.com/ahmedehab96-c', url: 'https://github.com/ahmedehab96-c' },
  { icon: 'linkedin', label: 'LinkedIn', value: 'Ahmed Ehab', url: 'https://www.linkedin.com/in/ahmed-ehab-ba8a63285' },
];

function ContactRow({ contact }) {
  return (
    <li>
      <a
        href={contact.url}
        target={contact.url.startsWith('http') ? '_blank' : undefined}
        rel="noreferrer"
        className="contact-row"
      >
        <span className="contact-icon">
          <FaIcon icon={contact.icon} size={16} />
        </span>
        <span className="contact-text">
          <span className="contact-label">{contact.label}</span>
          <span className="contact-value">{contact.value}</span>
        </span>
        <span className="contact-arrow" aria-hidden="true">↗</span>
      </a>
    </li>
  );
}

export default function Contact({ sectionRef }) {
  return (
    <Section id="contact" sectionRef={sectionRef} className="split">
      <SectionHeader title={UiStrings.getInTouch} subtitle={UiStrings.getInTouchSubtitle} />
      <ul className="contact-list stagger">
        {CONTACTS.map((contact) => (
          <ContactRow key={contact.label} contact={contact} />
        ))}
      </ul>
    </Section>
  );
}
