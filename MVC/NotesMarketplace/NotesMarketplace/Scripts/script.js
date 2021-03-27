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
    $(".faq-header button").on("click", function () {
        $(this).parent().css("display", "none");
    });

    $(".faq-answer button").on("click", function () {
        $("#" + $(this).parent().parent().parent().attr("aria-labelledby")).css("display", "flex");
    });
});
/*
$(function () {
    
   $(".faq-add").on("click", function () {
       $(".faq-add").attr("src","../../images/FAQ/minus.png");
       $(".faq-header").css("background-color","#ffffff");
       $(".faq-header").css("border","none");
       $(".card").css("border","1px solid #d1d1d1");
       $(".card").css("height","120px");
       $(this).removeClass("faq-add").addClass("faq-minus");
   }); 
    
});

$(function () {

     $(".faq-minus").on("click", function () {
       $(".faq-minus").attr("src","../../images/FAQ/add.png");
       $(".faq-header").css("background-color","#f3f3f3");
       $(".faq-header").css("border","none");
       $(".card").css("border","1px solid #d1d1d1");
       $(".card").css("height","60px");
       $(this).removeClass("faq-minus").addClass("faq-add");
   }); 
    
});*/

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

            /*For home header*/
            $(".site-header-home").css("height", "100px");
            $(".site-header-home").css("background-color", "#ffffff");
            $("#logo-home").attr("src", "../../images/images/logo.png");
            $(".site-header-home .header-wrapper .navigation-wrapper .main-nav .menu-navigation>li a").css("color", "#333333");
            $(".site-header-home .header-wrapper .navigation-wrapper .main-nav .menu-navigation #logout").css("background-color", "#6255a5");
            $(".site-header-home .header-wrapper .navigation-wrapper .main-nav .menu-navigation #logout").css("color", "#fff");
            $(".site-header-home").css("box-shadow", "0px 0px 30px 0px rgba(0,0,0,0.08)");

        } else {
            $(".site-header").css("height", "80px");
            $(".site-header").css("box-shadow", "none");


            /*For home header*/
            $(".site-header-home").css("height", "80px");
            $(".site-header-home").css("background-color", "transparent");
            $("#logo-home").attr("src", "../../images/images/top-logo.png");
            $(".site-header-home .header-wrapper .navigation-wrapper .main-nav .menu-navigation>li a").css("color", "#ffffff");
            $(".site-header-home .header-wrapper .navigation-wrapper .main-nav .menu-navigation #logout").css("background-color", "#ffffff");
            $(".site-header-home .header-wrapper .navigation-wrapper .main-nav .menu-navigation #logout").css("color", "#6255a5");
            $(".site-header-home").css("box-shadow", "none");

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



/*========================================================
                Navigation - Submenu
========================================================*/
$(function () {
    $('.navigation-submenu').on('click', function () {
        $(this).toggleClass('open');
    });
});