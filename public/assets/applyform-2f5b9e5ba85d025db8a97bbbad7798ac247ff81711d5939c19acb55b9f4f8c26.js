/**
 * jQuery DOB Picker
 * Website: https://github.com/tyea/dobpicker
 * Version: 1.0
 * Author: Tom Yeadon
 * License: BSD 3-Clause
 */


jQuery.extend({

	dobPicker: function(params) {

		// set the defaults		
		if (typeof(params.dayDefault) === 'undefined') params.dayDefault = 'Day';
		if (typeof(params.monthDefault) === 'undefined') params.monthDefault = 'Month';
		if (typeof(params.yearDefault) === 'undefined') params.yearDefault = 'Year';
		if (typeof(params.minimumAge) === 'undefined') params.minimumAge = 12;
		if (typeof(params.maximumAge) === 'undefined') params.maximumAge = 80;

		// set the default messages		
		$(params.daySelector).append('<option value="">' + params.dayDefault + '</option>');
		$(params.monthSelector).append('<option value="">' + params.monthDefault + '</option>');
		$(params.yearSelector).append('<option value="">' + params.yearDefault + '</option>');

		// populate the day select
		for (i = 1; i <= 31; i++) {
			if (i <= 9) {
				var val = '0' + i;
			} else {
				var val = i;
			}
			$(params.daySelector).append('<option value="' + val + '">' + i + '</option>');
		}

		// populate the month select		
		var months = [
			"January",
			"February",
			"March",
			"April",
			"May",
			"June",
			"July",
			"August",
			"September",
			"October",
			"November",
			"December"
		];
			
		for (i = 1; i <= 12; i++) {
			if (i <= 9) {
				var val = '0' + i;
			} else {
				var val = i;
			}
			$(params.monthSelector).append('<option value="' + val + '">' + months[i - 1] + '</option>');
		}

		// populate the year select
		var date = new Date();
		var year = date.getFullYear();
		var start = year - params.minimumAge;
		var count = start - params.maximumAge;
		
		for (i = start; i >= count; i--) {
			$(params.yearSelector).append('<option value="' + i + '">' + i + '</option>');
		}
		
		// do the logic for the day select
		$(params.daySelector).change(function() {
			
			$(params.monthSelector)[0].selectedIndex = 0;
			$(params.yearSelector)[0].selectedIndex = 0;
			$(params.yearSelector + ' option').removeAttr('disabled');
			
			if ($(params.daySelector).val() >= 1 && $(params.daySelector).val() <= 29) {
			
				$(params.monthSelector + ' option').removeAttr('disabled');
				
			} else if ($(params.daySelector).val() == 30) {
			
				$(params.monthSelector + ' option').removeAttr('disabled');
				$(params.monthSelector + ' option[value="02"]').attr('disabled', 'disabled');
				
			} else if($(params.daySelector).val() == 31) {
			
				$(params.monthSelector + ' option').removeAttr('disabled');
				$(params.monthSelector + ' option[value="02"]').attr('disabled', 'disabled');
				$(params.monthSelector + ' option[value="04"]').attr('disabled', 'disabled');
				$(params.monthSelector + ' option[value="06"]').attr('disabled', 'disabled');
				$(params.monthSelector + ' option[value="09"]').attr('disabled', 'disabled');
				$(params.monthSelector + ' option[value="11"]').attr('disabled', 'disabled');
				
			}
			
		});
		
		// do the logic for the month select
		$(params.monthSelector).change(function() {
			
			$(params.yearSelector)[0].selectedIndex = 0;
			$(params.yearSelector + ' option').removeAttr('disabled');
			
			if ($(params.daySelector).val() == 29 && $(params.monthSelector).val() == '02') {
			
				$(params.yearSelector + ' option').each(function(index) {
					if (index !== 0) {
						var year = $(this).attr('value');
						var leap = !((year % 4) || (!(year % 100) && (year % 400)));
						if (leap === false) {
							$(this).attr('disabled', 'disabled');
						}
					}
				});
				
			}
			
		});
		
	}
	
});
$(document).ready(function(){
    $.dobPicker({
        daySelector: '#dobday',
        monthSelector: '#dobmonth',
        yearSelector: '#dobyear',
        dayDefault: 'Day',
        monthDefault: 'Month',
        yearDefault: 'Year',
        minimumAge: 18,
        maximumAge: 110
    });
    document.getElementById('resolution').value = screen.width + "*" + screen.height;
});
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
;
// Scripts required in :applyform



;
