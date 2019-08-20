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
