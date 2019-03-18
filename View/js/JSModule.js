//#version 1

function logOportunidad() {
    $('body').on('click', '.log-oportunidad', function (e) {
        var strReg = $(this).attr('cod')
        var strCli = $(this).attr('cli')
        var strData = new Object();
        strData.codigo = strReg;
        strData.cli = strCli;
        $.ajax({
            type: 'POST',
            url: urllog,
            data: JSON.stringify(strData),
            success: function (data) {
                $('#myModal').modal('hide');
                $("#myModal").html(data);
                $('#myModal').modal('show');


            },
            error: function (xhr, status, error) {

                $("#myModal").html(alertHtml('error', xhr.responseText));
                $('#myModal').modal('show');

            }
        });

    });
}
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function alertHtml(tipo, error, titulo) {

    var strHtml = '';
    if (tipo == "delConfirm") {
        //strHtml = '<div class="modal-header">';
        //strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>';
        //strHtml = strHtml + '<h3 id="H2">Alerta</h3></div>';
        //strHtml = strHtml + '<div class="modal-body">';
        //strHtml = strHtml + '<img src="../../images/alert/ico_alert.png" style="float: left;height: 32px;"/> <p style="float: left;line-height: 32px;margin-left: 10px!important;">' + titulo + '</p></div>';
        //strHtml = strHtml + '<div class="modal-footer">';
        //strHtml = strHtml + '<button class="form-button cz-form-content-input-button" data-dismiss="modal" aria-hidden="true" style="margin-right: 10px;">NO</button>'
        //strHtml = strHtml + '<button class="btnDelSi form-button cz-form-content-input-button" data-dismiss="modal" aria-hidden="true">SI</button></div>';

        strHtml = strHtml + '<div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><h2 class="modal-title" id="exampleModalLabel">Alerta</h2>';
        strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>';
        strHtml = strHtml + '<div class="modal-body"><div class="container-modal"><form><div class="row"><div class="col-sm-12 form-group">';
        strHtml = strHtml + '<img src="../../images/alert/ico_alert.png" style="float: left;height: 32px;"> <p style="float: left;line-height: 32px;margin-left: 10px!important;">' + titulo + '</p>';
        strHtml = strHtml + '</div></div></form></div></div><div class="modal-footer"><div class="container-modal">';
        strHtml = strHtml + '<button type="button" class="btn btn-danger btnDelSi">SI</button><button type="button" class="btn btn-default" data-dismiss="modal">NO</button>';
        strHtml = strHtml + '</div></div></div></div>';
    }
    else if (tipo == "delConfirmFalta") {
        strHtml = ''
        //strHtml = strHtml + '<div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><h2 class="modal-title" id="exampleModalLabel">Titulo</h2>'
        //strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>'
        //strHtml = strHtml + '<div class="modal-body"><div class="container-modal">'
        //strHtml = strHtml + '<img src="../../images/alert/ico_alert.png" style="float: left;height: 32px;"/> <p style="float: left;line-height: 32px;margin-left: 10px!important;">Seleccione por lo menos un item</p></div>';
        //strHtml = strHtml + '</div></div><div class="modal-footer"><div class="container-modal"><button type="button" class="btn btn-danger " data-dismiss="modal">Cerrar</button>'
        //strHtml = strHtml + '</div></div></div>'

        strHtml = strHtml + '<div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><h2 class="modal-title" id="exampleModalLabel">Alerta</h2>';
        strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>';
        strHtml = strHtml + '<div class="modal-body"><div class="container-modal"><form><div class="row"><div class="col-sm-12 form-group">';
        strHtml = strHtml + '<img src="../../images/alert/ico_alert.png" style="float: left;height: 32px;"> <p style="float: left;line-height: 32px;margin-left: 10px!important;">Seleccione por lo menos un item</p>';
        strHtml = strHtml + '</div></div></form></div></div><div class="modal-footer"><div class="container-modal"><button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>';
        strHtml = strHtml + '</div></div></div></div>';

    }
    else if (tipo == "error") {
        //strHtml = '<div class="modal-header">';
        //strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>';
        //strHtml = strHtml + '<h3 id="H1">Error</h3></div>';
        //strHtml = strHtml + '<div class="modal-body">';
        //strHtml = strHtml + error + '</div>';
        //strHtml = strHtml + '<div class="modal-footer">';
        //strHtml = strHtml + '<button class="form-button cz-form-content-input-button" data-dismiss="modal" aria-hidden="true">CERRAR</button></div>';

        strHtml = strHtml + '<div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><h2 class="modal-title" id="exampleModalLabel">Error</h2>';
        strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>';
        strHtml = strHtml + '<div class="modal-body"><div class="container-modal"><form><div class="row"><div class="col-sm-12 form-group">';
        strHtml = strHtml + '' + error + '</p>';
        strHtml = strHtml + '</div></div></form></div></div><div class="modal-footer"><div class="container-modal">';
        strHtml = strHtml + '<button type="button" class="btn btn-default" data-dismiss="modal">CERRAR</button>';
        strHtml = strHtml + '</div></div></div></div>';
    }

    else if (tipo == "errorCarga") {
        strHtml = '<div class="modal-dialog modal-lg"><div class="modal-content">';
        strHtml = strHtml + '<div class="modal-header">';
        strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>';
        strHtml = strHtml + '<h3 id="H1">' + titulo + '</h3></div>';
        strHtml = strHtml + '<div class="modal-body">';
        strHtml = strHtml + error + '</div>';
        strHtml = strHtml + '<div class="modal-footer">';
        strHtml = strHtml + '<button class="form-button cz-form-content-input-button" data-dismiss="modal" aria-hidden="true">CERRAR</button></div></div></div>';
    }
    else if (tipo == "alertValidacion") {
        strHtml = strHtml + '<div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><h2 class="modal-title" id="exampleModalLabel">Alerta</h2>';
        strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>';
        strHtml = strHtml + '<div class="modal-body"><div class="container-modal"><form><div class="row"><div class="col-sm-12 form-group">';
        strHtml = strHtml + '<img src="../../images/alert/ico_alert.png" style="float: left;height: 32px;"> <p style="float: left;line-height: 32px;margin-left: 10px!important;">' + error + '</p>';
        strHtml = strHtml + '</div></div></form></div></div><div class="modal-footer"><div class="container-modal">';
        strHtml = strHtml + '<button type="button" class="btn btn-default" data-dismiss="modal">CERRAR</button>';
        strHtml = strHtml + '</div></div></div></div>';
        //strHtml = '<div class="modal-header">';
        //strHtml = strHtml + '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>';
        //strHtml = strHtml + '<h3 id="H1">Alerta</h3></div>';
        //strHtml = strHtml + '<div class="modal-body">';
        //strHtml = strHtml + '<img src="../../images/alert/ico_alert.png" style="float: left;height: 32px;"/> <p style="float: left;margin-top: 6px!important;margin-left: 7px!important;">' + error + '</div>';
        //strHtml = strHtml + '<div class="modal-footer">';
        //strHtml = strHtml + '<button class="form-button cz-form-content-input-button" data-dismiss="modal" aria-hidden="true">CERRAR</button></div>';
    }

    return strHtml;

}

