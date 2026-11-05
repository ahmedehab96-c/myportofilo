import Section from './Section';
import SectionHeader from './SectionHeader';
import { UiStrings } from '../data/uiStrings';
import { services } from '../data/portfolioServicesContent';
import './Services.css';

export default function Services({ sectionRef }) {
  return (
    <Section id="services" sectionRef={sectionRef}>
      <SectionHeader title={UiStrings.servicesTitle} subtitle={UiStrings.servicesSubtitle} />
      <div className="services-grid stagger">
        {services.map((service) => (
          <div className="service-item" key={service.title}>
            <h3 className="service-title">{service.title}</h3>
            <p className="service-desc">{service.description}</p>
          </div>
        ))}
      </div>
    </Section>
  );
}
