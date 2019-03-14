var cz_file_detection = false;
var cz_count_detectionnow = 0;
var setI;
var cz_update = false;
var cz_expand = false;;

function retornarMenu(pagina) {
    var target = '';
    var data = [pagina];
    var url = 'Main.aspx'
    postData(url, data, target);
    //window.location.href = 'Main.aspx?pagina=' + pagina;
}

function irMenuMapa() {
    var data = [''];
    var target = '';
    var url = 'MainMapa.aspx';
    postData(url, data, target);
    //window.location.href =  'MainMapa.aspx';
}

function irMenuMapaInicio() {

    window.parent.location = 'MainMapa.aspx';
}


function postData(url, data, target) {
    var form = $('<form></form>');
    $(form).hide().attr('method', 'post').attr('action', url);
    if (target != '') {
        $(form).attr('target', target);
    }
    for (i in data) {
        var input = $('<input type="hidden" />').attr('name', i).val(data[i]);
        $(form).append(input);
    }
    $(form).appendTo('body').submit();
}

function detectfile() {
    $(document).ready(function () {
        if (!cz_file_detection) {
            setI = setInterval(function () {
                var cz_count_i = 0;

                $('#file-upload-panel ul.qq-upload-list li:not(".list")').each(function () {
                    cz_count_i++;
                    if (cz_count_i > cz_count_detectionnow) {
                        cz_count_detectionnow++;
                        cz_update = true;
                        ////console.log("AGREGANDO UN NUEVO ARCHIVO: " + cz_count_detectionnow);
                        cz_count_detectionnow = 0;
                        cz_file_detection = false;
                        $(this).addClass("list");
                        $("#cz-form-step-files").append('<div class="cz-form-step-image-progress-examinar-content-row-file" rel="' + $(this).attr("qqfileid") + '"><div class="cz-form-step-image-progress-examinar-content-row-name">' + $(this).find(".file-info-name span.qq-upload-file").html() + '</div><div class="cz-form-step-image-progress-examinar-content-row-size">' + $(this).find(".file-info-size .qq-upload-size").html() + '</div><div class="cz-form-step-image-progress-examinar-content-row-option"><div class="cz-form-step-image-progress-examinar-content-row-option-remove cz-form-content-input-button boton-borrar">×</div></div></div>');
                    }
                });

                if (cz_update) {
                    clearTimeout(setI);
                    cz_update = false;
                }

            }, 500);
        }
    });
}


function listgeo() {
    //console.log("listgeo()");
    $(document).ready(function () {
        $("#cz-modal-geo-option1").hide();
        $("#cz-modal-geo-option2").show();
        $("#cz-modal-geo-option3").hide();
        return false;
    });
}

function creategeo() {
    //console.log("creategeo()");
    $(document).ready(function () {
        $("#cz-modal-geo-option1").hide();
        $("#cz-modal-geo-option2").hide();
        $("#cz-modal-geo-option3").show();
        return false;
    });
}





function addnotify(type, message, rel) {
    $(document).ready(function () {
        /*  
        Tipos de notificaciones:
        - notify
        - alert
        
        Ejemplo de uso:
        addnotify("notify", "El mensaje", "id");
        
        Explicacion de uso:
        - El primer parametro es el nombre del tipo de notificacion.
        - El segundo parametro es el mensaje a mostrar.
        - El ultimo es un parametro que lo identificara como unico.
        Si agregan muchas notificaciones con el mismo id, el anterior se destruira mostrando 
        este nuevo mensaje, asi evitando que se duplique los mensajes, como por ejemplo: "Complete todos los campos."
        */

        if (top.location != this.location) {
            window.parent.addnotify(type, message, rel);
        } else {
            if (rel != "") {
                $('#content-notify>.notify[rel="' + rel + '"]').remove();
            }

            $('<div class="' + type + '" rel="' + rel + '">' + message + '</div>').appendTo("#content-notify").animate({ "left": "0px" }, 300).delay(5000).animate({
                "left": "340px"
            }, {
                duration: 300,
                complete: function () { $(this).remove(); }
            });
        }
    });
}


function unclick() {
    $(document).ready(function () {
        ////console.log("fuera");
        //$(".cz-principal-menu-suboptions").hide();
        $("#cz-control-menu-options").hide();
        $("#calendarwindow").css("visibility", "hidden");
    });
}

function cz_foto_event() {
    ////console.log("paso de foto");
    var i = 1;
    setTimeout(function () {
        $(".carousel-inner .item").each(function () {
            if ($(this).hasClass("active")) {
                ////console.log(i);
                $("#cz-modal-fotos-buttons .cz-modal-fotos-buttons-text").html(i);
                $(".carousel-indicators li").removeClass("active");
                var e = 1;
                $(".carousel-indicators li").each(function () {
                    if (e == i) {
                        $(this).addClass("active");
                    }
                    e++;
                });
            }
            i++;

        });
    }, 700);
}

function nextconfirm() {
    $(document).ready(function () {
        if ($("#cz-form-step-files div.cz-form-step-image-progress-examinar-content-row-file").length > 0) {
            $(".cz-form-step-examinar").hide();
            $(".siguiente-confirm").hide();
            $("#siguiente-box-update").show();
            $(".cz-form-step-image-progress-title").html("Confirmacion de subida de archivos examinados");
            $("#cz-form-step-image-text-left").removeClass("cz-form-step-image-complete").addClass("cz-form-step-image-complete-full");
            $("#cz-form-step-image-text-center").addClass("cz-form-step-image-complete");
            $(".cz-form-step-image-progress-examinar-content-row-option-remove").hide();
            $(".boton-eject").show();
        } else {
            addnotify("notify", "Necesita examinar un archivo para continuar.", "upload-data");
        }
    });
}

