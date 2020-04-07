import { fetchRequest } from "../common/httpRequest.js";
import { renderLocation } from "../dustView/dustView.js";
import { getDustStatus } from "./getDustStatus.js";

const getPosition = () => {
  return new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(resolve, reject);
  })
    .then(({ coords }) => {
      return {
        latitude: coords.latitude,
        longitude: coords.longitude
      };
    })
    .catch(() => {
      return {
        latitude: 37.491076,
        longitude: 127.033353
      };
    });
};

const fetchLocation = () => {
  getPosition().then(position => {
    return fetchRequest(process.env.SERVICE_URL + process.env.SERVICELOCATION, position)
      .then(stationName => {
        if (!stationName.result) alert(stationName.errorMessage);

        renderLocation(stationName.result);
        getDustStatus(stationName.result);
      })
      .catch(error => console.error(error));
  });
};

export { fetchLocation };
