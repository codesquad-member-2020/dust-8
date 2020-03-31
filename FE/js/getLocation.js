import { fetchRequest } from "./common/httpRequest.js";
import { initRender } from "./dustView/render.js";

let position = {
  latitude: navigator.geolocation.getCurrentPosition(pos => pos.coords.latitude),
  longitude: navigator.geolocation.getCurrentPosition(pos => pos.coords.longitude)
};

const fetchLocation = () => {
  fetchRequest(process.env.MOCK_URL, position)
    .then(response => response.json())
    .then(suggestionData => {
      initRender(suggestionData);
    });
};

export { fetchLocation };