function nextupload() {
    $(document).ready(function () {
        $("#cz-form-step-image-text-center").removeClass("cz-form-step-image-complete").addClass("cz-form-step-image-complete-full");
        $("#cz-form-step-image-text-right").addClass("cz-form-step-image-complete-end");
        $(".boton-ejecutar:first").click();
        $("#cz-form-table").show();
        $("#cz-form-step-image-progress-examinar").hide();
        $(".boton-eject").hide();
    });
}

function newupload() {
    $(document).ready(function () {
        cz_file_detection = false;
        cz_count_detectionnow = 0;
        cz_update = false;

        $("#myModal").html('');
        $('#divGridViewData').html('');

        $("#cz-form-step-files").html("");
        detectfile();
        $("#cz-form-table").hide();
        $(".cz-form-step-examinar").show();
        $(".siguiente-confirm").show();
        $("#siguiente-box-update").hide();
        $(".cz-form-step-image-progress-title").html("Examinar archivos a la lista");
        $("#cz-form-step-image-text-left").removeClass("cz-form-step-image-complete-full").addClass("cz-form-step-image-complete");
        $("#cz-form-step-image-text-right").removeClass("cz-form-step-image-complete-end");
        $("#cz-form-step-image-text-center").removeClass("cz-form-step-image-complete-full");
        $("#cz-form-step-image-progress-examinar").show();
        $(".cz-form-step-image-progress-examinar-content-row-option-remove").show();
    });
}

function change_page() {
    $(document).ready(function () {
        var ant_url = $("#centerFrame").contents().get(0).location.href;
        var ant_url_fragments = ant_url.split("/");
        var ant_namepage = ant_url_fragments[ant_url_fragments.length - 1];

        if (ant_namepage == "carga.aspx") {
            $("#centerFrame").contents().find(".cz-form-step-image-progress-examinar-content-row-option-remove").click();
        }
    });
}

