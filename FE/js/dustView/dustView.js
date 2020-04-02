import { qs$ } from "../lib/util.js";
import { GRADE, gradeList } from "../common/constants.js";

const renderLocation = location => {
  qs$(".info-location").innerText = location;
};

const renderCharts = numerics => {
  numerics.forEach(({ pm10Value, pm10Grade1h }) => {
    qs$(".chart--horiz").innerHTML += `
    <li class="chart__bar" style="width: ${Number(pm10Value) / 2}%; background: ${
      GRADE[gradeList[pm10Grade1h - 1]].COLOR
    }">
      <span class="chart__label">
        ${pm10Value}
      </span>
    </li>
    `;
  });
};

export { renderLocation, renderCharts };
