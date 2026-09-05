import { useCallback, useEffect, useRef, useState } from 'react';
import PortfolioBackground from '../components/PortfolioBackground';
import NavBar from '../components/NavBar';
import Hero from '../components/Hero';
import About from '../components/About';
import Education from '../components/Education';
import Skills from '../components/Skills';
import Services from '../components/Services';
import Projects from '../components/Projects';
import Contact from '../components/Contact';
import { ResumeButton, AIChatBanner, Footer } from '../components/CtaBanners';
import './Home.css';

function launchUrl(url) {
  window.open(url, '_blank', 'noopener,noreferrer');
}

export default function Home() {
  const [activeIndex, setActiveIndex] = useState(0);
  const sectionRefs = useRef([useRef(null), useRef(null), useRef(null), useRef(null), useRef(null), useRef(null)]);

  const updateActiveSection = useCallback(() => {
    let active = 0;
    for (let i = sectionRefs.current.length - 1; i >= 0; i--) {
      const el = sectionRefs.current[i].current;
      if (!el) continue;
      const top = el.getBoundingClientRect().top;
      if (top <= 160) {
        active = i;
        break;
      }
    }
    setActiveIndex((prev) => (prev === active ? prev : active));
  }, []);

  useEffect(() => {
    let raf;
    const onScroll = () => {
      cancelAnimationFrame(raf);
      raf = requestAnimationFrame(updateActiveSection);
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    updateActiveSection();
    return () => {
      window.removeEventListener('scroll', onScroll);
      cancelAnimationFrame(raf);
    };
  }, [updateActiveSection]);

  const scrollToSection = useCallback((index) => {
    setActiveIndex(index);
    const el = sectionRefs.current[index]?.current;
    if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }, []);

  const openGithub = useCallback((project) => {
    if (project.githubUrl) launchUrl(project.githubUrl);
  }, []);

  const openAssistant = useCallback(() => {
    window.location.href = '/ai';
  }, []);

  return (
    <div className="home-page">
      <PortfolioBackground />
      <div className="home-nav-sticky">
        <NavBar activeIndex={activeIndex} onSelect={scrollToSection} onOpenAi={openAssistant} />
      </div>
      <main className="home-content">
        <Hero onScrollToSection={scrollToSection} onLaunch={launchUrl} />
        <About sectionRef={sectionRefs.current[0]} />
        <Education sectionRef={sectionRefs.current[1]} onOpenCertificate={launchUrl} />
        <Skills sectionRef={sectionRefs.current[2]} />
        <Services sectionRef={sectionRefs.current[3]} />
        <Projects sectionRef={sectionRefs.current[4]} onOpenGithub={openGithub} />
        <Contact sectionRef={sectionRefs.current[5]} />
        <ResumeButton onLaunch={launchUrl} />
        <AIChatBanner />
        <Footer />
      </main>
    </div>
  );
}
