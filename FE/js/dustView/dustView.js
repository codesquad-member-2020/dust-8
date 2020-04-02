import { qs$ } from "../lib/util.js";
import { GRADE, gradeList, currentHours } from "../common/constants.js";

const renderLocation = location => {
  qs$(".info-location").innerText = location;
};

const renderCurrentHours = time => {
  qs$(".statistics-time").innerText = time;

  if (time > currentHours) {
    qs$(".statistics-time").setAttribute("data-before", "어제");
    return;
  }
  qs$(".statistics-time").setAttribute("data-before", "오늘");
};

const renderCharts = numerics => {
  let targetInfo1;
  let targetInfo2;

  numerics.forEach(({ dataTime, pm10Value, pm10Grade1h }) => {
    const currentGrade = GRADE[gradeList[pm10Grade1h - 1]];

    qs$(".chart--horiz").innerHTML += `
    <li class="chart__bar" style="width: ${Number(pm10Value) / 2}%; background: ${
      currentGrade.COLOR
    }">
      <span class="chart__label">
        ${pm10Value}
      </span>
    </li>
    `;

    if (new Date(dataTime).getHours() === currentHours) {
      targetInfo1 = currentGrade;
      targetInfo2 = pm10Value;
    }
  });

  renderDustInfo(targetInfo1, targetInfo2);
};

export { renderLocation, renderCharts };
