const getCsrfToken = () => document.querySelector('meta[name="rails-csrf-token"]')!
  .getAttribute('content');

export default getCsrfToken;
