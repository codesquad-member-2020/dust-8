const fetchRequest = (url, data) => {
  const esc = encodeURIComponent;
  const query = Object.keys(data)
    .map(k => `${esc(k)}=${esc(data[k])}`)
    .join("&");
  const fetchUrl = [url, query].join("?");

  return fetch(fetchUrl, {
    method: "GET",
    mode: "cors",
    cache: "no-cache",
    headers: {
      "Content-Type": "application/json"
    }
    // body: JSON.stringify(data)
  });
};

export { fetchRequest };
