import { qs$ } from "../lib/util.js";

const renderLocation = location => {
  qs$(".info-location").innerText = location;
};

export { renderLocation };
