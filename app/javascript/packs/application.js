import "popper.js";
import "bootstrap";

import { initAutocomplete } from '../plugins/init_autocomplete.js';
import {} from '../components/flyoutnavbar.js';
import {} from '../components/geolocation.js';

import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';

initAutocomplete();
initMapbox();