function inicializarEventos() {
    $('.cz-principal-menu-suboptions', window.parent.document).hide();

    $('html').click(function () {
        /* Clic fuera de lugar*/
        ////console.log("html:click");
        unclick();
        if (top.location != this.location) {
            window.parent.unclick();
        }
    });

    function detectallcheck() {
        var isallcheck = true;
        $(".cz-form-iterator .cz-form-iterator-group").each(function () {
            isallcheck = true;

            $(this).find(".cz-form-iterator-group-opciones").each(function () {
                if (!$(this).find("input.opcmenu").prop("checked")) {
                    isallcheck = false;
                }
            });
            if (isallcheck) {
                $(this).find(".cz-form-iterator-group-category input.catmenu").prop("checked", "checked");
            } else {
                $(this).find(".cz-form-iterator-group-category input.catmenu").prop("checked", "");
            }

        });
    }

    detectallcheck();

    $(".catmenu").click(function () {
        if ($(this).prop("checked")) {
            $(this).parent().parent().find(".cz-form-iterator-group-opciones .opcmenu").prop("checked", "checked").val("1");
        } else {
            $(this).parent().parent().find(".cz-form-iterator-group-opciones .opcmenu").prop("checked", "").val("0");
        }
    });

    $(".opcmenu").click(function () {
        if ($(this).prop("checked")) {
            $(this).val("1");
        } else {
            $(this).val("0");
        }
        detectallcheck();
    });

    $("body").on("click", "#cz-form-step-image-text-left", function () {
        //console.log("#cz-form-step-image-text-left:click");
        if ($("#cz-form-step-image-text-right").hasClass("cz-form-step-image-complete-end")) {
            cz_file_detection = false;
            cz_count_detectionnow = 0;
            cz_update = false;
            $("#cz-form-step-files").html("");
            detectfile();
        }
        $("#cz-form-table").hide();
        $(".cz-form-step-examinar").show();
        $(".siguiente-confirm").show();
        $("#siguiente-box-update").hide();
        $(".cz-form-step-image-progress-title").html("Examinar archivos a la lista");
        $("#cz-form-step-image-text-left").removeClass("cz-form-step-image-complete-full").addClass("cz-form-step-image-complete");
        $("#cz-form-step-image-text-right").removeClass("cz-form-step-image-complete-end");
        $("#cz-form-step-image-text-center").removeClass("cz-form-step-image-complete-full").removeClass("cz-form-step-image-complete");
        $("#cz-form-step-image-progress-examinar").show();
        $(".cz-form-step-image-progress-examinar-content-row-option-remove").show();
    });

    $("#cz-util-hidden-top").click(function () {
        var boxHeader = $(window.parent.document.getElementById("cz-box-header2"));
        if (boxHeader.css('top') == '0px') {

            boxHeader.animate({ top: "-120px" }, 500);
            $("#cz-box-header3").animate({ top: "-60px" }, 500);
            $('#cz-util-hidden-top').animate({ top: "0px" }, 500);
            $("#cz-box-body2").animate({ top: "10px" }, 500);


        } else {


            boxHeader.animate({ top: "0px" }, 500);
            $("#cz-box-header3").animate({ top: "46px" }, 500);
            $('#cz-util-hidden-top').animate({ top: "105px" }, 500);
            $("#cz-box-body2").animate({ top: "125px" }, 500);



        }
    });

    $(".cz-other-box-center-box-option").click(function () {
        location.href = $(this).find("a").attr("href");
    });

    $(".cz-maps-full").animate({ right: "310px" }, 500);

    $("#cz-util-hidden-right-ultpos-geo").click(function () {
        //console.log("#cz-util-hidden-right-ultpos-geo:click");
        if ($('.modalGeo').width() != 0) {
            $(".modalGeo").animate({ width: "0px" }, 500);
            $(this).animate({ right: "0px" }, 500);
            $(".cz-maps-full").animate({ right: "10px" }, 500);
        } else {
            $(".modalGeo").animate({ width: "300px" }, 500);
            $(this).animate({ right: "300px" }, 500);
            $(".cz-maps-full").animate({ right: "310px" }, 500);
        }
    });



    $(document).keypress(function (e) {
        if (e.which == 13) {
            if ($('.pagina-editor').is(":focus")) {
                //addnotify("notify", "LISTO VISTA TABLA CORRECTO", "pagina-tabla");
                //console.log('.pagina-editor:focusout');
                if ($('.pagina-editor').val() == "") {
                    $('.pagina-editor').val("1");
                }

                $('#contentTooltip').hide(100);
                var pagina_ir = parseInt($('.pagina-editor').val());
                var pagina_max = parseInt($('.pagina-maxima').html());
                //console.log(pagina_ir);
                //console.log(pagina_max);
                if (pagina_max >= pagina_ir && pagina_ir > 0) {
                    var strData = getParametros();
                    strData.pagina = parseInt($('.pagina-editor').val());
                    $.ajax({
                        type: 'POST',
                        url: urlbus,
                        contentType: "application/json; charset=utf-8",
                        async: true,
                        cache: false,
                        data: JSON.stringify(strData),
                        beforeSend: function () {
                            $(".paginator-data").hide();
                            $(".paginator-data-search").show();
                        },
                        success: function (data) {
                            $('.form-gridview-data').html(data);
                            $('#hdnActualPage').val(strData.pagina);
                            if ($(".form-grid-table-outer").hasClass("cz-table-expand-table")) {
                                $(".cz-table-expand").click();
                            }
                        },
                        error: function (xhr, status, error) {
                            $("#myModal").html(alertHtml('error', xhr.responseText));
                            $('#myModal').modal('show');
                        }
                    });
                } else {
                    addnotify("notify", "El numero ingresado excede el limite de la paginacion", "pagina-tabla");
                }
                e.preventDefault();
                return false;
            }
        } else {
            if ($('.pagina-editor').is(":focus")) {
                if (!(e.which > 47 && e.which < 58)) {
                    e.preventDefault();
                    return false;
                }
            }
        }


    });

    $(".cz-menu-lateral-title").hover(function () {
        $(this).find(".cz-menu-lateral-title-icon").stop().animate({ width: "35px" }, 200);
        $(this).find(".cz-menu-lateral-title-text").stop().animate({ width: "115px" }, 200);
    }, function () {
        $(this).find(".cz-menu-lateral-title-icon").stop().animate({ width: "0px" }, 200);
        $(this).find(".cz-menu-lateral-title-text").stop().animate({ width: "150px" }, 200);
    });

    $(".cz-menu-lateral-suboption").hover(function () {
        $(this).find("a").addClass("hover");
    }, function () {
        $(this).find("a").removeClass("hover");
    });

    $(".cz-menu-lateral-title").click(function () {
        //console.log(".cz-menu-lateral-title:click");
        $(".cz-menu-lateral-title").removeClass("cz-eclick");
        $(".cz-menu-lateral-title-status").html("+");
        $("#cz-menu-lateral-options .cz-menu-lateral-suboptions .cz-menu-right-options").animate({ height: 0 }, 300);
        if ($(this).parent().find(".cz-menu-lateral-suboptions").height() == 0) {
            $(this).addClass("cz-eclick");
            var count_submenus = $(this).parent().find(".cz-menu-lateral-suboption").length;
            $(this).parent().find(".cz-menu-lateral-suboptions").animate({ height: count_submenus * 31 + "px" }, 500);
            $(this).find(".cz-menu-lateral-title-status").html("-");
        } else {
            $(this).removeClass("cz-eclick");
            $(this).parent().find(".cz-menu-lateral-suboptions").animate({ height: 0 }, 500);
            $(this).find(".cz-menu-lateral-title-status").html("+");
        }
    });

    $(".cz-principal-menu-option").hover(function () {
        ////console.log(".cz-principal-menu-option:hover");
        $(this).find(".cz-principal-menu-option-button").addClass("cz-ehover");
    }, function () {
        $(this).find(".cz-principal-menu-option-button").removeClass("cz-ehover");
    });

    $(".cz-principal-menu-option").hover(function (e) {
        $(this).parent().find(".cz-principal-menu-suboptions:visible").hide();
        $(this).find(".cz-principal-menu-suboptions:hidden").show();
        e.stopPropagation();
    }, function () {
        $(this).parent().find(".cz-principal-menu-suboptions").hide();
        window.parent.unclick();
    });

    $(".cz-menu-lateral-suboption").click(function (e) {
        change_page();
        e.preventDefault();
        $("#centerFrame").attr("src", $(this).find("a").attr("href"));
        return false;
    });
    $(".dropdown-menu li").click(function (e) {
        change_page();
        e.preventDefault();
        console.log($(this).attr("salir"));
        if ($(this).attr("salir") == "1") {
            __doPostBack('opcSalir', '');
            return true;
        }
        if ($(this).attr("version") == "1") {
            $('#versionApp').trigger('click');
            $(this).parent().parent().parent().parent().removeClass("in");
            return true;
        }
        $("#centerFrame").attr("src", $(this).find("a").attr("href"));
        $(this).parent().parent().parent().parent().removeClass("in");
        return false;
    });

    $(".cz-control-menu-option").click(function (e) {
        //console.log(".cz-control-menu-option:click");

        if (!$(this).hasClass("parent")) {



            try {

                if ($('#menuframe').contents().find('#centerFrame').html() != null) {

                    $('#menuframe').contents().find('#centerFrame').attr("src", $(this).find("a").attr("href"));
                    $("#cz-control-menu-options").hide();
                }
                else {



                    $("#contentIframe").html("<iframe id='menuframe' src='menu.aspx' width='100%' height='" + $(document).height() + "' frameborder='0' scrolling='no' marginheight='0' marginwidth='0'  ><iframe>");
                    $("#cz-control-menu-options").hide();
                }


            }
            catch (err) {

                $("#contentIframe").html("<iframe id='menuframe' src='menu.aspx' width='100%' height='" + $(document).height() + "' frameborder='0' scrolling='no' marginheight='0' marginwidth='0'  ><iframe>");
                $("#cz-control-menu-options").hide();
            }





            e.preventDefault();
            return false;
        }
    });


    $(".cz-principal-menu-suboption").click(function (e) {
        change_page();
        $(".cz-principal-menu-suboptions").hide();
        $("#centerFrame").attr("src", $(this).find('[href]').attr("href"));

        e.preventDefault();
        return false;
    });


    $("#cz-box-footer2").click(function () {
        if (!cz_expand) {
            //console.log("expandiendo");
            if ($("#cz-util-hidden-top").css("top") != "0px") {
                $("#cz-util-hidden-top").click();
            }
            if ($("#cz-util-hidden-left").css("left") != "0px") {
                $("#cz-util-hidden-left").click();
            }
            if ($('#centerFrame').contents().find('#cz-util-hidden-right-ultpos-geo').css("right") != "0px") {
                $('#centerFrame').contents().find('#cz-util-hidden-right-ultpos-geo').click();
            }

            cz_expand = true;
        } else {
            //console.log("contrayendo");
            if ($("#cz-util-hidden-top").css("top") == "0px") {
                $("#cz-util-hidden-top").click();
            }
            if ($("#cz-util-hidden-left").css("left") == "0px") {
                $("#cz-util-hidden-left").click();
            }
            if ($('#centerFrame').contents().find('#cz-util-hidden-right-ultpos-geo').css("right") == "0px") {
                $('#centerFrame').contents().find('#cz-util-hidden-right-ultpos-geo').click();
            }

            cz_expand = false;
        }

    });

    $(".link").click(function (e) {
        change_page();
        $("#centerFrame").attr("src", $(this).find('a').attr("href"));
        e.preventDefault();
        return false;
    });

    $("#cz-control-menu").click(function (e) {
        window.parent.unclick();
        if ($("#cz-control-menu-options").is(':visible')) {
            $("#cz-control-menu-options").hide();
        } else {
            $("#cz-control-menu-options").show();
        }
        e.stopPropagation();
    });

    $(".cz-form-content-input-select").change(function () {
        $(this).parent().find(".cz-form-content-input-select-visible-text").html($(this).find("option:selected").text());
    });

    $(".cz-form-content-input-select").each(function () {

        $(this).parent().find(".cz-form-content-input-select-visible-text").html($(this).find("option:selected").text());
    });

    $("#calendarwindow").click(function (e) {
        e.stopPropagation();
    });

    $(".cz-form-content-input-select").hover(function () {
        $(this).parent().find(".cz-form-content-input-select-visible-button").addClass("hover");
    }, function () {
        $(this).parent().find(".cz-form-content-input-select-visible-button").removeClass("hover");
    });

    $(".cz-form-content-input-text").focus(function () {
        $(this).css("width", "167px");
        $(this).parent().find(".cz-form-content-input-text-visible-button").show();
    });

    $(".cz-form-content-input-text").focusout(function () {
        //$(this).css("width", "197px");
        //$(this).delay("slow").css("width", "197px");
        $(this).parent().find(".cz-form-content-input-text-visible-button").delay("fast").fadeOut(function () { $(this).parent().parent().find(".cz-form-content-input-text").css("width", "197px"); });

    });
    $(".cz-form-content-input-text-visible-button").click(function () {
        $(this).parent().parent().find(".cz-form-content-input-text").val("");

        //$(this).parent().parent().find(".cz-form-content-input-text").css("width", "197px");
        //$(this).hide();
    });

    $(".cz-form-content-input-text-calendar").on('click', function () {
        var calendar = new CalendarPopup("calendarwindow");
        calendar.setCssPrefix("NEXTEL");
        var txtname = $(this).parent().parent().parent().find("input.cz-form-content-input-calendar").attr("id");
        //console.log(txtname);
        calendar.select(eval("document.forms[0]." + txtname), $(this).attr("id"), 'dd/MM/yyyy');
        return false;
    });
    $(".cz-form-content-input-text-calendar-modal").on('click', function () {
        var calendar = new CalendarPopup("calendarwindowModal");
        calendar.setCssPrefix("NEXTEL");
        var txtname = $(this).parent().parent().parent().find("input.cz-form-content-input-calendar-modal").attr("id");
        console.log(txtname);
        calendar.select(eval("document.forms[2]." + txtname), $(this).attr("id"), 'dd/MM/yyyy');
        var MtxtFecha = $("#" + txtname);
        var MtxtFechaP = MtxtFecha.position()
        var MtxtFechaT = MtxtFechaP.top;
        var MtxtFechaL = MtxtFechaP.left;
        var MtxtFechaH = MtxtFecha.height();
        $('#calendarwindowModal').css({ 'left': MtxtFechaL + 40 + 'px', 'top': (MtxtFechaT + MtxtFechaH) + 22 + 'px' })
        return false;
    });

    //$("#btnlistgeo").click(function () {
    //    $("#cz-modal-geo-option1").hide();
    //    $("#cz-modal-geo-option2").show();
    //    $("#cz-modal-geo-option3").hide();
    //    return false;
    //});

    //$("#newGeo").click(function () {
    //    //console.log("#newGeo:click");
    //    $("#cz-modal-geo-option1").hide();
    //    $("#cz-modal-geo-option2").hide();
    //    $("#cz-modal-geo-option3").show();
    //    return false;
    //});

    $('#versionApp').click(function (e) {
        //console.log("#versionApp:click");
        $.ajax({
            type: 'POST',
            url: 'about/recuperarVersion.ashx',
            success: function (data) {
                $("#myModal2").html(data);
                $('#myModal2').modal('show');
            },
            error: function (xhr, status, error) {
                $("#myModal2").html(alertHtml('error', xhr.responseText));
                $('#myModal2').modal('show');
            }
        });
        e.preventDefault();
        return false;
    });

    $(".cz-u-expand-table").click(function (e) {
        //console.log(".cz-u-expand-table:click");
        if ($(this).attr("data-grid-id")) {
            $("#" + $(this).attr("data-grid-id")).find(".cz-table-expand").click();
        }
        e.preventDefault();
        return false;
    });

    $(".cz-form-box-content").on("click", ".cz-table-expand", function () {
        $(".cz-form-box-content").addClass("cz-form-box-content-hide");
        if ($(this).parent().parent().parent().parent().hasClass("form-grid-table-outer")) {
            $(this).parent().parent().parent().parent().addClass("cz-table-expand-table");
        } else if ($(this).parent().parent().parent().parent().parent().hasClass("form-grid-table-outer")) {
            $(this).parent().parent().parent().parent().parent().addClass("cz-table-expand-table");
        }
        $('#contentTooltip').hide(50);
        $(this).parent().parent().parent().css("opacity", "0").animate({ opacity: 1 }, 500);
        $(this).addClass("cz-table-contract").removeClass("cz-table-expand");
    });

    $(".cz-form-box-content").on("click", ".cz-table-contract", function () {
        $(".cz-form-box-content").removeClass("cz-form-box-content-hide");
        if ($(this).parent().parent().parent().parent().hasClass("form-grid-table-outer")) {
            $(this).parent().parent().parent().parent().removeClass("cz-table-expand-table");
        } else if ($(this).parent().parent().parent().parent().parent().hasClass("form-grid-table-outer")) {
            $(this).parent().parent().parent().parent().parent().removeClass("cz-table-expand-table");
        }
        $('#contentTooltip').hide(50);
        $(this).removeClass("cz-table-contract").addClass("cz-table-expand");
    });

    var czcontentnotify = $("<div></div>").attr("id", "content-notify");
    if (top.location == this.location) {
        czcontentnotify.appendTo("body");
    }

    $("body").on("click", ".cz-modal-geo-back", function () {
        $("#cz-modal-geo-option2").hide();
        $("#cz-modal-geo-option3").hide();
        $("#cz-modal-geo-option1").show();
    });

    $("body").on("click", ".cz-form-step-examinar", function () {
        //console.log(".cz-form-step-examinar:click");
        $("#file-uploader input[type=\"file\"]").click();
        detectfile();
    });

    $("body").on("click", ".cz-form-step-image-progress-examinar-content-row-option-remove", function () {
        console.log("se va a eliminar");
        var id = $(this).parent().parent().attr("rel");
        var $this = $(this);

        $("#file-upload-panel ul.qq-upload-list li").each(function () {
            if ($(this).attr("qqfileid") == id) {
                ////console.log("ENCONTRE AL NUMERO:" + $(this).attr("qqfileid"));
                $(this).find(".boton-borrar").click();
                cz_count_detectionnow = 0;
                cz_file_detection = false;
                //$("#cz-form-step-files").html("");
                //detectfile();
                $this.parent().parent().hide(500).removeClass("cz-form-step-image-progress-examinar-content-row-file");;

            }
        });


        $(".cz-form-content-input-text").focus(function () {

        });

    });
}

