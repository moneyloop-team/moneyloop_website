$(document).on("ready",function(){"use strict";var t=$(".portfolioContainer");t.isotope({filter:"*",animationOptions:{duration:750,easing:"linear",queue:!1,columnWidth:".col-sm-3"}}),$(".portfolioFilter a").on("click",function(){$(".portfolioFilter .current").removeClass("current"),$(this).addClass("current");var i=$(this).attr("data-filter");return t.isotope({filter:i,animationOptions:{duration:750,easing:"linear",queue:!1}}),!1})});