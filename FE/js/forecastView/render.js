const initRender = () => {
  const wholeTag = forecastTag();

  document.body.innerHTML += wholeTag;
};

const forecastTag = () => {
  return `
  <div id="forecast" class="tab-container forecast">
    <h2>미세먼지 예보</h2>
    <p>Paris is the capital of France.</p>
  </div>
  `;
};
