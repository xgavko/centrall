import "popper.js";
import "bootstrap";

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete.js';
import {} from '../components/flyoutnavbar.js';
import {} from '../components/geolocation.js';

initMapbox();
initAutocomplete();
