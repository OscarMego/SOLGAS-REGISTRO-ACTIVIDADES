var urldel = urlPrin + '/Desactivate'; //WebMethod para eliminacion
var urlins = 'ContactoNew.aspx'//pantalla de registros
var urlbus = 'TipoGrid.aspx'; //grilla
var urlsavN = urlPrin + '/InsertContact'; //WebMethod para insercion
var urlCont = urlPrin + '/getContacts'; //WebMethod para insercion
var urlInst = urlPrin + '/getInstalacion'; //WebMethod para insercion
var urlForm = urlPrin + '/InsertFormulario'; //WebMethod para insercion
var urlsavE = urlPrin + '/Update'; //WebMethod para edicion
var urlrest = urlPrin + '/Activate'; //WebMethod para restauracion
var urlObtenerTipoActividad = urlPrin + '/ObtenerEstadoOportunidad'; //WebMethod para restauracion
selectDefault = false;

$(document).ready(function () {
    var nowDate = new Date();
    var startDate = new Date(nowDate);
    startDate.setDate(nowDate.getDate() - 1);

    $('#txtFechaInicio').datepicker({
        startDate: startDate,
        endDate: nowDate
    });
    $("#cboSubTipoActividad").change(function (e) {
        var codigoConf = $(this).val();
        var urlObtenerContiguracion = "ObtenerConfiguracion";
        var codTipoActividad = $('#cboTipoActividad').val();
        if ($('#hddEsOportunidad').val() == 'T') {
            if (codigoConf == '-1') {
                $('#dvCambiarEtapa').hide();
                urlForm = urlPrin + '/InsertOportunidad';
                $('#txtCliente').removeAttr("disabled");
            } else {
                $('#dvCambiarEtapa').show();
                urlForm = urlPrin + '/InsertEtapa';
                $("#MtxtIdOportunidad").val(codigoConf.split('|')[1]);
                codigoConf = codigoConf.split('|')[0];
                urlObtenerContiguracion = "ObtenerConfiguracionEtapa";
                $('#txtCliente').attr("disabled", "disabled");
            }
        }
        var IdOp = $("#MtxtIdOportunidad").val();
        $.ajax({
            type: 'POST',
            url: urlPrin + '/' + urlObtenerContiguracion,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            data: JSON.stringify({ CodigoConf: codigoConf, IdOp: IdOp, tipoActividad: codTipoActividad }),
            success: function (result) {
                var data = result.d;// $.parseJSON(result.d);                
                $("#DivAutogenerado").html('');
                $.each(data, function (index, dt) {
                    $("#MtxtIdNewOportunidad").val(dt.IdConfiguracionOportunidad);
                    $("#lblCambiarEtapa").html("Cambiar Etapa: " + dt.EtapaSiguiente);
                    if (urlObtenerContiguracion == "ObtenerConfiguracionEtapa") {
                        $('#txtCliente').val(dt.RazonSocial);
                        $('#hdiCodClie').val(dt.CodCliente);
                    }
                    generadorControles("#DivAutogenerado", $("#MtxtIdOportunidad").val(), dt.Modificable,
                        dt.IdConfiguracionoportunidadDetalle, dt.Obligatorio, dt.CodigoTipoControl, dt.MaxCaracter,
                        dt.ValorControl, dt.Etiqueta, dt.CodigoGeneral, dt.idPadre);
                });
                $("#DivAutogenerado" + ' [data-toggle="datepicker"]').each(function (id, item) {
                    var dp = $(item).children('input').datepicker();
                    $(item).find('button').click(function () {
                        dp.datepicker('show');
                    });
                    $(item).children('input').on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });
                });
            },
            error: function (xhr, status, error) {
                alert(error);
            }
        });
    });

    $('#cboTipoActividad').change(function () {
        var codTipo = $(this).val();
        var oportunidad = 'F';
        $.ajax({
            type: 'POST',
            url: urlObtenerTipoActividad,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            data: JSON.stringify({ Id: codTipo }),
            success: function (data) {
                if (data.d != null) {
                    if (data.d.oportunidad == 'T') {
                        $('#dvCambiarEtapa').show();
                        oportunidad = 'T';
                        $('#lblSubTipoOportunidad').html("Oportunidad");
                        $('#hddEsOportunidad').val('T')
                        $('#dvClienteInstalacion').hide();
                        $('#txtCodInstalacion').removeClass('requerid');
                    } else {
                        $('#dvClienteInstalacion').show();
                        $('#hddEsOportunidad').val('')
                        $('#dvCambiarEtapa').hide();
                        $('#lblSubTipoOportunidad').html("Sub Tipo de Actividad");
                        urlForm = urlPrin + '/InsertFormulario';
                        $('#txtCodInstalacion').addClass('requerid');
                        $('#txtCliente').removeAttr("disabled");
                    }
                    if (data.d.contacto == 'T') {
                        $('#txtContacto').addClass('requerid');
                    } else {
                        $('#txtContacto').removeClass('requerid');
                    }
                }
                cargaComboDSL(urlPrin + '/ComboSubTipo', '#cboSubTipoActividad', 'SELECCIONE', {
                    idTipo: codTipo, oportunidad: oportunidad
                });
            },
            error: function (xhr, status, error) {
                addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
            }
        });
        $('#txtCliente').autocomplete({
            serviceUrl: urlFillCliente + '?idTipoActividad=' + codTipo,
            onSelect: function (suggestion) {
                //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
                $(this).attr("idval", suggestion.data);
                $('#hdiCodClie').val(suggestion.data);
            },
            onSearchStart: function (params) {
                $(this).attr("idval", "");
                $('#hdiCodClie').val('');
                //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
            },
            paramName: 'query',
            transformResult: function (response) {
                response = $.parseJSON(response);
                return {
                    suggestions: $.map(response, function (dataItem) {
                        return { value: dataItem.Nombre, data: dataItem.Codigo };
                    })
                };
            }
        });
    });
    $('#buscar').trigger("click");
    //cargarEventoKeyDown();
    addRegDim();
    getLocation();
    addRegCon();
    //$('#btnNuevaOportuninad').on('click', function () {
    // detReg(".addReg", "BanOportunidadNew.aspx");
    $('body').on('click', ".addReg", function (e) {
        $.ajax({
            type: 'POST',
            url: 'BanOportunidadNew.aspx',
            beforeSend: function () {
                $("#mdNewOportunidad").html('');
            },
            success: function (data) {
                $("#mdNewOportunidad").html(data);
                $('#mdNewOportunidad').modal('show');
            },
            error: function (xhr, status, error) {
                $("#mdNewOportunidad").html(alertHtml('error', xhr.responseText));
                $('#mdNewOportunidad').modal('show');
            }
        });
    });



    //addReg(); //funcion encargada de adiccionar registros
    //});
});

