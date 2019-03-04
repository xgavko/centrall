import _ from "underscore";
import moment from "moment";
import "moment-duration-format";


const initCountdown = () => {
  var boardingTimeEl = document.querySelector(".boarding-time");
  if (!boardingTimeEl) {
    return;
  }

  var currentTime = moment().unix();
  var creationTime = moment(boardingTimeEl.dataset.start_at).unix();
  var interval = 1000;
  var endTime = creationTime + 15000;
  var mainDiffTime = (endTime - currentTime) * 1000;
  var duration = moment.duration(mainDiffTime, 'milliseconds');

  $('#main-passage .countdown').html(duration.format("hh:mm:ss"));

  const button = document.querySelector(".geoloc-submit");

  button.addEventListener('click', (event) => {
    getElementById("boarding-3").html(duration.format("hh:mm:ss"));
      }, interval);
}

export { initCountdown };
