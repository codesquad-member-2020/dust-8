const getFetchUrl = (url, data) => {
  const esc = encodeURIComponent;
  const query = Object.keys(data)
    .map(k => `${esc(k)}=${esc(data[k])}`)
    .join("&");
  const fetchUrl = url.includes("?") ? [url, query].join("") : [url, query].join("?");
  return fetchUrl;
};

const fetchRequest = (url, data) => {
  const fetchUrl = getFetchUrl(url, data);

  return fetch(fetchUrl, { method: "GET" })
    .then(response => response.json())
    .then(stationData => {
      return stationData.stationName;
    })
    .catch(error => console.error(error));
};

export { fetchRequest };
