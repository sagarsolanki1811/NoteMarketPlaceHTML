///*login.html JS for validate inputs*/
$(document).ready(function ()
{
  window.addEventListener(
    "load",
    function ()
    {
      var forms = document.getElementsByClassName("needs-validation");
      var validation = Array.prototype.filter.call(forms, function (form)
      {
        form.addEventListener(
          "submit",
          function (event)
          {
            if (form.checkValidity() === false) {
              event.preventDefault();
              event.stopPropagation();
            }
            form.classList.add("was-validated");
          },
          false
        );
      });
    }, false
  );

  $(".toggle-password").click(function ()
  {
    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $($(this).attr("toggle"));
    if (input.attr("type") === "password") {
      input.attr("type", "text");
    } else {
      input.attr("type", "password");
    }
  });

  //open button code
  $('#mobile-nav-open-btn').click(function ()
  {
    $('#mobile-nav').css("height", "100%");
  });
  //close button code
  $('#mobile-nav-close-btn').click(function ()
  {
    $('#mobile-nav').css("height", "0%");
  });

  
  $("input[name='IsPaid']").click(function ()
  {
      if ($("#Paid").is(":checked")) {
          $("#toggleDiv").show();
          $('#Sell_Price').prop('readOnly', false);
    } else {
        $("#toggleDiv").show();
        $('#Sell_Price').prop('readOnly', true);
        $('#Sell_Price').val(0);
    }
  });

    $('#uploadPreview').change(function () {
        var i = $(this).prev('label').clone();
        var file = $('#uploadPreview')[0].files[0].name;
        $(this).prev('label').text(file);
    });


    function submit() {
        document.getElementById("searchform").submit();
    }

  /*  $("input[name='IsPaid']").click(function () {
        if ($("#Paid").is(":checked")) {
            $("#Sell_Price").prop("readOnly",true);
        } else {
            $("#Sell_Price").prop("readOnly", false);
        }
    });
  */
});








  //
  // if(document.getElementById("free").checked = true){
  //   $('.toggleDiv').css("display","hidden");
  // }

//   $('input[type="radio"]').click(function (){
//     if($(this).attr('id') === 'free') {
//       $('#toggleDiv').show();           
//     }
//     else {
//       $('#toggleDiv').hide();   
//  }
// });

// //login.html JS for password show/hide
//   // $(document).ready(function () {
//     $(".toggle-password").click(function () {
//       $(this).toggleClass("fa-eye fa-eye-slash");
//       var input = $($(this).attr("toggle"));
//       if (input.attr("type") === "password") {
//         input.attr("type", "text");
//       } else {
//         input.attr("type", "password");
//       }
//     });
//   // }); 

  //FAQ page icon change
  // $(document).ready(function(){
  //   $(".fa-plus").click(function(){
  //     $(this).toggleClass("fa-plus fa-minus");
  //   });
  //   $(".faqLink").click(function(){
  //     $(this).$(".faqLink i").toggleClass("fa-plus fa-minus");
  //   });
  // });
  
//sticky header
//   $(function(){
//     showHideNav();
//     $(window).scroll(function(){
//         showHideNav();
//     });
//     function showHideNav(){
//         if($(window).scrollTop() > 50){
//             $("nav").addClass("white-nav-top");
//             $(".navbar-brand img").attr("src","logo/logo.png");
//         }else{
//             $("nav").removeClass("white-nav-top");
//             $(".navbar-brand img").attr("src","logo/top-logo.png");
//         }
//     }
// });

// $(window).on("load",function(){
//   showHideNav();
//   $(window).scroll(function(){
//       showHideNav();
//   });
//   function showHideNav(){
//       if($(window).scrollTop() > 50){
//           $("nav").addClass("white-nav-top");
//           $(".navbar-brand img").attr("src","logo/logo.png");
//       }else{
//           $("nav").removeClass("white-nav-top");
//           $(".navbar-brand img").attr("src","logo/top-logo.png");
//       }
//   }
// });


// $(document).ready(function(){
//   showHideNav();
//   $(window).scroll(function(){
//       showHideNav();
//   });
//   function showHideNav(){
//       if($(window).scrollTop() > 50){
//           $("nav").addClass("white-nav-top");
//           $(".navbar-brand img").attr("src","logo/logo.png");
//       }else{
//           $("nav").removeClass("white-nav-top");
//           $(".navbar-brand img").attr("src","logo/top-logo.png");
//       }
//   }
// });