function clearCampos() {//funcion encargada de limpiar los input
    $('#txtFechaInicio').val('');
    $('#txtCliente').val('');
    $('#cboTipoActividad').val('');
    $('#cboTipoActividad').trigger("change");
    $('#txtContacto').val('');
    $('#txtMail').val('');
    $('#txtTelefono').val('');
    $('#txtCargo').val('');
    $('#txtObservaciones').val('');
    $('#dvCambiarEtapa').hide();
    $('#txtCodInstalacion').val('');
    //window.location.reload(true);
}
function getCodClie() {
    var strData = new Object();
    strData.CodCliente = $('#txtCliente').attr("idval");
    strData.codInstalacion = $('#txtCodInstalacion').val();
    strData.buscador = $('#txtBuscarInstalacion').val();
    strData.buscador = strData.buscador == undefined ? '' : strData.buscador;
    return strData;
    return strData;
}
function getDataDim() {//funcion encargada de enviar los parametros para la insercion o edicion

    var strData = new Object();
    strData.id = $('#cboSubTipoActividad').val();
    strData.ConfOpor = $('#cboSubTipoActividad').val();
    if ($('#hddEsOportunidad').val() == 'T') {
        if (strData.ConfOpor == '-1') {
            strData.ConfOpor = $('#MtxtIdNewOportunidad').val();
        } else {
            strData.CambiaEtapa = ($('#MchkCambiarEtapa').is(':checked') ? 'T' : 'F');
            strData.id = strData.id.split('|')[1];
        }
    }
    strData.observaciones = $('#txtObservaciones').val();
    strData.CodCliente = $('#txtCliente').attr("idval");
    strData.idContacto = $('#hddIdContacto').val();
    strData.codInstalacion = $('#txtCodInstalacion').val();
    var controlDinam = "";
    $(".controldinamico").each(function () {
        //console.log($(this).attr("idctrl"), $(this).attr("typeCtrl"));
        if ($(this).attr("typectrl") == '9') {
            controlDinam += $(this).attr("idctrl") + ";" + $(this).attr("namePhoto") + '_' + $(this).attr("idctrl") + '_' + $('#hddIdUsuario').val() + "|";
        } else {
            controlDinam += $(this).attr("idctrl") + ";" + $(this).val() + "|";
        }
    });
    strData.controldinamico = controlDinam;
    strData.fecha = $('#txtFechaInicio').val();
    strData.latitud = $('#hddLatitude').val();
    strData.longitud = $('#hddLongitude').val();
    strData.accion = $('#MhAccion').val();

    return strData;
}