/*Elimina Registros*/
/*function deleteReg() {*/
function deleteReg(bParamAdic) {
    //$('#myModal').modal('show');
    if (bParamAdic == undefined || bParamAdic == null)
        bParamAdic = false;
    else
        bParamAdic = bParamAdic;

    /**/

    $('body').on('click', '.delReg', function (e) {
        var strReg = "";
        $('#divGridView input:checked').each(function () {
            if (this.name != "chkSelectAll")
            { strReg = strReg + this.value + "|"; }
        });

        if (strReg != "") {
            if ($('.delReg').val() == "Restaurar") {
                $('#myModal').html(alertHtml('delConfirm', "", "¿Esta seguro que desea <b>restaurar</b> los items seleccionados?"));
            } else {
                $('#myModal').html(alertHtml('delConfirm', "", "¿Esta seguro que desea <b>eliminar</b> los items seleccionados?"));
            }


            $('.btnDelSi').click(function (e) {

                var strReg = "";

                $('#divGridView input:checked').each(function () {
                    if (this.name != "chkSelectAll")
                    { strReg = strReg + this.value + "|"; }
                });
                var strData = new Object();
                strData.codigos = strReg;


                $.ajax({
                    type: 'POST',
                    url: urldel,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify(strData),
                    success: function (data) {
                        $('#buscar').trigger("click");
                        $('#myModal').modal('hide');
                        addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                    },
                    error: function (xhr, status, error) {
                        $("#myModal").html(alertHtml('error', jQuery.parseJSON(xhr.responseText).Message));

                        $('#myModal').modal('show');
                    }
                });
            });

        }
        else {
            $('#myModal').html(alertHtml('delConfirmFalta'));
        }


    });

    $('body').on('click', '.delItemReg', function (e) {
        var strReg = $(this).attr('cod')
        if ($('.delReg').val() == "Restaurar") {
            $('#myModal').html(alertHtml('delConfirm', "", "¿Esta seguro que desea <b>restaurar</b> este registro?"));
        } else {
            $('#myModal').html(alertHtml('delConfirm', "", "¿Esta seguro que desea <b>eliminar</b> este registro?"));
        }
        $('#myModal').modal('show');

        $('.btnDelSi').click(function (e) {

            var strData = new Object();
            strData.codigos = strReg;


            $.ajax({
                type: 'POST',
                url: urldel,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                data: JSON.stringify(strData),
                success: function (data) {
                    $('#buscar').trigger("click");
                    $('#myModal').modal('hide');
                    addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                    /*****************************/
                    if (bParamAdic)
                        window.location.reload();
                    /****************************/
                },
                error: function (xhr, status, error) {
                    $("#myModal").html(alertHtml('error', jQuery.parseJSON(xhr.responseText).Message));
                    $('#myModal').modal('show');
                }
            });
        });

    });


}

/*Restaura Registros*/
function restoreReg() {
    $('body').on('click', '.restReg', function (e) {
        //$('.restReg').click(function (e) {
        var strReg = "";

        $('#divGridView input:checked').each(function () {
            if (this.name != "chkSelectAll")
            { strReg = strReg + this.value + "|"; }
        });

        if (strReg != "") {
            $('#myModal').html(alertHtml('delConfirm', "", "¿Esta seguro que desea <b>restaurar</b> los items seleccionados?"));
            //$('#myModal').modal('show');

            $('.btnDelSi').click(function (e) {

                var strReg = "";

                $('#divGridView input:checked').each(function () {
                    if (this.name != "chkSelectAll")
                    { strReg = strReg + this.value + "|"; }
                });
                var strData = new Object();
                strData.codigos = strReg;


                $.ajax({
                    type: 'POST',
                    url: urlrest,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify(strData),
                    success: function (data) {
                        $('#buscar').trigger("click");
                        addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                        $('#myModal').modal('hide');
                    },
                    error: function (xhr, status, error) {
                        $("#myModal").html(alertHtml('error', xhr.responseText));
                        $('#myModal').modal('show');
                    }
                });
            });

        }
        else {
            $('#myModal').html(alertHtml('delConfirmFalta'));
            //$('#myModal').modal('show');
        }


    });

    $('body').on('click', '.restItemReg', function (e) {

        var strReg = $(this).attr('cod')
        $('#myModal').html(alertHtml('delConfirm', "", "¿Esta seguro que desea <b>restaurar</b> éste registro?"));
        $('#myModal').modal('show');

        $('.btnDelSi').click(function (e) {

            var strData = new Object();
            strData.codigos = strReg;


            $.ajax({
                type: 'POST',
                url: urlrest,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                data: JSON.stringify(strData),
                success: function (data) {
                    $('#buscar').trigger("click");
                    addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                    $('#myModal').modal('hide');
                },
                error: function (xhr, status, error) {
                    $("#myModal").html(alertHtml('notify', xhr.responseText));
                    $('#myModal').modal('show');
                }
            });
        });

    });


}

/*Agrega Registros*/
function addReg() {
    $('.addReg').click(function (e) {
        $.ajax({
            type: 'POST',
            url: urlins,
            success: function (data) {
                $("#myModal").html(data);
                $('#myModal').modal('show');

                $('#saveReg').click(function (e) {
                    e.preventDefault();
                    var mensaje = "";
                    var validateItems = true;

                    $('.requerid').each(function () {
                        $(this).parent().find('span').not(".multiselect-selected-text").remove();

                        var minlength = 0;
                        if (typeof ($(this).attr("minlength")) != "undefined") {
                            minlength = $(this).attr("minlength");
                            if ($(this).val().length < minlength) {
                                validateItems = false;
                                $(this).before("<span style='color:#b94a48'>*") + ("</span>");
                                mensaje += $(this).attr("placeholder") + " debe contener mínimo " + minlength + " caracteres,</br>";
                            }
                        }
                        if ($(this).val() == "") {
                            $(this).before("<span style='color:#b94a48'>*") + ("</span>");
                            validateItems = false;
                        }
                    });

                    if (!validateItems) {
                        mensaje += "Ingresar los campos obligatorios";
                        addnotify("notify", mensaje, "registeruser");
                    }
                    else {
                        $('#divError').attr('class', "alert fade");
                        var hModal = $("#myModal").height();

                        $.ajax({
                            type: 'POST',
                            url: urlsavN,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            data: JSON.stringify(getData()),
                            success: function (data) {
                                addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                                clearCampos();
                                $('#buscar').trigger("click");

                            },
                            error: function (xhr, status, error) {
                                addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                            }
                        });

                    }
                });

            },
            error: function (xhr, status, error) {

                $("#myModal").html(alertHtml('error', xhr.responseText));
                $('#myModal').modal('show');

            }
        });

    });


}


function asoPer() {

    $('.asoPerMen').on('click', function (e) {

        var strReg = $(this).attr('cod')
        var strData = new Object();
        strData.codigo = strReg;

        $.ajax({
            type: 'POST',
            url: urlaso,
            data: JSON.stringify(strData),
            success: function (data) {
                $('#myModal').modal('hide');
                $("#myModal").html(data);
                $('#myModal').modal('show');

                $('#saveReg').click(function (e) {
                    e.preventDefault();

                    var validateItems = true;
                    $('.requerid').each(function () {
                        $(this).parent().find('span').not(".multiselect-selected-text").first().remove();
                        if ($(this).val() == "") {
                            $(this).before("<span style='color:#b94a48'>*</span>");
                            validateItems = false;
                        }
                    });
                    if (!validateItems) {
                        //$("#mensajeError").text("Ingrese los campos obligatorios.");
                        //$('#divError').attr('class', "alert fade in");
                        //$("#tituloMensajeError").text('ADVERTENCIA');
                        addnotify("notify", "Ingrese los campos obligatorios.", "registeruser");
                    }
                    else {
                        $('#divError').attr('class', "alert fade");

                        var hModal = $("#myModal").height();

                        $.ajax({
                            type: 'POST',
                            url: urlperM,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            data: JSON.stringify(getData()),
                            success: function (data) {
                                addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                                $('#myModal').modal('hide');
                                $('#buscar').trigger("click");

                            },
                            error: function (xhr, status, error) {
                                addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");

                            }
                        });

                    }
                });

            },
            error: function (xhr, status, error) {

                $("#myModal").html(alertHtml('error', xhr.responseText));
                $('#myModal').modal('show');

            }
        });

    });
}

function modReg() {

    $('body').on('click', '.editItemReg', function (e) {
        var strReg = $(this).attr('cod')
        var strData = new Object();
        strData.codigo = strReg;

        $.ajax({
            type: 'POST',
            url: urlins,
            data: JSON.stringify(strData),
            success: function (data) {
                $('#myModal').modal('hide');
                $("#myModal").html(data);
                $('#myModal').modal('show');

                $('#saveReg').click(function (e) {
                    e.preventDefault();
                    var mensaje = "";
                    var validateItems = true;
                    $('.requerid').each(function () {
                        $(this).parent().find('span').not(".multiselect-selected-text").remove();
                        var minlength = 0;
                        if (typeof ($(this).attr("minlength")) != "undefined") {
                            minlength = $(this).attr("minlength");
                            if ($(this).val().length < minlength) {
                                validateItems = false;
                                $(this).before("<span style='color:#b94a48'>*") + ("</span>");
                                mensaje += $(this).attr("placeholder") + " debe contener mínimo " + minlength + " caracteres,</br>";
                            }
                        }
                        if ($(this).val() == "") {
                            $(this).before("<span style='color:#b94a48'>*") + ("</span>");
                            validateItems = false;
                        }
                    });

                    if (!validateItems) {
                        mensaje += "Ingresar los campos obligatorios";
                        addnotify("notify", mensaje, "registeruser");
                    }
                    else {
                        $('#divError').attr('class', "alert fade");

                        var hModal = $("#myModal").height();

                        $.ajax({
                            type: 'POST',
                            url: urlsavE,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            data: JSON.stringify(getData()),
                            success: function (data) {
                                addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                                $('#myModal').modal('hide');
                                $('#buscar').trigger("click");

                            },
                            error: function (xhr, status, error) {
                                addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                            }
                        });

                    }
                });

            },
            error: function (xhr, status, error) {

                $("#myModal").html(alertHtml('error', xhr.responseText));
                $('#myModal').modal('show');

            }
        });

    });
}

