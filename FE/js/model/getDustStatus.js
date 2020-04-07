import { qs$, qsAll$ } from "../lib/util.js";
import { fetchRequest } from "../common/httpRequest.js";
import { renderCharts, renderDustInfo } from "../dustView/dustView.js";
import { GRADE, gradeList } from "../common/constants.js";

const getDustStatus = location => {
  return fetchRequest(process.env.SERVICE_URL + process.env.STATUS, location).then(status => {
    if (!status.valid) alert(status.errorMessage);
    renderCharts(status.result);

    qs$(".dust-charts").addEventListener("scroll", ({ srcElement }) => {
      const chartAll = qsAll$(".chart__bar");
      const chartHeight = qs$(".chart--horiz").offsetHeight / chartAll.length;
      const chartIndex = Math.floor(srcElement.scrollTop / chartHeight);

      const { pm10Grade1h, pm10Value, dataTime } = status.result[chartIndex];
      const grade = pm10Grade1h === 0 ? pm10Grade1h : pm10Grade1h - 1;

      const currentGrade = GRADE[gradeList[grade]];
      renderDustInfo(currentGrade, pm10Value, new Date(dataTime).getHours());
    });
  });
};

export { getDustStatus };
