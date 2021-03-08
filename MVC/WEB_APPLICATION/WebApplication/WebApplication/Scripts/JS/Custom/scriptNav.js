$(document).ready(function () {
    showHideNav();
    $(window).scroll(function(){
        showHideNav();
    });
    function showHideNav(){
        if($(window).scrollTop() > 50){
            $("nav").addClass("white-nav-top");
            $(".navbar .navbar-brand img").attr("src", "~/Content/Logo/logo.png");
        }else{
            $("nav").removeClass("white-nav-top");
            $(".navbar .navbar-brand img").attr("src", "~/Content/Logo/top-logo.png");
        }
    }
});