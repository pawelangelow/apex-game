import { useEffect, useState } from 'react';

export function App() {
  const [status, setStatus] = useState('checking…');

  useEffect(() => {
    fetch('/api/health')
      .then((res) => (res.ok ? 'online' : 'offline'))
      .catch(() => 'offline')
      .then(setStatus);
  }, []);

  return (
    <main>
      <h1>Apex Racing</h1>
      <p>Server: {status}</p>
    </main>
  );
}
