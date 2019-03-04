import _ from "underscore";
import moment from "moment";
import "moment-duration-format";


var currentTime = moment().unix();
var creationTime = moment(document.querySelector(".boarding-time").dataset.start_at).unix();
var intervall = 1000;
var endTime = creationTime + 15000;
var duration = (endTime - currentTime) * 1000;

const button = document.querySelector(".geoloc-submit")
button.addEventListener('click', (event) => {

});
