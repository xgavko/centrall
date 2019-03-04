import "popper.js";
import "bootstrap";

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete.js';
import { geolocButton } from '../components/geolocation.js';
import '../components/flyoutnavbar.js';
import '../components/boarding.js';

initMapbox();
initAutocomplete();
geolocButton();


window.geolocButton = geolocButton;
window.createElementFromHTML = function(htmlString) {
  var div = document.createElement('div');
  div.innerHTML = htmlString.trim();
  // Change this to div.childNodes to support multiple top-level nodes
  return div.firstChild;
}
