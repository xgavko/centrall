import moment from "moment";
import "moment-duration-format";

document.getElementById("restaurant-wrapper").addEventListener("load", initCountdownVote);

const initCountdownVote = () => {
  var votingTimeEl = document.querySelector(".boarding-time");
  if (!boardingTimeEl) {
    return;
  }
  var startAt = boardingTimeEl.dataset.start_at;

  var interval = 1000;
  var currentTime = moment().unix();
  var creationTime = moment(startAt).unix();
  var endTime = creationTime + 15 * 60;
  var mainDiffTime = (endTime - currentTime);
  var duration = moment.duration(mainDiffTime * interval, 'milliseconds');

  const timer = document.getElementById("timer");
  const button = document.querySelector(".geoloc-submit");
  timer.innerHTML = duration.format("hh:mm:ss");

  setInterval(function() {
    duration = moment.duration(duration - interval);
    timer.innerHTML = duration.format("hh:mm:ss");
  }, interval);
};

export { initCountdown };