/*Busqueda*/
function busReg() {
    $('body').on('change', "input[id$='ChkAll']", function (e) {
        $(".grilla INPUT[type='checkbox']")
                     .prop('checked', $(this)
                     .is(':checked'));
    });

    $('body').on('change', ".grilla INPUT[type='checkbox']", function (e) {
        if (!$(this)[0].checked) {
            $("input[id$='ChkAll']").prop("checked", false);
        }
    });

    $('#buscar').click(function (e) {
        //Check True/False
        if ($('#chkhabilitado').length) { //Si existe el elemento
            if ($("#chkhabilitado").is(":checked")) {
                //$("#cz-form-box-del").val("Eliminar");
                $("#btnBorrar").removeClass('restReg').addClass('delReg').html('Borrar');
                $("#btnBorrarhd").removeClass('restReg').addClass('delReg').html('<i class="far fa-trash-alt fa-lg"></i>');
                //deleteReg();
            } else {
                //$("#cz-form-box-del").val("Restaurar");
                $("#btnBorrar").removeClass('delReg').addClass('restReg').html('Restaurar');
                $("#btnBorrarhd").removeClass('delReg').addClass('restReg').html('<i class="fas fa-retweet fa-lg"></i>');
                //restoreReg();
            }
        }

        //cargando la grilla
        var strData = getParametros();
        strData.pagina = 1;
        $('#hdnActualPage').val('1');
        //$('#myModal').modal('show');

        $.ajax({
            type: 'POST',
            url: urlbus,
            contentType: "application/json; charset=utf-8",
            async: true,
            cache: false,
            data: JSON.stringify(strData),
            beforeSend: function () {
                $('.form-gridview-data').html('');
                $('.form-gridview-error').html('');
                $('.form-gridview-search').show();
            },
            success: function (data) {
                $('.form-gridview-search').hide();
                $('.form-gridview-error').html('');
                $('.form-gridview-data').html(data);
                $('#hdnActualPage').val(strData.pagina);
            },
            error: function (xhr, status, error) {
                $('.form-gridview-search').hide();
                $('.form-gridview-data').html();
                $('.form-gridview-error').html("<p><strong>ERROR: </strong> Se ha producido un error en el codigo. Para mayor detalle </p><a id='divError'>haga click aqui</a>");
                $("#myModal").html(alertHtml('error', xhr.responseText));

                $('#divError').click(function (e) {
                    $('#myModal').modal('show');
                });
            }
        });

    });
    $('body').on('change', '.list-pag', function (e) {
        $("#hdnShowRows").val($(this).val());
    });
    $('body').on('click', '.pagina-anterior', function (e) {
        var strData = getParametros();
        strData.pagina = parseInt(strData.pagina) - 1;
        $.ajax({
            type: 'POST',
            url: urlbus,
            contentType: "application/json; charset=utf-8",
            async: true,
            cache: false,
            data: JSON.stringify(strData),
            beforeSend: function () {
                $(".paginator-data").hide();
                $(".tb-pc").hide();
                $(".paginator-data-search").show();
            },
            success: function (data) {
                $('.form-gridview-data').html(data);
                $('#hdnActualPage').val(strData.pagina);
                //Si la tabla esta expandido, auto expandirse al cambiar de pagina.
                if ($(".form-grid-table-outer").hasClass("cz-table-expand-table")) {
                    $(".cz-table-expand").click();
                }
            },
            error: function (xhr, status, error) {
                $("#myModal").html(alertHtml('error', xhr.responseText));
                $('#myModal').modal('show');
            }
        });

    });

    $('body').on('click', '.pagina-siguiente', function (e) {
        var strData = getParametros();
        strData.pagina = parseInt(strData.pagina) + 1;
        $.ajax({
            type: 'POST',
            url: urlbus,
            contentType: "application/json; charset=utf-8",
            async: true,
            cache: false,
            data: JSON.stringify(strData),
            beforeSend: function () {
                $(".paginator-data").hide();
                $(".tb-pc").hide();
                $(".paginator-data-search").show();
            },
            success: function (data) {
                $('.form-gridview-data').html(data);
                $('#hdnActualPage').val(strData.pagina);
                //Si la tabla esta expandido, auto expandirse al cambiar de pagina.
                if ($(".form-grid-table-outer").hasClass("cz-table-expand-table")) {
                    $(".cz-table-expand").click();
                }
            },
            error: function (xhr, status, error) {
                $("#myModal").html(alertHtml('error', xhr.responseText));
                $('#myModal').modal('show');
            }
        });

    });
}

function detReg(control, urlD) {
    $('body').on('click', control, function (e) {

        if (!$(this).parent().hasClass("nofoto") && !$(this).parent().hasClass("nogps")) {
            var strReg = $(this).attr('cod');
            var strData = new Object();
            strData.codigo = strReg
            $this = $(this);
            $.ajax({
                type: 'POST',
                url: urlD,
                data: JSON.stringify(strData),
                beforeSend: function () {
                    $("#myModal").html('');
                },
                success: function (data) {
                    $("#myModal").html(data);
                    var modali = 0;
                    $("#myModalContent div table").each(function () {
                        modali = 1;
                    });

                    if (modali == 0 && $this.hasClass("detReg")) {
                        $("#myModalContent div").addClass("cz-util-center-text").html("<p>No se registro ningun detalle.<p>");
                        $("#cz-form-modal-exportar").hide();
                    }

                    $('#myModal').on('shown', function () {
                        //google.maps.event.trigger(map, "resize");
                    });

                    $('#myModal').modal('show');

                },
                error: function (xhr, status, error) {

                    $("#myModal").html(alertHtml('error', xhr.responseText));
                    $('#myModal').modal('show');

                }
            });
        }
    });
}

function detReg2(control, urlD) {
    $(control).on('click', function (e) {
        var strReg = "";
        $('#divGridView input:checked').each(function () {
            if (this.name != "chkSelectAll") {
                strReg = strReg + this.value + "|";
            }
        });

        if (strReg != "") {
            var strData = new Object();
            strData.codigo = strReg;
            $.ajax({
                type: 'POST',
                url: urlD,
                data: JSON.stringify(strData),
                beforeSend: function () {
                    $("#myModal").html('');
                },
                success: function (data) {
                    $("#myModal").html(data);

                    $('#myModal').on('shown', function () {
                        google.maps.event.trigger(map, "resize");
                    });

                    $('#myModal').modal('show');

                },
                error: function (xhr, status, error) {

                    $("#myModal").html(alertHtml('error', xhr.responseText));
                    $('#myModal').modal('show');

                }
            });
        } else {
            $("#myModal").html(alertHtml('erroCheck'));
            $('#myModal').modal('show');
        }
    });
}

function exportarReg(control, urlXLS, grilla) {
    $(control).on('click', function (e) {
        var filas = getNumRows(grilla);
        if (filas > 0) {
            window.location.href = urlXLS + '?' + getParametrosXLS();
        }
        else {
            $('#myModal').html(alertHtml('alertValidacion', "No existe data para exportar"));
            $('#myModal').modal('show');

        }
    });
}

function exportarRegDet(control, urlXLS, grilla, parameters) {
    $(control).on('click', function (e) {
        var filas = getNumRows(grilla);
        if (filas > 0) {
            window.location.href = urlXLS + '?' + parameters;
        }
        else {
            $('#myModal').html(alertHtml('alertValidacion', "No existe data para exportar"));
            $('#myModal').modal('show');
        }
    });
}

function getNumRows(grilla) {
    var numRows = "";
    numRows = $(grilla).find('tr').length;
    return numRows;
}

function cargacomboA(Padre, Hijo, pag) //funcion encargada de manejar combos anidados sin la necesidad de realizar algun postback
{
    $(document).ready(function () {
        //elegido=$(Padre).val();
        elegido = Padre;

        $.post(pag, { elegido: elegido }, function (data) {
            $(Hijo).html(data);
        });
        $(Hijo).change();
    });
}

