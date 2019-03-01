import "popper.js";
import "bootstrap";

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete.js';
import '../components/flyoutnavbar.js';
import '../components/geolocation.js';

initMapbox();
initAutocomplete();
