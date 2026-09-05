// Minimal pub/sub so any component can trigger the global toast
// without prop drilling (mirrors Flutter's ScaffoldMessenger.showSnackBar).
const listeners = new Set();

export function showToast(message) {
  listeners.forEach((fn) => fn(message));
}

export function subscribeToast(fn) {
  listeners.add(fn);
  return () => listeners.delete(fn);
}