/*CARGA*/
/*CARGA*/
function accionesCarga() {


    $('.btnError').on('click', function (e) {
        e.preventDefault();

        tit = $(this).attr("idC");
        $("#myModal").html(alertHtml("errorCarga", $(this).parent().find('.errmsg').html(), tit));
        $('#myModal').modal('show');

    });


    $('.btnData').on('click', function (e) {
        e.preventDefault();

        tit = $(this).attr("idC");
        $("#myModal").html(alertHtml("errorCarga", $(this).parent().find('.errmsg').html(), tit));
        $('#myModal').modal('show');

    });


    $('#buscar').on("click", function (e) {
        e.preventDefault();
        $('.form-box').show();
        $('#divGridViewData').html('');
        $('.divUploadNew').hide();

    });


    var bex = -1;
    var bey = 0;
    var beerror = 0;
    $(document).off("click");
    $(document).on("click", '.boton-ejecutar', function (e) {
        e.preventDefault();


        var strData = new Object();

        var tipo = 'XLS';
        //var chk = $("#rblTipoCarga").find(":checked").val();
        //if (chk=="E") {
        //    tipo = "XLS";
        //}
        strData.Tipo = tipo;


        $.ajax({
            type: "POST",
            url: "Carga.aspx/ejecutarArchivoXLS",
            data: JSON.stringify(strData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            beforeSend: function () {
                $('#divGridViewData').html('');
                $('.form-gridview-search').show();
            },
            success: function (msg) {

                $('.form-gridview-search').hide();
                $('#file-uploader').find('.qq-upload-list li').remove();
                $('.boton-ejecutar').hide();
                $('#divGridViewData').html(msg.d);
                $('.form-box').hide();
                $('.divUploadNew').show();
                //$("#myModal").html("");
                $('.btnError').off('click');
                $('.btnError').on('click', function (e) {
                    e.preventDefault();
                    tit = $(this).attr("idC");
                    $("#myModal").html(alertHtml("errorCarga", $(this).parent().find('.errmsg').html(), tit));
                    $('#myModal').modal('show');
                });

            },
            error: function (xhr, status, error) {
                if (jQuery.parseJSON(xhr.responseText).Message == "EXPIRED SESSION") {
                    location.reload();
                } else {
                    $("#myModal").html(alertHtml("error", jQuery.parseJSON(xhr.responseText).Message));
                    $('#myModal').modal('show');
                }
            }
        });
    });



    $('.boton-borrar').on("click", function (e) {
        e.preventDefault();
        var listFiles = $('#file-uploader').find('.qq-upload-list li');

        var idclass = $(this).attr("idclass");
        var filename = $(this).attr("filename");
        var error = $(this).attr("error");

        var name = filename.substring(0, filename.lastIndexOf('.'));
        var ext = filename.substr(filename.lastIndexOf('.') + 1);

        var jsonFileName = name;
        var jsonFileExt = ext;

        listFiles.find("#fri-" + idclass).remove();
        if (error == "si")
        { listFiles.find("#fbd-" + idclass).append("<div class='file-load-icon' id='fld-" + idclass + "'><img src='../images/icons/loader/ico_loader_red.gif' /></div>"); }
        else
        { listFiles.find("#fbd-" + idclass).append("<div class='file-load-icon' id='fld-" + idclass + "'><img src='../images/icons/loader/ico_loader_lightorange.gif' /></div>"); }

        var strData = new Object();
        strData.filename = jsonFileName;
        strData.fileext = jsonFileExt;

        $.ajax({
            type: "POST",
            url: "Carga.aspx/borrarArchivo",
            data: JSON.stringify(strData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {

                listFiles.find("#fld-" + idclass).parent().parent().parent().parent().remove();
                if (listFiles.length > 1) {
                    $('.boton-ejecutar').show();
                }
                else {
                    $('.boton-ejecutar').hide();
                }

            },
            error: function (xhr, status, error) {
                var err = eval("(" + xhr.responseText + ")");
                listFiles.find("#fld-" + idclass).remove();
                listFiles.find("#fbd-" + idclass).addClass("file-red");
                listFiles.find("#fbd-" + idclass).append("<div class='file-result-icon'><img src='../images/icons/carga/ico_carga_error.png' /></div>");
                listFiles.find("#fbx-" + idclass).append("<div class='file-result-text file-red-font' id='frs-" + idclass + "'>" + err.Message + "</div>");
            }
        });
    });
}

function cargaSup(control) {
    var strperfil = $('#MddlPerfil option:selected').val();
    if (strperfil == 'V') {
        $('.filsup').show();
    }
    else {
        $('.filsup').hide();
    }
}

function cargaSup2() {
    var strperfil = $('#vddlPerfil option:selected').val();
    if (strperfil == 'V') {
        $('.filsup2').show();
    }
    else {
        $('.filsup2').hide();
    }
}


/*CHARTS*/

function drawChart() {

    $('.downFil').on('click', function (e) {
        e.preventDefault();
        if ($(this).hasClass('upFil')) {
            $(this).removeClass('upFil');
            $('#content_filtros').hide();
            $('#charGauge').css({ "margin-left": "5%" });
        }
        else {
            $(this).addClass('upFil');
            $('#content_filtros').show();
            $('#charGauge').css({ "margin-left": "19%" });
        }
    });

    $('#btnGauge').on('click', function (e) {
        e.preventDefault();


        $.ajax({
            type: 'POST',
            url: 'inicio.aspx/getActProgramdas',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            data: JSON.stringify(getData()),
            success: function (data) {

                jObject = jQuery.parseJSON(data.d);
                $('#titleGauge').html(jObject.Titulo);
                $('#titleFooterGauge').html(jObject.LabelFoot);
                var dataGauge = new google.visualization.DataTable();
                dataGauge.addColumn('string', 'Label');
                dataGauge.addColumn('number', 'Value');
                dataGauge.addRows(1);
                dataGauge.setCell(0, 0, '');
                dataGauge.setCell(0, 1, jObject.Valor);


                var options = {
                    width: 400, height: 180,
                    redFrom: 0, redTo: 20,
                    yellowFrom: 20, yellowTo: 80,
                    greenFrom: 80, greenTo: 100,
                    minorTicks: 5
                };
                var chart = new google.visualization.Gauge(document.getElementById('charGauge'));
                chart.draw(dataGauge, options);

            },
            error: function (xhr, status, error) {
                addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "alertChart");

            }
        });


    });


    $('#btnObtener').on('click', function (e) {
        e.preventDefault();

        $('#btnGauge').trigger("click");

        $.ajax({
            type: 'POST',
            url: 'inicio.aspx/getActividadesRealizadas',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            data: JSON.stringify(getData()),
            success: function (data) {

                jObject = jQuery.parseJSON(data.d);


                var dataBar = new google.visualization.DataTable();
                dataBar.addColumn('string', 'Actividades');
                dataBar.addColumn('number', 'Total');
                dataBar.addColumn({ type: 'string', role: 'style' });
                dataBar.addColumn({ type: 'string', role: 'annotation' });

                $.each(jObject.Valor, function (i, item) {
                    dataBar.addRows(1);
                    dataBar.setCell(i, 0, item.usuario);
                    dataBar.setCell(i, 1, item.total);
                    dataBar.setCell(i, 2, item.color);
                    dataBar.setCell(i, 3, item.total);

                });



                var options2 = {
                    width: 400, height: 180,
                    hAxis: { title: jObject.xAxisName, titleTextStyle: { color: 'black' } },
                    vAxis: { title: jObject.yAxisName, titleTextStyle: { color: 'black' } },
                    legend: { position: "none" }
                };


                var chart2 = new google.visualization.ColumnChart(document.getElementById('chartBar'));
                chart2.draw(dataBar, options2);


            },
            error: function (xhr, status, error) {
                addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "alertChart");

            }
        });


    });





}



function colorPicks(color) {
    $('.color').append('<div style="float: left;"><div  class="colorrest" style="float: left; width: 50px; height: 16px; background: ' + $('#hColor').val() + ';"></div></div>');

    var colors = '';
    $.each(color, function (i, col) {
        colors = colors + ' <div  class="colorpick" style="float: right; background-color: ' + col + '; width: 16px; height: 16px; margin-left: 5px;margin-bottom: 5px;"></div>';
    });

    $('.color').append(' <div style="float: right; width: 150px;">' + colors + '</div>');

    $('.colorpick').on('click', function (e) {


        var col = $(this).css('background-color');
        $('.colorrest').css('background-color', col);
        $('#hColor').val(rgb2hex(col));
    });
}