$(document).ready(function () {
    inicializarEventos();
    /*
    $(".cz-form-content-input-button").val(function (index, val) {
        if (val[0] != "[") {
            return "[ " + val + "_";
        } else {
            return val;
        }
    });
    */
});








/*
* --------------------------------------------------------------------
* jQuery inputToButton plugin
* Author: Scott Jehl, scott@filamentgroup.com
* Copyright (c) 2009 Filament Group 
* licensed under MIT (filamentgroup.com/examples/mit-license.txt)
* --------------------------------------------------------------------
*/
(function ($) {
    $.fn.visualize = function (options, container) {
        return $(this).each(function () {
            //configuration
            var o = $.extend({
                type: 'bar', //also available: area, pie, line
                width: $(this).width(), //height of canvas - defaults to table height
                height: $(this).height(), //height of canvas - defaults to table height
                appendTitle: true, //table caption text is added to chart
                title: null, //grabs from table caption if null
                appendKey: true, //color key is added to chart
                rowFilter: '*',
                colFilter: '*',
                colors: ['#be1e2d', '#666699', '#92d5ea', '#ee8310', '#8d10ee', '#5a3b16', '#26a4ed', '#f45a90', '#e9e744'],
                textColors: [], //corresponds with colors array. null/undefined items will fall back to CSS
                parseDirection: 'x', //which direction to parse the table data
                pieMargin: 20, //pie charts only - spacing around pie
                pieLabelsAsPercent: true,
                pieLabelPos: 'inside',
                lineWeight: 4, //for line and area - stroke weight
                barGroupMargin: 10,
                barMargin: 1, //space around bars in bar chart (added to both sides of bar)
                yLabelInterval: 30 //distance between y labels
            }, options);

            //reset width, height to numbers
            o.width = parseFloat(o.width);
            o.height = parseFloat(o.height);


            var self = $(this);

            //function to scrape data from html table
            function scrapeTable() {
                var colors = o.colors;
                var textColors = o.textColors;
                var tableData = {
                    dataGroups: function () {
                        var dataGroups = [];
                        if (o.parseDirection == 'x') {
                            self.find('tr:gt(0)').filter(o.rowFilter).each(function (i) {
                                dataGroups[i] = {};
                                dataGroups[i].points = [];
                                dataGroups[i].color = colors[i];
                                if (textColors[i]) { dataGroups[i].textColor = textColors[i]; }
                                $(this).find('td').filter(o.colFilter).each(function () {
                                    dataGroups[i].points.push(parseFloat($(this).text()));
                                });
                            });
                        }
                        else {
                            var cols = self.find('tr:eq(1) td').filter(o.colFilter).size();
                            for (var i = 0; i < cols; i++) {
                                dataGroups[i] = {};
                                dataGroups[i].points = [];
                                dataGroups[i].color = colors[i];
                                if (textColors[i]) { dataGroups[i].textColor = textColors[i]; }
                                self.find('tr:gt(0)').filter(o.rowFilter).each(function () {
                                    dataGroups[i].points.push($(this).find('td').filter(o.colFilter).eq(i).text() * 1);
                                });
                            };
                        }
                        return dataGroups;
                    },
                    allData: function () {
                        var allData = [];
                        $(this.dataGroups()).each(function () {
                            allData.push(this.points);
                        });
                        return allData;
                    },
                    dataSum: function () {
                        var dataSum = 0;
                        var allData = this.allData().join(',').split(',');
                        $(allData).each(function () {
                            dataSum += parseFloat(this);
                        });
                        return dataSum
                    },
                    topValue: function () {
                        var topValue = 0;
                        var allData = this.allData().join(',').split(',');
                        $(allData).each(function () {
                            if (parseFloat(this, 10) > topValue) topValue = parseFloat(this);
                        });
                        return topValue;
                    },
                    bottomValue: function () {
                        var bottomValue = 0;
                        var allData = this.allData().join(',').split(',');
                        $(allData).each(function () {
                            if (this < bottomValue) bottomValue = parseFloat(this);
                        });
                        return bottomValue;
                    },
                    memberTotals: function () {
                        var memberTotals = [];
                        var dataGroups = this.dataGroups();
                        $(dataGroups).each(function (l) {
                            var count = 0;
                            $(dataGroups[l].points).each(function (m) {
                                count += dataGroups[l].points[m];
                            });
                            memberTotals.push(count);
                        });
                        return memberTotals;
                    },
                    yTotals: function () {
                        var yTotals = [];
                        var dataGroups = this.dataGroups();
                        var loopLength = this.xLabels().length;
                        for (var i = 0; i < loopLength; i++) {
                            yTotals[i] = [];
                            var thisTotal = 0;
                            $(dataGroups).each(function (l) {
                                yTotals[i].push(this.points[i]);
                            });
                            yTotals[i].join(',').split(',');
                            $(yTotals[i]).each(function () {
                                thisTotal += parseFloat(this);
                            });
                            yTotals[i] = thisTotal;

                        }
                        return yTotals;
                    },
                    topYtotal: function () {
                        var topYtotal = 0;
                        var yTotals = this.yTotals().join(',').split(',');
                        $(yTotals).each(function () {
                            if (parseFloat(this, 10) > topYtotal) topYtotal = parseFloat(this);
                        });
                        return topYtotal;
                    },
                    totalYRange: function () {
                        return this.topValue() - this.bottomValue();
                    },
                    xLabels: function () {
                        var xLabels = [];
                        if (o.parseDirection == 'x') {
                            self.find('tr:eq(0) th').filter(o.colFilter).each(function () {
                                xLabels.push($(this).html());
                            });
                        }
                        else {
                            self.find('tr:gt(0) th').filter(o.rowFilter).each(function () {
                                xLabels.push($(this).html());
                            });
                        }
                        return xLabels;
                    },
                    yLabels: function () {
                        var yLabels = [];
                        yLabels.push(bottomValue);
                        var numLabels = Math.round(o.height / o.yLabelInterval);
                        var loopInterval = Math.ceil(totalYRange / numLabels) || 1;
                        while (yLabels[yLabels.length - 1] < topValue - loopInterval) {
                            yLabels.push(yLabels[yLabels.length - 1] + loopInterval);
                        }
                        yLabels.push(topValue);
                        return yLabels;
                    }
                };

                return tableData;
            };


            //function to create a chart
            var createChart = {
                pie: function () {

                    canvasContain.addClass('visualize-pie');

                    if (o.pieLabelPos == 'outside') { canvasContain.addClass('visualize-pie-outside'); }

                    var centerx = Math.round(canvas.width() / 2);
                    var centery = Math.round(canvas.height() / 2);
                    var radius = centery - o.pieMargin;
                    var counter = 0.0;
                    var toRad = function (integer) { return (Math.PI / 180) * integer; };
                    var labels = $('<ul class="visualize-labels"></ul>')
					.insertAfter(canvas);

                    //draw the pie pieces
                    $.each(memberTotals, function (i) {
                        var fraction = (this <= 0 || isNaN(this)) ? 0 : this / dataSum;
                        ctx.beginPath();
                        ctx.moveTo(centerx, centery);
                        ctx.arc(centerx, centery, radius,
						counter * Math.PI * 2 - Math.PI * 0.5,
						(counter + fraction) * Math.PI * 2 - Math.PI * 0.5,
		                false);
                        ctx.lineTo(centerx, centery);
                        ctx.closePath();
                        ctx.fillStyle = dataGroups[i].color;
                        ctx.fill();
                        // draw labels
                        var sliceMiddle = (counter + fraction / 2);
                        var distance = o.pieLabelPos == 'inside' ? radius / 1.5 : radius + radius / 5;
                        var labelx = Math.round(centerx + Math.sin(sliceMiddle * Math.PI * 2) * (distance));
                        var labely = Math.round(centery - Math.cos(sliceMiddle * Math.PI * 2) * (distance));
                        var leftRight = (labelx > centerx) ? 'right' : 'left';
                        var topBottom = (labely > centery) ? 'bottom' : 'top';
                        var percentage = parseFloat((fraction * 100).toFixed(2));

                        if (percentage) {
                            var labelval = (o.pieLabelsAsPercent) ? percentage + '%' : this;
                            var labeltext = $('<span class="visualize-label">' + labelval + '</span>')
				        	.css(leftRight, 0)
				        	.css(topBottom, 0);
                            if (labeltext)
                                var label = $('<li class="visualize-label-pos"></li>')
				       			.appendTo(labels)
				        		.css({ left: labelx, top: labely })
				        		.append(labeltext);
                            labeltext
				        	.css('font-size', radius / 8)
				        	.css('margin-' + leftRight, -labeltext.width() / 2)
				        	.css('margin-' + topBottom, -labeltext.outerHeight() / 2);

                            if (dataGroups[i].textColor) { labeltext.css('color', dataGroups[i].textColor); }
                        }
                        counter += fraction;
                    });
                },

                line: function (area) {

                    if (area) { canvasContain.addClass('visualize-area'); }
                    else { canvasContain.addClass('visualize-line'); }

                    //write X labels
                    var xInterval = canvas.width() / (xLabels.length - 1);
                    var xlabelsUL = $('<ul class="visualize-labels-x"></ul>')
					.width(canvas.width())
					.height(canvas.height())
					.insertBefore(canvas);
                    $.each(xLabels, function (i) {
                        var thisLi = $('<li><span>' + this + '</span></li>')
						.prepend('<span class="line" />')
						.css('left', xInterval * i)
						.appendTo(xlabelsUL);
                        var label = thisLi.find('span:not(.line)');
                        var leftOffset = label.width() / -2;
                        if (i == 0) { leftOffset = 0; }
                        else if (i == xLabels.length - 1) { leftOffset = -label.width(); }
                        label
						.css('margin-left', leftOffset)
						.addClass('label');
                    });

                    //write Y labels
                    var yScale = canvas.height() / totalYRange;
                    var liBottom = canvas.height() / (yLabels.length - 1);
                    var ylabelsUL = $('<ul class="visualize-labels-y"></ul>')
					.width(canvas.width())
					.height(canvas.height())
					.insertBefore(canvas);

                    $.each(yLabels, function (i) {
                        var thisLi = $('<li><span>' + this + '</span></li>')
						.prepend('<span class="line"  />')
						.css('bottom', liBottom * i)
						.prependTo(ylabelsUL);
                        var label = thisLi.find('span:not(.line)');
                        var topOffset = label.height() / -2;
                        if (i == 0) { topOffset = -label.height(); }
                        else if (i == yLabels.length - 1) { topOffset = 0; }
                        label
						.css('margin-top', topOffset)
						.addClass('label');
                    });

                    //start from the bottom left
                    ctx.translate(0, zeroLoc);
                    //iterate and draw
                    $.each(dataGroups, function (h) {
                        ctx.beginPath();
                        ctx.lineWidth = o.lineWeight;
                        ctx.lineJoin = 'round';
                        var points = this.points;
                        var integer = 0;
                        ctx.moveTo(0, -(points[0] * yScale));
                        $.each(points, function () {
                            ctx.lineTo(integer, -(this * yScale));
                            integer += xInterval;
                        });
                        ctx.strokeStyle = this.color;
                        ctx.stroke();
                        if (area) {
                            ctx.lineTo(integer, 0);
                            ctx.lineTo(0, 0);
                            ctx.closePath();
                            ctx.fillStyle = this.color;
                            ctx.globalAlpha = .3;
                            ctx.fill();
                            ctx.globalAlpha = 1.0;
                        }
                        else { ctx.closePath(); }
                    });
                },

                area: function () {
                    createChart.line(true);
                },

                bar: function () {

                    canvasContain.addClass('visualize-bar');

                    //write X labels
                    var xInterval = canvas.width() / (xLabels.length);
                    var xlabelsUL = $('<ul class="visualize-labels-x"></ul>')
					.width(canvas.width())
					.height(canvas.height())
					.insertBefore(canvas);
                    $.each(xLabels, function (i) {
                        var thisLi = $('<li><span class="label">' + this + '</span></li>')
						.prepend('<span class="line" />')
						.css('left', xInterval * i)
						.width(xInterval)
						.appendTo(xlabelsUL);
                        var label = thisLi.find('span.label');
                        label.addClass('label');
                    });

                    //write Y labels
                    var yScale = canvas.height() / totalYRange;
                    var liBottom = canvas.height() / (yLabels.length - 1);
                    var ylabelsUL = $('<ul class="visualize-labels-y"></ul>')
					.width(canvas.width())
					.height(canvas.height())
					.insertBefore(canvas);
                    $.each(yLabels, function (i) {
                        var thisLi = $('<li><span>' + this + '</span></li>')
						.prepend('<span class="line"  />')
						.css('bottom', liBottom * i)
						.prependTo(ylabelsUL);
                        var label = thisLi.find('span:not(.line)');
                        var topOffset = label.height() / -2;
                        if (i == 0) { topOffset = -label.height(); }
                        else if (i == yLabels.length - 1) { topOffset = 0; }
                        label
							.css('margin-top', topOffset)
							.addClass('label');
                    });

                    //start from the bottom left
                    ctx.translate(0, zeroLoc);
                    //iterate and draw
                    for (var h = 0; h < dataGroups.length; h++) {
                        ctx.beginPath();
                        var linewidth = (xInterval - o.barGroupMargin * 2) / dataGroups.length; //removed +1 
                        var strokeWidth = linewidth - (o.barMargin * 2);
                        ctx.lineWidth = strokeWidth;
                        var points = dataGroups[h].points;
                        var integer = 0;
                        for (var i = 0; i < points.length; i++) {
                            var xVal = (integer - o.barGroupMargin) + (h * linewidth) + linewidth / 2;
                            xVal += o.barGroupMargin * 2;

                            ctx.moveTo(xVal, 0);
                            ctx.lineTo(xVal, Math.round(-points[i] * yScale));
                            integer += xInterval;
                        }
                        ctx.strokeStyle = dataGroups[h].color;
                        ctx.stroke();
                        ctx.closePath();
                    }
                }
            };

            //create new canvas, set w&h attrs (not inline styles)
            var canvasNode = document.createElement("canvas");
            canvasNode.setAttribute('height', o.height);
            canvasNode.setAttribute('width', o.width);
            var canvas = $(canvasNode);

            //get title for chart
            var title = o.title || self.find('caption').text();

            //create canvas wrapper div, set inline w&h, append
            var canvasContain = (container || $('<div class="visualize" role="img" aria-label="Chart representing data from the table: ' + title + '" />'))
			.height(o.height)
			.width(o.width)
			.append(canvas);

            //scrape table (this should be cleaned up into an obj)
            var tableData = scrapeTable();
            var dataGroups = tableData.dataGroups();
            var allData = tableData.allData();
            var dataSum = tableData.dataSum();
            var topValue = tableData.topValue();
            var bottomValue = tableData.bottomValue();
            var memberTotals = tableData.memberTotals();
            var totalYRange = tableData.totalYRange();
            var zeroLoc = o.height * (topValue / totalYRange);
            var xLabels = tableData.xLabels();
            var yLabels = tableData.yLabels();

            //title/key container
            if (o.appendTitle || o.appendKey) {
                var infoContain = $('<div class="visualize-info"></div>')
				.appendTo(canvasContain);
            }

            //append title
            if (o.appendTitle) {
                $('<div class="visualize-title">' + title + '</div>').appendTo(infoContain);
            }


            //append key
            if (o.appendKey) {
                var newKey = $('<ul class="visualize-key"></ul>');
                var selector;
                if (o.parseDirection == 'x') {
                    selector = self.find('tr:gt(0) th').filter(o.rowFilter);
                }
                else {
                    selector = self.find('tr:eq(0) th').filter(o.colFilter);
                }

                selector.each(function (i) {
                    $('<li><span class="visualize-key-color" style="background: ' + dataGroups[i].color + '"></span><span class="visualize-key-label">' + $(this).text() + '</span></li>')
					.appendTo(newKey);
                });
                newKey.appendTo(infoContain);
            };

            //append new canvas to page

            if (!container) { canvasContain.insertAfter(this); }
            if (typeof (G_vmlCanvasManager) != 'undefined') { G_vmlCanvasManager.init(); G_vmlCanvasManager.initElement(canvas[0]); }

            //set up the drawing board	
            var ctx = canvas[0].getContext('2d');

            //create chart
            createChart[o.type]();

            //clean up some doubled lines that sit on top of canvas borders (done via JS due to IE)
            $('.visualize-line li:first-child span.line, .visualize-line li:last-child span.line, .visualize-area li:first-child span.line, .visualize-area li:last-child span.line, .visualize-bar li:first-child span.line,.visualize-bar .visualize-labels-y li:last-child span.line').css('border', 'none');
            if (!container) {
                //add event for updating
                canvasContain.bind('visualizeRefresh', function () {
                    self.visualize(o, $(this).empty());
                });
            }
        }).next(); //returns canvas(es)
    };
})(jQuery);

