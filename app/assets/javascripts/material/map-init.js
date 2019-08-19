function initAutocomplete() {
    var optionsT = {
      types: ['geocode'],
      componentRestrictions: {country: "au"}
    };
    var input = document.getElementById('address');
    var autocomplete = new google.maps.places.Autocomplete(input, optionsT);
    // Bind the map's bounds (viewport) property to the autocomplete object,
    // so that the autocomplete requests use the current map bounds for the
    // bounds option in the request.
    // Set the data fields to return when the user selects a place.
    autocomplete.setFields(
    ['address_components', 'geometry', 'icon', 'name']);
    autocomplete.addListener('place_changed', function() {
      var place = autocomplete.getPlace();
      if (!place.geometry) {
        // User entered the name of a Place that was not suggested and
        // pressed the Enter key, or the Place Details request failed.
        window.alert("No details available for input: '" + place.name + "'");
        return;
      }
    });
  }