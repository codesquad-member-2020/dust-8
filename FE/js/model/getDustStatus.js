import { fetchRequest } from "../common/httpRequest.js";
import { renderCharts } from "../dustView/dustView.js";

const getDustStatus = location => {
  return fetchRequest(process.env.MOCK_URL + process.env.STATUS, location).then(status =>
    // console.log(status.dustStatus)
    renderCharts(status.dustStatus)
  );
};

export { getDustStatus };
