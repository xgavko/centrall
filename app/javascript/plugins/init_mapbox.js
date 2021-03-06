import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    var center = JSON.parse(mapElement.dataset.center);

    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/light-v9',
      center: center,
      zoom: 15
    });

    if (mapElement.dataset.markers) {
    const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach(function(marker) {
        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(map);
      });
    };

    if (mapElement.dataset.marker) {
    const marker = JSON.parse(mapElement.dataset.marker);
    new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    };

  }
};

export { initMapbox };