function obtenerContactos() {
    var distribuidor = $('#txtCliente').val();
    if (distribuidor.length == 0) {
        addnotify("notify", "Debe seleccionar un cliente", "registeruser")
        return;
    }
    if ($('#hddEsOportunidad').val() != 'T') {
        var instalacion = $('#txtCodInstalacion').val();
        if (instalacion.length == 0) {
            addnotify("notify", "Debe seleccionar un codigo de instalción", "registeruser")
            return;
        }
    }
    $.ajax({
        type: 'POST',
        url: urlCont,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(getCodClie()),
        success: function (data) {
            var contactos = data.d;
            var html = "";
            for (var i = 0; i < contactos.length; i++) {
                html = html + "<div class=\'Contacts\'><span class=\'nombreContacto\' style=\'font-weight\:bold;'> " + contactos[i].Nombre + "</span><br><span class=\'idContacto\' hidden=\hidden\'>" + contactos[i].IdContacto + "</span><strong>Cargo: </strong><span class=\'cargoContacto\'>" + contactos[i].Cargo + "</span><br><div class=\'col-md-12\ row'><div class=\'col-md-6 \ row'><strong>Email: </strong><span class=\'emailContacto\'>" + contactos[i].Email + "</span></div><strong>Teléfono: </strong><span class=\'telefonoContacto\'>" + contactos[i].Telefono + "</span></div></div><br><hr>";
            }
            $('#ContactosLista').html(html);
            $('.Contacts').click(function () {
                var idContacto = $(this).find('.idContacto').html();
                $('#hddIdContacto').val(idContacto);
                var nombreContacto = $(this).find('.nombreContacto').html();
                $('#txtContacto').val(nombreContacto);
                var cargoContacto = $(this).find('.cargoContacto').html();
                $('#txtCargo').val(cargoContacto);
                var emailContacto = $(this).find('.emailContacto').html();
                $('#txtMail').val(emailContacto);
                var telefonoContacto = $(this).find('.telefonoContacto').html();
                $('#txtTelefono').val(telefonoContacto);
                $('#User').modal('hide');
                $('#ContactosLista').html('');
            });
            $('.addRegC').show()
            $('#User').modal('show');
        },
        error: function (xhr, status, error) {
            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
        }
    });

}



function obtenerInstalacion() {
    var distribuidor = $('#txtCliente').val();
    if (distribuidor.length == 0) {
        addnotify("notify", "Debe seleccionar un cliente", "registeruser")
        return;
    }
    var buscador = getCodClie().buscador;
    $.ajax({
        type: 'POST',
        url: urlInst,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(getCodClie()),
        success: function (data) {
            var instalacion = data.d;
            var html = "<input type='text' id='txtBuscarInstalacion' class='form-control' value='" + buscador + "'/><div class='btn btn-danger form-control' onclick='obtenerInstalacion();' maxlength='100'>Buscar</div><hr>";
            for (var i = 0; i < instalacion.length; i++) {
                html = html + "<div class=\'instalaciones\'><span class=\'codInstalacion\' style=\'font-weight\:bold;'>" + instalacion[i].CodInstalacion + "</span><br><span class=\'IDClienteInstalacion\' hidden=\hidden\'>" + instalacion[i].IDClienteInstalacion + "</span><strong>Descripcion: </strong><span class=\'desInstalacion\'>" + instalacion[i].Descripcion + "</span><br><div class=\'col-md-12\ row'><div class=\'col-md-6 \ row'><strong>Direccion: </strong><span class=\'insDireccion\'>" + instalacion[i].Direccion + "</span></div><strong>Referencia: </strong><span class=\'insReferencia\'>" + instalacion[i].Referencia + "</span></div></div><br><hr>";
            }
            $('#ContactosLista').html(html);
            $('.instalaciones').click(function () {
                var IDClienteInstalacion = $(this).find('.IDClienteInstalacion').html();
                $('#hddIdClienteInstalacion').val(IDClienteInstalacion);
                var codInstalacion = $(this).find('.codInstalacion').html();
                $('#txtCodInstalacion').val(codInstalacion);
                $('#hddIdContacto').val('');
                $('#txtContacto').val('');
                $('#txtCargo').val('');
                $('#txtMail').val('');
                $('#txtTelefono').val('');
                $('#User').modal('hide');
                $('#ContactosLista').html('');
            });
            $('.addRegC').hide()
            $('#User').modal('show');
        },
        error: function (xhr, status, error) {
            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
            $('#hddIdContacto').val('');
            $('#txtContacto').val('');
            $('#txtCargo').val('');
            $('#txtMail').val('');
            $('#txtTelefono').val('');
        }
    });

}


