const geolocButton = function() {
  const btn = document.getElementById('geoloc');
  const ad_field = document.getElementById('participation_address');

  if (btn) {
    btn.addEventListener('click', (event) => {
      var gpsBulletEl = document.querySelector('.gps-bullet');
      gpsBulletEl.classList.add('gps-bullet-animate');
      navigator.geolocation.getCurrentPosition(function(location) {
        var lat = location.coords.latitude;
        var lng = location.coords.longitude;
        var latlng = {lat: lat, lng: lng};
        console.log(latlng);
        var geocoder = new google.maps.Geocoder;

        geocoder.geocode({'location': latlng}, function(results, status) {
          var address = results[0].formatted_address;
          ad_field.value = address;
          gpsBulletEl.classList.remove('gps-bullet-animate');
        });
      });
    });
  }
}

export { geolocButton };
