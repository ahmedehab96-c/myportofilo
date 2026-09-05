import { useEffect, useRef, useState } from 'react';
import { Link } from 'react-router-dom';
import FaIcon from '../components/icons/FaIcon';
import { reply, suggestedQuestions } from '../data/assistantService';
import { assistantDataVersion } from '../data/portfolioContent';
import { UiStrings } from '../data/uiStrings';
import './AIChat.css';

function formatTime(date) {
  const h = String(date.getHours()).padStart(2, '0');
  const m = String(date.getMinutes()).padStart(2, '0');
  return `${h}:${m}`;
}

export default function AIChat() {
  const [messages, setMessages] = useState([
    { text: UiStrings.welcomeMessage(assistantDataVersion), isUser: false, timestamp: new Date() },
  ]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);
  const listRef = useRef(null);

  useEffect(() => {
    const el = listRef.current;
    if (el) el.scrollTop = el.scrollHeight;
  }, [messages, loading]);

  const sendMessage = async (preset) => {
    const text = (preset ?? input).trim();
    if (!text || loading) return;

    setMessages((prev) => [...prev, { text, isUser: true, timestamp: new Date() }]);
    setInput('');
    setLoading(true);

    try {
      const response = await reply(text);
      setMessages((prev) => [...prev, { text: response, isUser: false, timestamp: new Date() }]);
    } catch {
      setMessages((prev) => [...prev, { text: UiStrings.somethingWentWrong, isUser: false, timestamp: new Date() }]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="ai-chat-page">
      <header className="ai-chat-appbar">
        <Link to="/" className="ai-chat-back">←</Link>
        <FaIcon icon="robot" size={20} color="var(--violet)" />
        <span>{UiStrings.aiAssistant}</span>
      </header>

      <div className="ai-chat-suggestions">
        <p>{UiStrings.suggestedQuestions(suggestedQuestions.length)}</p>
        <div className="ai-chip-row">
          {suggestedQuestions.map((q) => (
            <button key={q} type="button" className="ai-chip" disabled={loading} onClick={() => sendMessage(q)}>
              {q}
            </button>
          ))}
        </div>
      </div>

      <div className="ai-chat-messages" ref={listRef}>
        {messages.map((m, i) => (
          <div key={i} className={`ai-msg-row ${m.isUser ? 'user' : 'bot'}`}>
            {!m.isUser && (
              <span className="ai-avatar">
                <FaIcon icon="robot" size={18} color="var(--violet)" />
              </span>
            )}
            <div className={`ai-bubble ${m.isUser ? 'user' : 'bot'}`}>
              <p>{m.text}</p>
              <span className="ai-msg-time">{formatTime(m.timestamp)}</span>
            </div>
            {m.isUser && <span className="ai-avatar">🧑</span>}
          </div>
        ))}
        {loading && (
          <div className="ai-msg-row bot">
            <span className="ai-avatar">
              <FaIcon icon="robot" size={18} color="var(--violet)" />
            </span>
            <div className="ai-bubble bot ai-typing">
              <span className="ai-dot" />
              <span className="ai-dot" />
              <span className="ai-dot" />
            </div>
          </div>
        )}
      </div>

      <form
        className="ai-chat-input-row"
        onSubmit={(e) => {
          e.preventDefault();
          sendMessage();
        }}
      >
        <input
          type="text"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder={UiStrings.typeMessage}
          disabled={loading}
        />
        <button type="submit" disabled={loading || !input.trim()}>
          ➤
        </button>
      </form>
    </div>
  );
}
