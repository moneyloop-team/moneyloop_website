$(document).on('turbolinks:load', function() {
    "use strict";

    // Slider for the home page
    $(".home-slider").owlCarousel({
        animateOut:'fadeOut',
        items:1,
        loop:true,
        dots:false,
        center:true,
        autoplay: true,
        smartSpeed: 1000,
        margin:10
    });
});