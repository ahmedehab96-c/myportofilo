import Section from './Section';
import SectionHeader from './SectionHeader';
import AnimatedIconBadge from './AnimatedIconBadge';
import { useReveal } from '../hooks/useReveal';
import { UiStrings } from '../data/uiStrings';
import { services } from '../data/portfolioServicesContent';
import './Services.css';

function ServiceCard({ service, delay }) {
  const { ref, className } = useReveal(delay);

  return (
    <div
      ref={ref}
      className={`service-card ${className}`}
      style={{
        borderColor: `${service.color}47`,
        boxShadow: `0 12px 28px ${service.color}38`,
      }}
    >
      <AnimatedIconBadge icon={service.icon} color={service.color} size={22} boxSize={46} />
      <h3 className="service-card-title" style={{ color: service.color }}>{service.title}</h3>
      <p className="service-card-desc">{service.description}</p>
    </div>
  );
}

export default function Services({ sectionRef }) {
  return (
    <Section id="services" sectionRef={sectionRef} delay={90}>
      <SectionHeader title={UiStrings.servicesTitle} subtitle={UiStrings.servicesSubtitle} />
      <div className="services-grid">
        {services.map((service, i) => (
          <ServiceCard key={service.title} service={service} delay={70 * i} />
        ))}
      </div>
    </Section>
  );
}
