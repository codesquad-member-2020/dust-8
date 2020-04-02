import { GRADE, gradeList, tabValue } from "../common/constants.js";

const initRender = () => {
  const wholeTag = tabBarTag() + dustTag();

  document.body.innerHTML = wholeTag;
};

const tabBarTag = () => {
  return `
  <div class="tab-bar">
    <button class="tab-bar-item tab-button" id="tab-dust">미세먼지</button>
    <button class="tab-bar-item tab-button" id="tab-forecast">예보</button>
  </div>`;
};

const dustTag = () => {
  return `
  <div id="dust" class="tab-container dust">
    <div class="info-window">
      <h2>미세먼지 웹</h2>
      ${dustInfoTag()}
    </div>
    <div class="dust-charts">
      <div class="chart chart--dev">
        <ul class="chart--horiz"></ul>
        <div class="dummy-chart"></div>
      </div>
    </div>
  </div>
  `;
};

const dustInfoTag = () => {
  return `
  <div class="info-emoji"></div>
  <div class="info-grade"></div>
  <div class="info-statistics">
    <span class="statistics-numeric"></span>
    <span class="statistics-time"></span>
  </div>
  <p><i class="info-location"></i>측정소 기준</p>
  `;
};

export { initRender };