function rgb2hex(rgb) {
    rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
    function hex(x) {
        return ("0" + parseInt(x).toString(16)).slice(-2);
    }
    return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
}


function checkAllCampo(Campo, isChecked) {

    $(isChecked).parents('table').find('td .' + Campo + ' > input').attr('checked', isChecked.checked);
}


/*estado*/
function tipo(control) {

    var tr = $('#' + control.id).parent().parent();
    var elegido = '';
    $('#' + control.id).find('option:selected').each(function () {
        elegido = $(this).val();
    });

    if (elegido == "CHG" || elegido == "COM") {
        tr.find(".txtCodGrupo").remove();
        tr.find(".btnGrupo").remove();
        tr.find(".txtMax").remove();
        tr.find(".tdgroup").append("<input id='txtCodGrupo1' readonly class='txtCodGrupo cz-form-content-input-text' style='width: 100px;' disabled='disabled' type='text' /> <div class='cz-form-content-input-text-visible'><div class='cz-form-content-input-text-visible-button'></div></div>");
        tr.find(".cz-form-content-input-text-visible").remove();
        tr.find(".tdgroup").append("<input id='btnGrupo1' style='padding-left: 10px;padding-right: 10px;' class='cz-form-content-input-button btnGrupo' type='button' value='...' />");
    }
    else {
        tr.find(".txtCodGrupo").remove();
        tr.find(".cz-form-content-input-text-visible").remove();
        tr.find(".btnGrupo").remove();

        if (elegido == "ALF" || elegido == "NUM" || elegido == "DEC") {
            tr.find(".txtMax").remove();
            tr.find(".cz-form-content-input-text-visible").remove();
            tr.find(".tdMax").append("<input id='txtMax1' class='txtMax cz-form-content-input-text' onkeypress='fc_PermiteNumeros()' onblur='grabarTR(this);'   type='text' /> <div class='cz-form-content-input-text-visible'><div class='cz-form-content-input-text-visible-button'></div></div>");

        }
        else {
            tr.find(".txtMax").remove();
            tr.find(".cz-form-content-input-text-visible").remove();

        }
    }


}

function tipo2(control) {

    var tr = $('#' + control).parent().parent();
    var elegido = '';
    $('#' + control).find('option:selected').each(function () {
        elegido = $(this).val();
        $(".cz-form-content-input-select").change(function () {

            $(this).parent().find(".cz-form-content-input-select-visible-text").html($(this).find("option:selected").text());
        });

        $(".cz-form-content-input-select").each(function () {

            $(this).parent().find(".cz-form-content-input-select-visible-text").html($(this).find("option:selected").text());
        });
    });

    if (elegido == "CHG" || elegido == "COM") {
        tr.find(".txtCodGrupo").remove();
        tr.find(".btnGrupo").remove();
        tr.find(".txtMax").remove();
        tr.find(".tdgroup").append("<input id='txtCodGrupo1' class='txtCodGrupo  cz-form-content-input-text' disabled='disabled' type='text' style='width: 100px;'/> <div class='cz-form-content-input-text-visible'><div class='cz-form-content-input-text-visible-button'></div></div>");
        tr.find(".cz-form-content-input-text-visible").remove();
        tr.find(".tdgroup").append("<input id='btnGrupo1'  style='padding-left: 10px;padding-right: 10px;' class='cz-form-content-input-button btnGrupo' type='button' value='...' />");
    }
    else {
        tr.find(".txtCodGrupo").remove();
        tr.find(".btnGrupo").remove();

        if (elegido == "ALF" || elegido == "NUM" || elegido == "DEC") {
            tr.find(".txtMax").remove();
            tr.find(".cz-form-content-input-text-visible").remove();
            tr.find(".tdMax").append("<input id='txtMax1' class='txtMax cz-form-content-input-text' onkeypress='fc_PermiteNumeros()' onblur='grabarTR(this);'  type='text' /> <div class='cz-form-content-input-text-visible'><div class='cz-form-content-input-text-visible-button'></div></div>");

        }
        else {
            tr.find(".txtMax").remove();
            tr.find(".cz-form-content-input-text-visible").remove();
        }
    }


}

function grabarTR(control) {
    var table = $('#' + control.id).parent().parent().parent().parent();
    var tr = $('#' + control.id).parent().parent();

    if ($(tr).hasClass('editable')) {
        var existe = false;
        var fotos = 1;
        var grupo = false;
        var max = false;
        $(table).find('.disable').find(".txtEtiqueta").each(function () {

            if ($(this).val() == tr.find(".txtEtiqueta").val()) {
                existe = true;
            }


        });
        if (tr.find(".cboTipo").val() == "FOT") {
            $(table).find('.disable').find(".cboTipo").each(function () {

                if ($(this).val() == "FOT") {
                    fotos = fotos + 1;
                }

            });
            if (fotos > 3) {
                existe = true;
            }
        }
        if (tr.find(".cboTipo").val() == "CHG" || tr.find(".cboTipo").val() == "COM") {
            if (tr.find(".txtCodGrupo").val() == "") {
                existe = true;
                grupo = true;
            }
        }
        if (tr.find(".cboTipo").val() == "ALF" || tr.find(".cboTipo").val() == "NUM" || tr.find(".cboTipo").val() == "DEC") {
            if (tr.find(".txtMax").val() == "") {
                existe = true;
                max = true;
            }
        }
        if (!existe) {
            if (tr.find(".txtEtiqueta").val() != "") {
                tr.find("input,select").attr('disabled', 'disabled');
                tr.addClass('disable').removeClass('nodrop').removeClass('nodrag');
                $(table).tableDnD();



            }
            else {
                addnotify("notify", "Debe ingresar la etiqueta", "registeruser");
            }
        }
        else {
            if (fotos > 3) {
                addnotify("notify", "Solo se puede agregar 3 controles de foto", "registeruser");

            }
            else {
                if (grupo) {
                    addnotify("notify", "Debe asignar un grupo", "registeruser");


                }
                else if (max) {
                    addnotify("notify", "Ingresar el valor de caracteres maximo", "registeruser");

                }
                else {
                    addnotify("notify", 'Ya existe un control con la etiqueta ' + tr.find(".txtEtiqueta").val(), "registeruser");

                }
            }
        }
    }
    else {
        var $trUlt = $(table).find("tbody tr:last");
        var existe = false;
        var fotos = 1;
        var grupo = false;
        var max = false;
        $(table).find('.disable').find(".txtEtiqueta").each(function () {

            if ($(this).val() == $trUlt.find(".txtEtiqueta").val()) {
                existe = true;
            }

        });

        if ($trUlt.find(".cboTipo").val() == "FOT") {
            $(table).find('.disable').find(".cboTipo").each(function () {

                if ($(this).val() == "FOT") {
                    fotos = fotos + 1;
                }

            });
            if (fotos > 3) {
                existe = true;
            }
        }

        if ($trUlt.find(".cboTipo").val() == "CHG" || $trUlt.find(".cboTipo").val() == "COM") {
            if ($trUlt.find(".txtCodGrupo").val() == "") {
                existe = true;
                grupo = true;
            }
        }

        if ($trUlt.find(".cboTipo").val() == "ALF" || $trUlt.find(".cboTipo").val() == "NUM" || $trUlt.find(".cboTipo").val() == "DEC") {
            if ($trUlt.find(".txtMax").val() == "") {
                existe = true;
                max = true;
            }
        }

        if (!existe) {

            if ($trUlt.find(".txtEtiqueta").val() != "") {
                var $tr = $(table).find("tbody tr:last").clone();
                $tr.find("input,select").attr("id", function () {
                    var parts = this.id.match(/(\D+)(\d+)$/);
                    return parts[1] + ++parts[2];
                });

                $tr.find("input[type='text']").val('');
                $tr.find("input[type='checkbox']").attr('checked', 'checked');

                $trUlt.find("input,select").attr('disabled', 'disabled');
                $trUlt.addClass('disable').removeClass('nodrop').removeClass('nodrag');

                $(table).find("tbody tr:last").after($tr);
                $(table).tableDnD();


                tipo2($tr.find('.cboTipo')[0].id);


                $('.divControl').animate({ scrollTop: $(".divControl").height() }, 1000);
            }
        }
        else {
            if (fotos > 3) {
                addnotify("notify", "Solo se puede agregar 3 controles de foto", "registeruser");

            }
            else {
                if (grupo) {
                    addnotify("notify", "Debe asignar un grupo", "registeruser");

                }
                else if (max) {
                    addnotify("notify", "Ingresar el valor de caracteres maximo", "registeruser");

                }
                else {
                    addnotify("notify", 'Ya existe un control con la etiqueta ' + $trUlt.find(".txtEtiqueta").val(), "registeruser");

                }
            }
        }
    }
}


