<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BanOportunidadEtapa.aspx.cs" Inherits="Mantenimiento_BanOportunidad_BanOportunidadEtapa" %>

<!DOCTYPE html>
<html lang="es">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../js/multi-selected/dist/css/bootstrap-multiselect.css" rel="stylesheet" />
    <link href="../../css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
    <script src="../../js/jquery.autocomplete.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title" id="myModalLabel" runat="server"></h2>

                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-modal">
                        <form>
                            <div class="row">
                                <asp:HiddenField ID="hdinamicocontrol" runat="server" />
                                <asp:HiddenField ID="MtxtIdOportunidad" runat="server" />
                                <asp:HiddenField ID="MtxtIdEtapaSiguiente" runat="server" />
                                <asp:HiddenField ID="MtxtIdEtapaActual" runat="server" />
                                <asp:HiddenField ID="hddIdUsuario" runat="server" />

                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCodigo">Codigo</label>
                                    <input type="text" id="MtxtCodigo" disabled runat="server" class="form-control" maxlength="100" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtEtapa">Etapa</label>
                                    <input type="text" id="MtxtEtapa" disabled runat="server" class="form-control" maxlength="100" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtResponsable">Responsable</label>
                                    <input type="text" id="MtxtResponsable" disabled runat="server" class="form-control" maxlength="100" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtFechaInicio">Fecha Inicio</label>
                                    <input type="text" id="MtxtFechaInicio" disabled runat="server" class="form-control" maxlength="100" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtFechaFin">Fecha Fin</label>
                                    <input type="text" id="MtxtFechaFin" disabled runat="server" class="form-control" maxlength="100" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCliente">Cliente</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCliente" disabled runat="server" class="form-control" maxlength="100" />
                                </div>

                                <div class="col-sm-12 form-group">
                                    <label for="MchkCambiarEtapa" id="lblCambiarEtapa" runat="server">Cambiar Etapa</label>
                                    <input type="checkbox" name="MchkCambiarEtapa" value="notify" id="MchkCambiarEtapa" class="" checked="checked" />
                                </div>

                                <div class="col-sm-6 form-group" style="display: none">
                                    <asp:FileUpload ID="fuLogo" runat="server" capture BackColor="White" BorderColor="#766A62"
                                        BorderWidth="1px" Width='90%' CssClass="form-control" Visible="false"></asp:FileUpload>
                                    <asp:Button ID="btnSubirLogo" runat="server" OnClick="btnSubirLogo_Click" CssClass="icon-arrow-up" Style="text-align: center; display: none" Text=" SUBIR FOTO " />
                                    <asp:HiddenField ID="hdNombre" runat="server" />
                                    <asp:HiddenField ID="hdTamFoto" runat="server" />
                                    <asp:HiddenField ID="hdNombreGuar" runat="server" />
                                    <asp:HiddenField ID="hdURL" runat="server" />
                                </div>

                                <div class="row" id="DivAutogenerado" runat="server">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="modal-footer">
                    <div class="container-modal">
                        <button type="button" class="btn btn-danger" id="saveRegEtapa">Grabar</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>
                <asp:HiddenField ID="MhAccion" runat="server" />
            </div>
        </div>
        <script src="../../js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
        <script type="text/javascript">

            $(document).ready(function () {
                selectDefault = false;

                //$("#MchkCambiarEtapa").change(function (e) {
                //var chk = $("#MchkCambiarEtapa").is(':checked') ? 'T' : 'F';
                var chk = 'F';
                console.log(chk);
                var idEtapa = (chk == "T" ? $("#MtxtIdEtapaSiguiente").val() : $("#MtxtIdEtapaActual").val());
                var IdOp = $("#MtxtIdOportunidad").val();
                $.ajax({
                    type: 'POST',
                    url: 'BanOportunidad.aspx/ObtenerConfiguracionEtapa',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify({ idEtapa: idEtapa, IdOp: IdOp }),
                    success: function (result) {
                        var data = result.d;// $.parseJSON(result.d);
                        $("#DivAutogenerado").html('');
                        $.each(data, function (index, dt) {
                            console.log(chk);

                            generadorControles("#DivAutogenerado", (chk == 'T' ? '' : 'T'), dt.Modificable,
                                dt.IdConfiguracionoportunidadDetalle, dt.Obligatorio, dt.CodigoTipoControl, dt.MaxCaracter,
                                dt.ValorControl, dt.Etiqueta, dt.CodigoGeneral);
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
                //});

                //$("#MchkCambiarEtapa").trigger('change');


                $('#saveRegEtapa').click(function (e) {
                    $("#saveRegEtapa").prop("disabled", true);
                    e.preventDefault();
                    var mensaje = "";
                    var validateItems = true;
                    $('.requerid').each(function () {
                        $(this).parent().find('span').not(".multiselect-selected-text").remove();
                        console.log($(this).attr("minlength"));
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
                        $("#saveRegEtapa").prop("disabled", false);
                        mensaje += "Ingresar los campos obligatorios";
                        addnotify("notify", mensaje, "registeruser");
                    }
                    else {
                        $('#divError').attr('class', "alert fade");

                        var hModal = $("#myModal").height();

                        $.ajax({
                            type: 'POST',
                            url: urlPrin + '/InsertEtapa',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            data: JSON.stringify(getData()),
                            success: function (data) {
                                addnotify("notify", "La operación se realizó con éxito.", "registeruser");
                                debugger;
                                //var formdata = new FormData();
                                //var _image = $('#fuLogo')[0].files[0];
                                //formdata.append('file', _image);
                                //formdata.append('idOportunidad', $('#MtxtIdOportunidad').val());
                                //formdata.append('idEtapa', $('#MtxtIdEtapaActual').val());

                                //$.ajax({
                                //    type: "POST",
                                //    url: "fileUploader.ashx",
                                //    data: formdata,
                                //    async: false,
                                //    cache: false,
                                //    contentType: false,
                                //    processData: false,
                                //    success: function (result) { console.log(result); },
                                //    error: function (result) { console.log(result); }
                                //});
                                $(".controldinamicoFoto").each(function (e) {
                                    console.log(this);
                                    var formdataDim = new FormData();
                                    var _image = $(this)[0].files[0];
                                    formdataDim.append('file', _image);
                                    formdataDim.append('idOportunidad', data.d);
                                    formdataDim.append('idEtapa', $('#MtxtIdEtapaActual').val());
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


                                $('#myModal').modal('hide');
                                $('#buscar').trigger("click");

                            },
                            error: function (xhr, status, error) {
                                addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                            }
                        });

                    }
                });

                //$("#fuLogo").change(function () {
                //    SetearFoto(this);
                //});
            });

            function SetearFoto(input) {
                debugger;
                $('#hdNombre').val("");
                $('#imgPreview').attr('src', "");
                if (input.files && input.files[0]) {
                    var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
                    if (!allowedExtensions.exec(input.files[0].name)) {
                        alert("Solo se permiten imágenes de tipo Imagen");
                        $("#fuLogo").val("");
                    }
                    else {
                        if (input.files[0].size > $('#hdTamFoto').val()) {
                            alert("Tamaño de imagen superior al permitido");
                            $("#fuLogo").val("");
                        }
                        else {
                            var reader = new FileReader();

                            reader.onload = function (e) {
                                $('#imgPreview').attr('src', e.target.result);
                                $('#hdNombre').val(input.files[0].name);
                            }

                            reader.readAsDataURL(input.files[0]);
                        }
                    }
                }
            }


            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion

                var strData = new Object();
                strData.id = $('#MtxtIdOportunidad').val();
                strData.CambiaEtapa = ($('#MchkCambiarEtapa').is(':checked') ? 'T' : 'F');
                var controlDinam = "";
                $(".controldinamico").each(function () {
                    if ($(this).attr("typectrl") == '9') {
                        controlDinam += $(this).attr("idctrl") + ";" + $(this).attr("namePhoto") + '_' + $(this).attr("idctrl") + '_' + $('#hddIdUsuario').val() + "|";
                    } else {
                        controlDinam += $(this).attr("idctrl") + ";" + $(this).val() + "|";
                    }
                });
                strData.controldinamico = controlDinam;

                strData.accion = $('#MhAccion').val();

                return strData;
            }

            function clearCampos() {//funcion encargada de limpiar los input
                $('#MddlConfOpor').val('');
                $('#MtxtRazonSocial').val('');
                $('#MtxtRUC').val('');
                $('#MddlRubro').val('');
                $('#MddlRegion').val('');
                $('#MddlCanal').val('');
                $('#MtxtCliente').val('');

                $('#myModal').modal('hide');
                //$('#buscar').trigger("click");
                //window.location.reload(true);
            }
        </script>
    </form>
</body>
</html>

