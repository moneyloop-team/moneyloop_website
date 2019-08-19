$(document).on('turbolinks:load', function() {
    "use strict";

    // Slider for the static page
    $(".home-slider").owlCarousel({
        animateOut:'fadeOut',
        animateIn: 'fadeIn',
        items:1,
        loop:true,
        dots:true,
        center:true,
        autoplay: true,
        smartSpeed: 3000,
        margin:10
    });

    // Slider for partners
    $(".partners-slider").owlCarousel({
        animateOut:'fadeOut',
        items:4,
        loop:true,
        dots:false,
        center:true,
        autoplay: true,
        smartSpeed: 10000,
        margin:10
    });

    // Slider for testimonials
    $(".testimonials-slider").owlCarousel({
        animateOut:'fadeOut',
        items:3,
        loop:true,
        dots:true,
        center:true,
        autoplay:true,
        smartSpeed: 1000,
        autoplayTimeout: 10000,
        margin:60
    });
});