function grabarTROPC(control) {
    var table = $('#' + control.id).parent().parent().parent().parent();
    var tr = $('#' + control.id).parent().parent();
    var nombre = false;
    if ($(tr).hasClass('editable')) {

        var existe = false;


        $(table).find('.disable').find(".txtOPNombre").each(function () {

            if ($(this).val() == tr.find(".txtOPNombre").val()) {
                existe = true;
                nombre = true;
            }

        });

        $(table).find('.disable').find(".txtOPCodigo").each(function () {

            if ($(this).val() == tr.find(".txtOPCodigo").val()) {
                existe = true;
                nombre = false
            }

        });


        if (!existe) {
            if (tr.find(".txtOPNombre").val() != "" || tr.find(".txtOPCodigo").val() != "") {
                tr.find("input").attr('disabled', 'disabled');
                tr.addClass('disable').removeClass('nodrop').removeClass('nodrag');
                $(table).tableDnD();
            }
            else {
                addnotify("notify", "Debe ingresar la etiqueta", "registeruser");

            }
        }
        else {
            if (nombre) {
                addnotify("notify", 'Ya existe una opcion con el nombre ' + tr.find(".txtOPNombre").val(), "registeruser");

            }
            else {
                addnotify("notify", 'Ya existe una de opcion con el codigo ' + tr.find(".txtOPCodigo").val(), "registeruser");


            }

        }
    }
    else {
        var $trUlt = $(table).find("tbody tr:last");
        var existe = false;


        $(table).find('.disable').find(".txtOPNombre").each(function () {

            if ($(this).val() == tr.find(".txtOPNombre").val()) {
                existe = true;
                nombre = true;
            }

        });

        $(table).find('.disable').find(".txtOPCodigo").each(function () {

            if ($(this).val() == tr.find(".txtOPCodigo").val()) {
                existe = true;
                nombre = false
            }

        });



        if (!existe) {
            if ($trUlt.find(".txtOPNombre").val() != "" && $trUlt.find(".txtOPCodigo").val() != "") {
                var $tr = $(table).find("tbody tr:last").clone();
                $tr.find("input,select").attr("id", function () {
                    var parts = this.id.match(/(\D+)(\d+)$/);
                    return parts[1] + ++parts[2];
                });

                $tr.find("input[type='text']").val('');
                $tr.find("input[type='checkbox']").attr('checked', false);

                $trUlt.find("input").attr('disabled', 'disabled');
                $trUlt.addClass('disable').removeClass('nodrop').removeClass('nodrag');

                $(table).find("tbody tr:last").after($tr);
                $(table).tableDnD();


            }
        }
        else {
            if (!existe) {
                if (tr.find(".txtOPNombre").val() != "" && tr.find(".txtOPCodigo").val() != "") {
                    tr.find("input").attr('disabled', 'disabled');
                    tr.addClass('disable').removeClass('nodrop').removeClass('nodrag');
                    $(table).tableDnD();
                }
                else {
                    addnotify("notify", 'Debe ingresar la etiqueta', "registeruser");

                }
            }
            else {
                if (nombre) {
                    addnotify("notify", 'Ya existe una opcion con el nombre ' + tr.find(".txtOPNombre").val(), "registeruser");

                }
                else {
                    addnotify("notify", 'Ya existe una de opcion con el codigo ' + tr.find(".txtOPCodigo").val(), "registeruser");

                }

            }
        }
    }
}

var realizarAccion = false;
var selectDefault = true;
var selectAllOption = true;
function cargaComboMulti(rutaServicio, nomCombo, data) {
    var rutaUrl = "";
    var dataAjax = "";

    var strData = new Object();
    if (typeof (data) == "undefined") dataAjax = JSON.stringify(strData);
    else dataAjax = JSON.stringify(data);

    var fill = "";
    if (typeof (window.valorFiltro) == "undefined") {
        window.valorFiltro = "";
    }
    fill = window.valorFiltro;

    rutaUrl = rutaServicio;//+ 'CargarMarca';
    $.ajax({
        type: 'POST',
        url: rutaUrl,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: dataAjax,
        success: function (result) {
            cargaItemsMulti(result, nomCombo);
        },
        error: function (xhr, status, error) {
            addnotify("notify", xhr.responseJSON.Message, "registeruser");
        }
    });
}

function cargaComboDSL(rutaServicio, nomCombo, defaultT, data) {


    var rutaUrl = "";
    var dataAjax = "";

    var strData = new Object();
    if (typeof (data) == "undefined") dataAjax = JSON.stringify(strData);
    else dataAjax = JSON.stringify(data);

    var fill = "";
    if (typeof (window.valorFiltro) == "undefined") {
        window.valorFiltro = "";
    }
    fill = window.valorFiltro;

    rutaUrl = rutaServicio;//+ 'CargarMarca';
    $.ajax({
        type: 'POST',
        url: rutaUrl,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: dataAjax,
        success: function (result) {
            cargaItemsDSL(result, nomCombo, defaultT);
        },
        error: function (xhr, status, error) {
            addnotify("notify", xhr.responseJSON.Message, "registeruser");
        }
    });
}
function cargaItemsDSL(result, nomCombo, defaultT) {
    $(nomCombo).empty();
    var optionsData = [];
    $(nomCombo).append($("<option ></option>").attr("value", "").text(".: " + defaultT + " :."))
    //optionsData.push({
    //    "label": this.Text,
    //    "value": this.Value
    //})
    $.each(result.d, function () {
        $(nomCombo).append($("<option " + (this.Selected ? "selected=\"selected\"" : "") + "></option>").attr("value", this.Value).text(this.Text))
        //optionsData.push({
        //    "label": this.Text,
        //    "value": this.Value,
        //    //"selected": ((selectDefault == true) ? true : this.Selected),
        //})
    });
    var selecItem = "";
    $(nomCombo + " option").each(function () {
        if (typeof ($(this).attr("selected")) != "undefined") {
            selecItem = $(this).val();
        }
    });

    $(nomCombo).val(selecItem);
    $(nomCombo).change();
};
function cargaItemsMulti(result, nomCombo) {
    $(nomCombo).empty();
    var optionsData = [];
    $.each(result.d, function () {
        $(nomCombo).append($("<option selected=\"selected\"></option>").attr("value", this.Value).text(this.Text))
        optionsData.push({
            "label": this.Text,
            "value": this.Value,
            //"selected": true,
            "selected": ((selectDefault == true) ? true : this.Selected),
        })
    });
    $(nomCombo).multiselect({
        includeSelectAllOption: selectAllOption,//true,
        enableCaseInsensitiveFiltering: true,
        onSelectAll: function () {
            gruposSeleccionados = "";
            if (realizarAccion) {
                vendedoresPorGrupos();
            }
        },
        onDeselectAll: function () {
            gruposSeleccionados = "";
            if (realizarAccion) {
                vendedoresPorGrupos();
            }
        },
        onChange: function (option, checked) {
            gruposSeleccionados = "";
            if (realizarAccion) {
                vendedoresPorGrupos();
            }
        }
    });
    $(nomCombo).multiselect('refresh');
    $(nomCombo).multiselect('dataprovider', optionsData);
}

function vendedoresPorGrupos() {
    $('#ddlGrupo option:selected').each(function () {
        gruposSeleccionados += $(this).val() + ', ';
    });
    BuscarUsuariosPorGrupo();
}

function BuscarUsuariosPorGrupo() { //funcion encargada de enviar los parametros a la grilla
    var rutaUrl = "";
    var dataAjax = "";

    var strData = new Object();
    //strData.pGrupo = $('#cboGrupro').val();
    strData.pGrupo = gruposSeleccionados;
    dataAjax = JSON.stringify(strData);
    rutaUrl = urlPrin + '/MostarUsuariosPorGrupos';

    $('#ddlUsuario').empty();
    $("#checkDinamicos").html("");
    $("#textoDinamico").html("");
    $.ajax({
        type: 'POST',
        url: rutaUrl,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: dataAjax,//JSON.stringify(strData),
        success: cargaItemsUsuario,
        error: function (xhr, status, error) {
            alert(error);
        }
    });

}

