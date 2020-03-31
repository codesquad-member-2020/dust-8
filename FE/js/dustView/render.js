import { GRADE, gradeList, currentHours } from "../common/constants.js";

const initRender = data => {
  const wholeTag = tabBarTag() + dustTag(data);

  document.body.innerHTML = wholeTag;
};

const tabBarTag = () => {
  return `
  <div class="tab-bar">
    <button class="tab-bar-item tab-button">미세먼지</button>
    <button class="tab-bar-item tab-button">예보</button>
  </div>`;
};

const dustTag = data => {
  return `
  <div id="dust" class="tab-container dust">
    <div class="info-window">
      <h2>미세먼지 웹</h2>
      ${dustInfoTag(data, GRADE[gradeList[0]], 20)}
    </div>
    <div class="dust-charts">
      <div class="chart chart--dev">
        <ul class="chart--horiz">
          <li class="chart__bar" style="width: 98%;">
            <span class="chart__label">
              196
            </span>
          </li>

        </ul>
      </div>
    </div>
  </div>
  `;
};

const dustInfoTag = (data, gradeProp, numeric) => {
  const { EMOJI, STATE } = gradeProp;

  return `
  <div class="info-emoji">${EMOJI}</div>
  <div class="info-grade">${STATE}</div>
  <div class="info-statistics">
    <span class="statistics-numeric">${numeric}</span>
    <span class="statistics-time">${currentHours}</span>
  </div>
  <p><i>${data.stationName}</i>측정소 기준</p>
  `;
};

export { initRender };
