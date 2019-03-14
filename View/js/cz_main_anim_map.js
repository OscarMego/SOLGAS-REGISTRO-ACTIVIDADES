
function inicializarEventosMenuLateral() {

    $("#cz-util-hidden-left").click(function () {
        if ($("#cz-menu-lateral-left").css("display") != "none") {
            $("#cz-menu-lateral-left").animate({ width: "0px" }, 500);
            $(this).animate({ left: "0px" }, 500);
            $("#cz-box-content").animate({ left: "0px" }, 500);
            $("#cz-menu-lateral-left").css({ "display": "none" });
        } else {
            $("#cz-menu-lateral-left").animate({ width: "260px" }, 500);
            $(this).animate({ left: "261px" }, 500);
            $("#cz-box-content").animate({ left: "270px" }, 500);
            $("#cz-menu-lateral-left").css({ "display": "block" });
        }
    });

    $("#cz-util-hidden-right").click(function () {
        /*if ($("#cz-menu-lateral-right").css("width") == "349px") {
            $("#cz-menu-lateral-right").animate({ width: "499px" }, 500);
            $(this).animate({ right: "500px" }, 500);
            $("#cz-box-content").animate({ right: "509px" }, 500);
            $("#cz-menu-lateral-right").css({ "display": "block" });
        }else */if ($("#cz-menu-lateral-right").css("display") != "none") {
            $("#cz-menu-lateral-right").animate({ width: "0px" }, 500);
            $(this).animate({ right: "0px" }, 500);
            $("#cz-box-content").animate({ right: "0px" }, 500);
            $("#cz-menu-lateral-right").css({ "display": "none" });
        } else {
            $("#cz-menu-lateral-right").animate({ width: "349px" }, 500);
            $(this).animate({ right: "350px" }, 500);
            $("#cz-box-content").animate({ right: "359px" }, 500);
            $("#cz-menu-lateral-right").css({ "display": "block" });
        }
        /*

        if ($("#cz-menu-lateral-right").css("display") != "none") {
            $("#cz-menu-lateral-right").animate({ width: "0px" }, 500);
            $(this).animate({ right: "0px" }, 500);
            $("#cz-box-content").animate({ right: "0px" }, 500);
            $("#cz-menu-lateral-right").css({ "display": "none" });
        } else if ($("#cz-menu-lateral-right").css("width") == "349px") {
            $("#cz-menu-lateral-right").animate({ width: "449px" }, 500);
            $(this).animate({ right: "450px" }, 500);
            $("#cz-box-content").animate({ right: "459px" }, 500);
            $("#cz-menu-lateral-right").css({ "display": "block" });
        } else {
            $("#cz-menu-lateral-right").animate({ width: "349px" }, 500);
            $(this).animate({ right: "350px" }, 500);
            $("#cz-box-content").animate({ right: "359px" }, 500);
            $("#cz-menu-lateral-right").css({ "display": "block" });
        }*/
    });

}

$(document).ready(function () {
    inicializarEventosMenuLateral();
});

