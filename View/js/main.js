$(document).ready(function () {
    $('body').on('click', '.hideFilter', function () {
        $(".filtergrid").hide();
        $(this).removeClass('hideFilter').addClass('showFilter');
    });
    $('body').on('click', '.showFilter', function () {
        $(".filtergrid").show();
        $(this).removeClass('showFilter').addClass('hideFilter');
    });
    $('.embed-container').css({ "padding-bottom": ((($(window).height() - 80) / $(window).width()) * 100) + "%" });
    $(window).on('resize', function () {
        var win = $(this); //this = window
        $('.embed-container').css({ "padding-bottom": (((win.height() - 80) / win.width()) * 100) + "%" });
        //console.log((win.height() / win.width()) * 100);
        //console.log(win.height());
        //console.log(win.width());
    });
    $('body').on("mouseenter", ".menu>.dropdown", function (event) {
        $(this).addClass("open");
    });
    $('body').on("mouseleave", ".menu>.dropdown", function (event) {
        $(this).removeClass("open");
    });

  $('[data-toggle="datepicker"]').each(function(id, item) {
      var dp = $(item).children('input').datepicker();
    $(item).find('button').click(function() {
      dp.datepicker('show');
    });
    $(item).children('input').on('changeDate', function (ev) {
        $(this).datepicker('hide');
    });
  });
  //$('input[type="date"]').attr('type', 'text').attr('placeholder', 'Fecha');
  $('.navbar-toggle').click(function() {
    $('body').toggleClass('toggled');
  });
});

