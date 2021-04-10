/*========================================================
                         Login
========================================================*/

$(".toggle-password").click(function () {

    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $($(this).attr("toggle"));
    if (input.attr("type") == "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});

/*========================================================
                         Header
========================================================*/

/*
function sticky_header() {
    var header_height = jQuery('.site-header').innerHeight() / 2;
    var scrollTop = jQuery(window).scrollTop();;
    if (scrollTop > header_height) {
        jQuery('body').addClass('sticky-header');
    } else {
        jQuery('body').removeClass('sticky-header');
    }
}

jQuery(document).ready(function () {
  sticky_header();
});

jQuery(window).scroll(function () {
  sticky_header();  
});
jQuery(window).resize(function () {
  sticky_header();
});*/

/*========================================================
                         FAQ
========================================================*/


$(function () {

    $(".faq-add").on("click", function () {
        $(".faq-add").attr("src", "../../images/FAQ/minus.png");
        $(".faq-header").css("background-color", "#ffffff");
        $(".faq-header").css("border", "none");
        $(".card").css("border", "1px solid #d1d1d1");
        $(".card").css("height", "120px");
        $(this).removeClass("faq-add").addClass("faq-minus");
    });

});

$(function () {

    $(".faq-minus").on("click", function () {
        $(".faq-minus").attr("src", "../../images/FAQ/add.png");
        $(".faq-header").css("background-color", "#f3f3f3");
        $(".faq-header").css("border", "none");
        $(".card").css("border", "1px solid #d1d1d1");
        $(".card").css("height", "60px");
        $(this).removeClass("faq-minus").addClass("faq-add");
    });

});

/* ==================================
            Accodion
====================================*/
$(document).ready(function () {

    for (let i = 1; i <= 7; i++) {
        $(".showdata" + i).click(function () {
            $(".mybody" + i).show();
            $(".myhead" + i).hide();
        });
        $(".hidedata" + i).click(function () {
            $(".mybody" + i).hide();
            $(".myhead" + i).show();
        });
    }
});


/*========================================================
                Navigation
========================================================*/

/* Show & Hide White Navigation*/
$(function () {

    // show/hide nav on page load
    showHideNav();

    $(window).scroll(function () {

        // show/hide nav on window's scroll
        showHideNav();
    });


    function showHideNav() {

        if ($(window).scrollTop() > 50) {

            $(".site-header").css("height", "100px");
            $(".site-header").css("box-shadow", "0px 0px 30px 0px rgba(0,0,0,0.08)");

        } else {
            $(".site-header").css("height", "80px");
            $(".site-header").css("box-shadow", "none");

        }

    }

});



/*========================================================
                Moblile Menu
========================================================*/

$(function () {

    // Show mobile nav
    $("#mobile-nav-open-btn").click(function () {

        $("#mobile-nav").css("height", "100%");

    });

    // Hide mobile nav
    $("#mobile-nav-close-btn, #mobile-nav a").click(function () {

        $("#mobile-nav").css("height", "0%");

    });

});