function cargaItemsUsuario(result) {
    if (typeof (usuExterno) == "undefined") {
        usuExterno = "";
    }
    $('#ddlUsuario').empty();
    var optionsData = [];
    $.each(result.d, function () {
        $("#ddlUsuario").append($("<option selected=\"selected\"></option>").attr("value", this.Value).text(this.Text))
        optionsData.push({
            "label": this.Text,
            "value": this.Value,
            "selected": (usuExterno == "" ? true : (this.Value == usuExterno ? true : false)),
        })

    });

    $('#ddlUsuario').multiselect({
        includeSelectAllOption: true,
        enableCaseInsensitiveFiltering: true
    });
    $('#ddlUsuario').multiselect('refresh');
    $('#ddlUsuario').multiselect('dataprovider', optionsData);
}



/*autocompleMulti*/

function autocompleMulti(rutaServicio, txtInput, txtDatos, data) {
    var arrDatos = new Array();
    /***   AUTOCOMPLETE - INICIO   ***/
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: rutaServicio,
        data: data,
        dataType: 'json',
        success: function (result) {
            $(txtInput).tokenInput($.parseJSON(result.d), {
                preventDuplicates: true,
                onAdd: function (item) {
                    arrDatos.push(item.nxt);
                    $(txtDatos).val(arrDatos);
                },
                onDelete: function (item) {
                    arrDatos.pop(item.nxt);
                    $(txtDatos).val(arrDatos);
                }
            });
        }
    });
}
function autocompleMultiAnidado(rutaServicio, txtInput, txtDatos, data, rutaServicioHijo) {
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: rutaServicio,
        data: data,
        dataType: 'json',
        success: function (result) {
            $(txtInput).tokenInput($.parseJSON(result.d), {
                preventDuplicates: true,
                onAdd: function (item) {
                    var strData = new Object();
                    strData.id = item.id;

                    $.ajax({
                        type: "POST",
                        contentType: "application/json",
                        url: rutaServicioHijo,
                        data: JSON.stringify(strData),
                        dataType: 'json',
                        success: function (data, status) {
                            var d = $.parseJSON(data.d);
                            $.each(d, function (index, dt) {
                                $(txtDatos).tokenInput("add", { id: dt.id, name: dt.name, nxt: dt.nxt });
                            });
                        }
                    });
                },
                onDelete: function (item) {
                    var strData = new Object();
                    strData.idGrupo = item.id;

                    $.ajax({
                        type: "POST",
                        contentType: "application/json",
                        url: rutaServicioHijo,
                        data: JSON.stringify(strData),
                        dataType: 'json',
                        success: function (data, status) {
                            var d = $.parseJSON(data.d);
                            $.each(d, function (index, dt) {
                                $(txtDatos).tokenInput("remove", { id: dt.id, name: dt.name, nxt: dt.nxt });
                            });
                        }
                    });
                }
            });
        }
    });
}


function PintarGraficoPie(div, data) {
    Highcharts.theme = {
        colors: ['#18B28B', '#E86A6A', '#ED561B', '#DDDF00', '#24CBE5', '#64E572',
                 '#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            backgroundColor: {
                linearGradient: [0, 0, 500, 500],
                stops: [
                    [0, 'rgb(255, 255, 255)'],
                    [1, 'rgb(240, 240, 255)']
                ]
            },
        },
        title: {
            style: {
                color: '#000',
                font: 'bold 16px "Trebuchet MS", Verdana, sans-serif'
            }
        },
        subtitle: {
            style: {
                color: '#666666',
                font: 'bold 16px "Trebuchet MS", Verdana, sans-serif'
            }
        },

        legend: {
            itemStyle: {
                font: '9pt Trebuchet MS, Verdana, sans-serif',
                color: 'black'
            },
            itemHoverStyle: {
                color: 'gray'
            }
        }
    };

    // Apply the theme
    Highcharts.setOptions(Highcharts.theme);
    Highcharts.chart(div, {
        chart: {
            type: 'pie',
        },
        title: {
            text: data.d.Titulo
        },
        subtitle: {
            text: '<strong>' + data.d.SubTitulo + '</strong>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                innerSize: 100,
                depth: 45,
                showInLegend: true
            },
        },
        tooltip: {
            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
        },
        series: [{
            data: data.d.items,
            dataLabels: {
                enabled: true,
                format: '{point.y} <br/> {point.percentage:.1f}%'
            }
        }]
    });
}
function PintarGraficoBar(div, data) {
    Highcharts.theme = {
        colors: ['#18B28B', '#E86A6A', '#ED561B', '#DDDF00', '#24CBE5', '#64E572',
                 '#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            backgroundColor: {
                linearGradient: [0, 0, 500, 500],
                stops: [
                    [0, 'rgb(255, 255, 255)'],
                    [1, 'rgb(240, 240, 255)']
                ]
            },
        },
        title: {
            style: {
                color: '#000',
                font: 'bold 16px "Trebuchet MS", Verdana, sans-serif'
            }
        },
        subtitle: {
            style: {
                color: '#666666',
                font: 'bold 16px "Trebuchet MS", Verdana, sans-serif'
            }
        },

        legend: {
            itemStyle: {
                font: '9pt Trebuchet MS, Verdana, sans-serif',
                color: 'black'
            },
            itemHoverStyle: {
                color: 'gray'
            }
        }
    };

    // Apply the theme
    Highcharts.setOptions(Highcharts.theme);
    Highcharts.chart(div, {
        chart: {
            type: 'column',
        },
        title: {
            text: data.d.Titulo
        },
        subtitle: {
            text: '<strong>' + data.d.SubTitulo + '</strong>'
        },
        xAxis: {
            type: 'category'
        },
        yAxis: {
            title: {
                text: 'Cantidad'
            }

        },
        tooltip: {
            pointFormat: '{point.name}: <b>{point.y}</b>'
        },
        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true,
                    format: '{point.y}'
                }
            }
        },
        series: [{
            colorByPoint: true,
            data: data.d.items,
            showInLegend: false

        }]
    });
}

function cargarEventoKeyDown() {
    $(".filtergrid").find("input[type='text']").on("keydown", function (event) {
        if (event.which == 13)
            $('#buscar').trigger("click");
    });
}

function textAutocomplete(txtinput, server) {
    $(txtinput).autocomplete(server,
                     {
                         multiple: false,
                         minChars: 0,
                         max: 12,
                         autoFill: false,
                         cacheLength: 0,
                         mustMatch: true,
                         matchContains: true,
                         selectFirst: true,
                         dataType: 'json',
                         parse: function (data) {
                             return $.map(data, function (row) {
                                 return {
                                     data: row, value: row.Nombre, result: row.Nombre

                                 }
                             });
                         },
                         formatItem: function (item) {

                             return item.Nombre;
                         }

                     });
}
function formatddmmyy(d) {

    var month = d.getMonth() + 1;
    var day = d.getDate();
    var hour = d.getHours();
    var minute = d.getMinutes();
    var second = d.getSeconds();

    return (('' + day).length < 2 ? '0' : '') + day + '/' +
        (('' + month).length < 2 ? '0' : '') + month + '/' +
        d.getFullYear()


}
function ValorComboMultSinAll(input) {
    var val = "";
    $('' + input + ' option:selected').each(function () {
        val += $(this).val() + ",";
    })
    return val;
}
function cargacomboC(Padre, Hijo, pag, codigo, nombre) //funcion encargada de manejar combos anidados sin la necesidad de realizar algun postback
{

    $(document).ready(function () {

        elegido = Padre;

        $.post(pag, { elegido: elegido, codigo: codigo, nombre: nombre }, function (data) {
            $(Hijo).html(data);
        });

        $(Hijo).change();
        $(Hijo).val(0);
        $(Hijo).change();
    });
}

function cargacomboCTop(Padre, Hijo, pag, codigo, nombre) //funcion encargada de manejar combos anidados sin la necesidad de realizar algun postback
{
    $(document).ready(function () {

        elegido = Padre;

        $.post(pag, { elegido: elegido, codigo: codigo, nombre: nombre }, function (data) {
            $(Hijo).html(data);
        });

        //$(Hijo).change();
        $(Hijo).val(-1);
        $(Hijo).change();
    });
}

function cargacomboC_Top(Padre, Hijo, pag, codigo, nombre) //funcion encargada de manejar combos anidados sin la necesidad de realizar algun postback
{
    $(document).ready(function () {

        elegido = Padre;

        $.post(pag, { elegido: elegido, codigo: codigo, nombre: nombre }, function (data) {
            $(Hijo).html(data);
        });

        //$(Hijo).change();
        $(Hijo).val('-1-NEXTEL');
        $(Hijo).change();
    });
}

