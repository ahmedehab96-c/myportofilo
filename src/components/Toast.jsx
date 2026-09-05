import { useEffect, useState } from 'react';
import { subscribeToast } from '../utils/toast';
import './Toast.css';

export default function Toast() {
  const [message, setMessage] = useState(null);

  useEffect(() => {
    let hideTimer;
    const unsubscribe = subscribeToast((msg) => {
      clearTimeout(hideTimer);
      setMessage(msg);
      hideTimer = setTimeout(() => setMessage(null), 4000);
    });
    return () => {
      unsubscribe();
      clearTimeout(hideTimer);
    };
  }, []);

  if (!message) return null;

  return (
    <div className="toast" role="status">
      {message}
    </div>
  );
}
