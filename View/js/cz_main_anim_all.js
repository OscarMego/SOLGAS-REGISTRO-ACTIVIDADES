
function inicializarEventosMenuLateral() {

    $("#cz-util-hidden-left").click(function () {
        if ($("#cz-menu-lateral-left").width() != 0) {
            $("#cz-menu-lateral-left").animate({ width: "0px" }, 500);
            $(this).animate({ left: "0px" }, 500);
            $("#cz-box-content").animate({ left: "0px" }, 500);
            $("#cz-menu-lateral-left").css({ "display": "none" });
        } else {
            $("#cz-menu-lateral-left").animate({ width: "189px" }, 500);
            $(this).animate({ left: "190px" }, 500);
            $("#cz-box-content").animate({ left: "200px" }, 500);
            $("#cz-menu-lateral-left").css({ "display": "block" });
        }
    });

}

$(document).ready(function () {
    inicializarEventosMenuLateral();
});

