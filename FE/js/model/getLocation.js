import { fetchRequest } from "../common/httpRequest.js";
import { renderLocation } from "../dustView/dustView.js";

const getPosition = () => {
  return new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(resolve, reject);
  }).then(pos => {
    return {
      latitude: pos.coords.latitude,
      longitude: pos.coords.longitude
    };
  });
};

const fetchLocation = () => {
  getPosition().then(position => {
    return fetchRequest(process.env.MOCK_URL + process.env.LOCATION, position)
      .then(stationName => renderLocation(stationName))
      .catch(error => console.error(error));
  });
};

export { fetchLocation };
