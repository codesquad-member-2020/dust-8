const getFetchUrl = (url, data) => {
  const esc = encodeURIComponent;
  const query =
    typeof data === "object"
      ? Object.keys(data)
          .map(k => `${esc(k)}=${esc(data[k])}`)
          .join("&")
      : esc(data);
  const fetchUrl = url.includes("?") ? [url, query].join("") : [url, query].join("?");
  return fetchUrl;
};

const fetchRequest = (url, data) => {
  const fetchUrl = getFetchUrl(url, data);

  return fetch(fetchUrl, { method: "GET" })
    .then(response => response.json())
    .then(stationData => {
      return stationData;
    })
    .catch(error => console.error(error));
};

export { fetchRequest };
