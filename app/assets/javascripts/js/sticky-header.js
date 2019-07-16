$(document).on('turbolinks:load', function() {
    "use strict";
    if ($(window).width() >= "768") {
        $(".nav_bar").sticky({ topSpacing: 0 });
    }
});