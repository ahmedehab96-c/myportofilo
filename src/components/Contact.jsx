import { useReveal } from '../hooks/useReveal';
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

function ContactRow({ contact, delay }) {
  const { ref, className } = useReveal(delay);

  return (
    <a
      ref={ref}
      href={contact.url}
      target={contact.url.startsWith('http') ? '_blank' : undefined}
      rel="noreferrer"
      className={`contact-row ${className}`}
    >
      <span className="contact-icon">
        <FaIcon icon={contact.icon} size={22} color="var(--accent)" />
      </span>
      <span className="contact-text">
        <span className="contact-label">{contact.label}</span>
        <span className="contact-value">{contact.value}</span>
      </span>
    </a>
  );
}

export default function Contact({ sectionRef }) {
  return (
    <Section id="contact" sectionRef={sectionRef} delay={120}>
      <SectionHeader title={UiStrings.getInTouch} subtitle={UiStrings.getInTouchSubtitle} />
      <div className="contact-list">
        {CONTACTS.map((contact, i) => (
          <ContactRow key={contact.label} contact={contact} delay={80 * i} />
        ))}
      </div>
    </Section>
  );
}