function cargacomboD(Padre, Hijo, pag, codigo, nombre, tipo) //funcion encargada de manejar combos anidados sin la necesidad de realizar algun postback
{
    $(document).ready(function () {
        elegido = Padre;

        $.post(pag, { elegido: elegido, codigo: codigo, nombre: nombre, tipo: tipo }, function (data) {
            $(Hijo).html(data);
        });

        $(Hijo).change();
        $(Hijo).val(0);
        $(Hijo).change();
    });
}


function generadorControles(Contenedor, idOp, Modificable, idConfOp, Obligatorio, TipoControl,
    MaxCaracter, ValorControl, Etiqueta, CodigoGeneral, idPadre) {
    var update = (idOp != "" ? 'T' : 'F');
    var disableStr = (update == 'T' && Modificable == 'F' ? 'disabled' : '');
    var control = "";
    var ctrlUnique = 'idCtrl="' + idConfOp + '" typeCtrl="' + TipoControl + '"';
    if (TipoControl == "1" || TipoControl == "4" || TipoControl == "6") {

        control = control + '<div class="col-sm-12 form-group">';
        control = control + '<label for="Mtxt' + idConfOp + '">' + Etiqueta + '</label>';
        //if (Obligatorio == "T") {
        //    control = control + '<span style="color: #b94a48">*</span>';
        //}
        control = control + (Obligatorio == 'T' && disableStr == '' ? '<span style="color: #b94a48">*</span>' : '');
        control = control + '<input type="text" id="Mtxt' + idConfOp + '"  ' + ctrlUnique;
        control = control + ' class="controldinamico ' + (Obligatorio == 'T' && disableStr == '' ? 'requerid' : '') + ' form-control" ';
        control = control + ' ' + (TipoControl == "4" ? 'oninput = "fc_PermiteNumerosOnInput(event,this)"' : '') + ' ';
        control = control + ' ' + (TipoControl == "1" ? 'oninput = "SoloAlfanumericoOnInput(event,this);"' : '') + ' ';
        control = control + ' ' + (TipoControl == "6" ? 'oninput = "isDecimalNumberOnInput(event,this)"' : '') + ' ';
        control = control + ' maxlength="' + String(MaxCaracter) + '" value ="' + ValorControl + '" ' + disableStr + ' />';
        control = control + '</div>';

    } else if (TipoControl == "5") {
        control = control + '<div class="col-sm-12 form-group">';
        control = control + '<label for="Mtxt' + idConfOp + '">' + Etiqueta + '</label>';
        control = control + (Obligatorio == 'T' && disableStr == '' ? '<span style="color: #b94a48">*</span>' : '');
        control = control + '<div class="input-group" ' + ((update == 'T' && Modificable == 'T') || update == 'F' ? 'data-toggle="datepicker"' : '') + '>';
        control = control + '<input type="text" readonly ID="Mtxt' + idConfOp + '" ' + ctrlUnique + ' class="form-control controldinamico ';
        control = control + (Obligatorio == 'T' && disableStr == '' ? 'requerid' : '') + '" ' + disableStr + ' MaxLength="10" type="text" data-date-format="dd/mm/yyyy" name="fechaDesde" ';
        control = control + ' onkeypress="javascript:fc_Slash(this.id, \' / \');" onblur="javascript:fc_ValidaFechaOnblur(this.id);"  value ="' + ValorControl + '" />';
        control = control + '<span class="input-group-btn">';
        control = control + '<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>';
        control = control + '</span></div></div>';
    } else if (TipoControl == "3") {
        control = control + '<div class="col-sm-12 form-group">';
        control = control + '<label for="Mddl' + idConfOp + '">' + Etiqueta + '</label>';
        control = control + (Obligatorio == 'T' && disableStr == '' ? '<span style="color: #b94a48">*</span>' : '');
        control = control + '<select id="Mddl' + idConfOp + '" ' + ctrlUnique + ' class="form-control controldinamico ' + (Obligatorio == 'T' && disableStr == '' ? 'requerid' : '') + '" ' + disableStr + ' >';
        control = control + '<option value="">.: SELECCIONE :.</option>';
        control = control + '</select></div>';

        if (idPadre != "") {
            $('#Mddl' + idPadre).change(function () {
                var idPadreCtr = $('#Mddl' + idPadre).val();
                cargaComboDSL(urlPrin + '/ComboGeneralDinamico', '#Mddl' + idConfOp, 'SELECCIONE', {
                    Grupo: CodigoGeneral, defaultVal: ValorControl, idPadre: idPadreCtr
                });
            })
        }

        cargaComboDSL(urlPrin + '/ComboGeneralDinamico', '#Mddl' + idConfOp, 'SELECCIONE', { Grupo: CodigoGeneral, defaultVal: ValorControl, idPadre: '' });
    }
    else if (TipoControl == "9") {
        var d = new Date();

        var nombreFoto = ("00" + (d.getMonth() + 1)).slice(-2) + "_" + ("00" + d.getDate()).slice(-2) + "_" + d.getFullYear() + "_" + ("00" + d.getHours()).slice(-2) + "_" + ("00" + d.getMinutes()).slice(-2) + "_" + ("00" + d.getSeconds()).slice(-2);

        control = control + '<div class="col-sm-12 form-group">';
        control = control + '<label for="MFl' + idConfOp + '">' + Etiqueta + '</label>';
        control = control + (Obligatorio == 'T' && disableStr == '' ? '<span style="color: #b94a48">*</span>' : '');
        control = control + '<input id="MFl' + idConfOp + '" ' + ctrlUnique + ' namePhoto="' + nombreFoto + '" accept="image/*"  type="file" capture class="form-control controldinamico controldinamicoFoto ' + (Obligatorio == 'T' && disableStr == '' ? 'requerid' : '') + '" ' + disableStr + '/>';
        control = control + '<input type="hidden" ID="hdMFl' + idConfOp + 'Nombre" runat="server" /></div>';
        control = control + '<script>$("#MFl' + idConfOp + '").change(function () {SetearDinFoto(this);});</script>';
    }
    else if (TipoControl == "9IMG") {
        control = control + '<div class="col-sm-12 form-group">';
        control = control + '<div class="col-sm-12 form-group">';
        control = control + '<label for="MFl' + idConfOp + '">' + Etiqueta + '</label>';
        control = control + '<img id="MFl' + idConfOp + '" runat="server" style="width: 100%; height: 200px;" src="../../imagery/all/layout/noimg.jpg" />';
        control = control + '</div>';
        control = control + '<div class="col-sm-12 form-group">';
        control = control + '<button type="button" class="btn btn-default btnDescarga" disabled>Descargar</button>';
        control = control + '</div>';
        control = control + '</div>';
    }
    else if (TipoControl == "10") {
        control = control + '<div class="col-sm-12 form-group">';
        control = control + '<label for="Mddl' + idConfOp + '">' + Etiqueta + '</label>';
        control = control + (Obligatorio == 'T' && disableStr == '' ? '<span style="color: #b94a48">*</span>' : '');
        control = control + '<textarea id="Mtxt' + idConfOp + '"  ' + ctrlUnique;
        control = control + ' class="controldinamico ' + (Obligatorio == 'T' && disableStr == '' ? 'requerid' : '') + ' form-control" ';
        control = control + ' maxlength="' + String(MaxCaracter) + '" ' + disableStr + ' >' + ValorControl + '</textarea>';
        control = control + '</div>';
    }

    $(Contenedor).append(control);

}

function SetearDinFoto(input) {
    $('#hd' + input.id + 'Nombre').val("");
    //$('#imgPreview').attr('src', "");
    if (input.files && input.files[0]) {
        var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
        if (!allowedExtensions.exec(input.files[0].name)) {
            alert("Solo se permiten imágenes de tipo Imagen");
            $(input).val("");
        }
        else {
            if (input.files[0].size > $('#hdTamFoto').val()) {
                alert("Tamaño de imagen superior al permitido");
                $(input).val("");
            }
            else {
                var reader = new FileReader();

                reader.onload = function (e) {
                    //$('#imgPreview').attr('src', e.target.result);
                    $('#hd' + input.id + 'Nombre').val(input.files[0].name);
                }

                reader.readAsDataURL(input.files[0]);
            }
        }
    }
}