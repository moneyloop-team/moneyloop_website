$(document).on('turbolinks:load', function() {
    "use strict";

    // Slider for the home page
    $(".home-slider").owlCarousel({
        animateOut:'fadeOut',
        items:1,
        loop:true,
        dots:true,
        center:true,
        autoplay: true,
        smartSpeed: 3000,
        margin:10
    });

    // Slider for testimonials
    $(".testimonials-slider").owlCarousel({
        animateOut:'fadeOut',
        items:3,
        loop:true,
        dots:true,
        center:true,
        autoplay: true,
        smartSpeed: 1000,
        margin:10
    });
});