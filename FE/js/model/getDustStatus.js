import { fetchRequest } from "../common/httpRequest.js";
import { renderCharts, renderDustInfo } from "../dustView/dustView.js";
import { GRADE, gradeList, currentHours } from "../common/constants.js";

const getDustStatus = location => {
  return fetchRequest("http://192.168.1.42:8080/" + process.env.STATUS, location).then(status => {
    if (!status.valid) alert(status.errorMessage);
    renderCharts(status.result);

    document.querySelector(".dust-charts").addEventListener("scroll", event => {
      const chartAll = document.querySelectorAll(".chart__bar");
      const chartHeight = document.querySelector(".chart--horiz").offsetHeight / chartAll.length;
      const index = Math.floor(event.srcElement.scrollTop / chartHeight);
      console.log("", status.result[index].pm10Grade1h);
      const grade =
        status.result[index].pm10Grade1h === 0
          ? status.result[index].pm10Grade1h
          : status.result[index].pm10Grade1h - 1;

      const currentGrade = GRADE[gradeList[grade]];
      renderDustInfo(
        currentGrade,
        status.result[index].pm10Value,
        new Date(status.result[index].dataTime).getHours()
      );
    });
  });
};

export { getDustStatus };
