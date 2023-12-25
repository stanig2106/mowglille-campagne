const getCsrfToken = () => {
  const cookies = document.cookie.split(';');
  for (let cookie of cookies) {
    let [key, value] = cookie.split('=');
    if (key.trim() === 'csrf_token') {
      return value.trim();
    }
  }
  return null;
}

export default getCsrfToken;