function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        alert("La geolocalización no está soportada en este navegador.");
    }
}
function showPosition(position) {
    $('#hddLatitude').val(position.coords.latitude);
    $('#hddLongitude').val(position.coords.longitude);
}
/*Agrega Registros*/
function addRegDim() {
    $('#saveRegD').click(function (e) {
        //e.preventDefault();
        var mensaje = "";
        var validateItems = true;

        $('.requerid').each(function () {
            $(this).parent().find('span').not(".multiselect-selected-text").remove();
            var minlength = 0;
            if (typeof ($(this).attr("minlength")) != "undefined") {
                minlength = $(this).attr("minlength");
                if ($(this).val().length < minlength) {
                    validateItems = false;
                    mensaje += $(this).attr("placeholder") + " debe contener mínimo " + minlength + " caracteres,</br>";
                }
            }
            if ($(this).val() == "") {
                validateItems = false;
            }
        });

        if ($('#txtFechaInicio').val() === '') {
            validateItems = false;
        }

        if (!validateItems) {
            mensaje += "Ingresar los campos obligatorios";
            addnotify("notify", mensaje, "registeruser");
        }
        else {
            $.ajax({
                type: 'POST',
                url: urlForm,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                data: JSON.stringify(getDataDim()),
                success: function (data) {
                    $(".controldinamicoFoto").each(function (e) {
                        console.log(this);
                        var formdataDim = new FormData();
                        var _image = $(this)[0].files[0];
                        formdataDim.append('file', _image);
                        formdataDim.append('idOportunidad', data.d);
                        formdataDim.append('nombreFoto', $(this).attr("namePhoto") + '_' + $(this).attr("idctrl") + '_' + $('#hddIdUsuario').val());
                        $.ajax({
                            type: "POST",
                            url: "fileUploader.ashx",
                            data: formdataDim,
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (result) { console.log(result); },
                            error: function (result) { console.log(result); }
                        });
                    })
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
}
/*Agrega Contactos*/
function addRegCon() {
    $('.addRegC').click(function (e) {
        $.ajax({
            type: 'POST',
            url: urlins,
            data: JSON.stringify(getCodClie()),
            success: function (data) {
                $("#mdNuevoContacto").html(data);
                $('#mdNuevoContacto').modal('show');
                $('#saveRegC').click(function (e) {
                    e.preventDefault();
                    var mensaje = "Ingresar los campos obligatorios";
                    if ($('#txtNombreC').val() === '' ||
                        $('#txtTelefonoC').val() === '' ||
                        $('#txtEmailC').val() === '' ||
                        $('#txtCargoC').val() === '' ||
                        $('#txtCliente').attr("idval") === '') {
                        addnotify("notify", mensaje, "registeruser");
                        return;
                    }

                    $.ajax({
                        type: 'POST',
                        url: urlsavN,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        data: JSON.stringify(getDataCon()),
                        success: function (data) {
                            var obj = data.d;
                            $('#hddIdContacto').val(obj.IdContacto);
                            $('#txtContacto').val(obj.Nombre);
                            $('#txtMail').val(obj.Email);
                            $('#txtTelefono').val(obj.Telefono);
                            $('#txtCargo').val(obj.Cargo);
                            addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                            $('#mdNuevoContacto').modal('hide');
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                        }
                    });


                });
            },
            error: function (xhr, status, error) {
                $("#mdNuevoContacto").html(alertHtml('error', xhr.responseText));
                $('#mdNuevoContacto').modal('show');
            }
        });

    });
}