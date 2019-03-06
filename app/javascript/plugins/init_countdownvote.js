import moment from "moment";
import "moment-duration-format";

const initCountdownVote = () => {
  var votingTimeEl = document.querySelector(".wrapper-voting");
  if (!votingTimeEl) {
    return;
  }
  var startAt = votingTimeEl.dataset.updated_at;
  var interval = 1000;
  var currentTime = moment().unix();
  var creationTime = moment(startAt).unix();
  var endTime = creationTime + 15 * 60;
  var mainDiffTime = (endTime - currentTime);
  var duration = moment.duration(mainDiffTime * interval, 'milliseconds');

  var timer = document.getElementById("timer-navbar");
  timer.innerHTML = duration.format("hh:mm:ss");

  setInterval(function() {
    duration = moment.duration(duration - interval);
    timer.innerHTML = duration.format("hh:mm:ss");
  }, interval);
};

export { initCountdownVote };

