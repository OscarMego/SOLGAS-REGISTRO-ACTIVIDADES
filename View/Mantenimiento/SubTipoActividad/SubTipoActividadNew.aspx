<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubTipoActividadNew.aspx.cs" Inherits="Mantenimiento_SubTipoActividad_SubTipoActividadNew" %>

<!DOCTYPE html>

<html lang="es">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../js/multi-selected/dist/css/bootstrap-multiselect.css" rel="stylesheet" />
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
                                <asp:HiddenField ID="MtxtIdConfOp" runat="server" />
                                <div class="col-sm-3 form-group">
                                    <label for="MtxtCodigo">Codigo</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCodigo" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="15" />
                                </div>
                                <div class="col-sm-3 form-group">
                                    <label for="MtxtDescripcion">Descripcion</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtDescripcion" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="50" />
                                </div>
                                <div class="col-sm-3 form-group">
                                    <label for="MddlTipoActividad">Tipo de Actividad</label>
                                    <asp:DropDownList ID="MddlTipoActividad" runat="server" class="form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-3 form-group" id="MdivEtapaPredecesora">
                                    <label for="MddlIdEtapaPredecesora">Etapa Predecesora</label>
                                    <%--<select id="MddlIdEtapaPredecesora" class="form-control"></select>--%>
                                    <asp:DropDownList ID="MddlIdEtapaPredecesora" runat="server" CssClass="form-control"></asp:DropDownList>
                                    <%--<span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtEtapaPredecesora" runat="server" class="form-control" readonly />--%>
                                </div>
                                <div class="col-sm-3 form-group" id="MdivTiempoEtapa">
                                    <label for="MtxtTiempoEtapa">Tiempo en Etapa</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtTiempoEtapa" runat="server" onkeypress="return fc_PermiteNumeros(event,this);" class="form-control" maxlength="5" />
                                </div>
                            </div>
                            <div class="row">
                                <h4 id="H1" class="modal-title" style="color: #0057a4" runat="server">Controles de Actividad</h4>
                            </div>
                            <div class="row" id="divControles">
                                <asp:HiddenField runat="server" ID="hdidConfOpDe" />
                                <asp:HiddenField runat="server" ID="hdid" />
                                <asp:HiddenField runat="server" ID="hdIdFlagOportunidad" />
                                <asp:HiddenField runat="server" ID="hdIdSubTipoActividad" />
                                <div class="col-sm-3 form-group">
                                    <label for="MtxtEtiqueta">Etiqueta</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtEtiqueta" runat="server" onkeypress="return SoloAlfanumerico(event);" class=" form-control requeridCtr" maxlength="15" />
                                </div>
                                <div class="col-sm-3 form-group">
                                    <label for="MddlTipoControl">Tipo Control</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlTipoControl" runat="server" CssClass=" form-control requeridCtr"></asp:DropDownList>
                                </div>
                                <div id="divGrupo">
                                    <div class="col-sm-3 form-group">
                                        <label for="MddlGrupo" id="lblGeneral">Grupo</label>
                                        <span style="color: #b94a48">*</span>
                                        <asp:DropDownList ID="MddlGrupo" runat="server" CssClass=" form-control requeridCtr"></asp:DropDownList>
                                    </div>
                                    <div class="col-sm-3 form-group">
                                        <label for="MddlControlPadre">Control Padre</label>
                                        <span style="color: #b94a48">*</span>
                                        <select id="MddlControlPadre" class="form-control ">
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-3 form-group" id="divMaxCaracter">
                                    <label for="MtxtMaxCaracter">Max. Caracteres</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtMaxCaracter" onkeypress='fc_PermiteNumeros(event,this)' runat="server" class=" form-control requeridCtr" />
                                </div>
                                <div class="col-sm-3 form-group">
                                    <div class="checkbox">
                                        <input type="checkbox" class="requeridCtr" name="chkmodificable" value="notify" id="chkmodificable" checked="checked" />
                                        <label for="chkmodificable">Modificable</label>
                                    </div>
                                </div>
                                <div class="col-sm-3 form-group">
                                    <div class="checkbox">
                                        <input type="checkbox" class="requeridCtr" name="chkobligatorio" value="notify" id="chkobligatorio" checked="checked" />
                                        <label for="chkobligatorio">Obligatorio</label>
                                    </div>
                                </div>
                                 <div class="col-sm-3 form-group">
                                    <label for="ddlPerfil">Perfil</label>
                                    <span style="color: #b94a48">*</span>
                                    <select id="ddlPerfil" multiple="multiple" class="form-control ">
                                    </select>
                                </div>
                                <div class="col-sm-3 form-group" style="float: right">
                                    <br>
                                    <button type="button" id="idAgregar" class="btn btn-danger" onclick="Agregar_Click()" style="float: right">Agregar</button>
                                </div>
                            </div>
                            <div class="row">
                                <h4 class="modal-title" style="color: #0057a4" runat="server">Lista de Controles de Actividad</h4>
                            </div>
                            <div class="row">
                                <div class="tb-pc-modal" runat="server">
                                    <asp:Literal runat="server" ID="litGrillaEtapa"></asp:Literal>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="container-modal">
                        <button type="button" class="btn btn-danger" id="saveReg">Grabar</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>
                <asp:HiddenField ID="MhAccion" runat="server" />
            </div>
        </div>
        <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                cargaComboMulti('SubTipoActividadNew.aspx' + '/ComboMultPerfil', "#ddlPerfil");
                $("#MddlGrupo").change(function () {
                    var idGeneral = $(this).val();
                    cargaComboDSL('SubTipoActividadNew.aspx/ConsultaControlCombo', '#MddlControlPadre', 'SELECCIONE', {
                        ctrid: '', idSelec: '', idGeneral: idGeneral
                    });
                });
                $("#MddlTipoControl").change(function () {
                    var control = $(this).val();
                    if (control == 1 || control == 10 || control == 4 || control == 6) {
                        $("#MddlGrupo").removeClass("requeridCtr");
                        $("#MddlGrupo").val('').trigger("change");
                        $("#MddlControlPadre").val('').trigger("change");
                        $("#divGrupo").hide();
                        $("#MtxtMaxCaracter").addClass("requeridCtr");
                        $("#divMaxCaracter").show();
                    } else if (control == 9) {
                        $("#MddlGrupo").removeClass("requeridCtr");
                        $("#MddlGrupo").val('').trigger("change");
                        $("#MddlControlPadre").val('').trigger("change");
                        $("#divGrupo").hide();
                        $("#MtxtMaxCaracter").removeClass("requeridCtr");
                        $("#MtxtMaxCaracter").val('');
                        $("#divMaxCaracter").hide();
                    }
                    else if (control == 3) {
                        {
                            $("#MddlGrupo").addClass("requeridCtr");
                            $("#divGrupo").show();
                            $("#MtxtMaxCaracter").removeClass("requeridCtr");
                            $("#MtxtMaxCaracter").val('');
                            $("#MddlGrupo").val('').trigger("change");
                            $("#MddlControlPadre").val('').trigger("change");
                            $("#divMaxCaracter").hide();
                        }
                    } else if (control == '5') {
                        $("#MtxtMaxCaracter").val(10);
                        $("#MddlGrupo").removeClass("requeridCtr");
                        $("#divGrupo").hide();
                        $("#MtxtMaxCaracter").removeClass("requeridCtr");
                        $("#divMaxCaracter").hide();
                    }
                });
                $("#MddlTipoActividad").change(function () {
                    //$("#MtxtEtapaPredecesora").val('');
                    //$("#MtxtTiempoEtapa").val('');
                    //$("#hdIdTipoActividad").val('');
                    //$("#MddlIdEtapaPredecesora").val('').trigger('change');
                    $("#MddlIdEtapaPredecesora").find('option').remove();
                    var id = $('#MddlTipoActividad').val() == '' ? '0' : $('#MddlTipoActividad').val();
                    var input = { Id: id }
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: 'SubTipoActividadNew.aspx/ListarEtapaPredecesora',
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            $("#MddlIdEtapaPredecesora").append('<option value="0">.:SELECCIONE:.</option>');
                            $.each(data.d, function (key, registro) {
                                $("#MddlIdEtapaPredecesora").append('<option value=' + registro.IDSubTipoActividad + '>' + registro.Descripcion + '</option>');
                            });
                            ObternerListadoTipoActividadPredecesora();
                            //$("#MddlIdEtapaPredecesora").val('0').trigger('change');
                            ManejoControlesDiv();
                        },
                        error: function (data) {
                            alert('error');
                        }
                    });
                    
                });
                $("#MddlTipoControl").change();
                $("#MddlTipoActividad").change();
                //cargaComboMulti('ConfOportunidadesNew.aspx' + '/ComboMultPerfil', "#ddlPerfil");
                $("#Table1").on("click", ".delItemRegCtr", function () {
                    var codigo = $('#MtxtCodigo').val();
                    var index = $(this).attr("cod");
                    var input = { Codigo: codigo, index: index }
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: "SubTipoActividadNew.aspx/EliminarDetalle",
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            //addnotify("notify", "La operación se realizó con éxito.");
                            $("#Table1").find("tbody>tr").remove();
                            $("#Table1").find("tbody").append(data.d);
                            $('#hdid').val("");
                            $('#hdidConfOpDe').val("");
                            clearCamposCtr();
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                        }
                    });
                });
                $("#Table1").on("click", ".editItemReg2", function () {
                    var codigo = $('#MtxtCodigo').val();
                    var index = $(this).attr("cod");
                    var input = { Codigo: codigo, Index: index }
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: "SubTipoActividadNew.aspx/EditarDetalle",
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            //addnotify("notify", "La operación se realizó con éxito.");
                            EditarSucces(data);
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                        }
                    });
                });
            });
            function Agregar_Click() {
                var IControlPadre = $('#MddlControlPadre').val();
                var index = $('#hdid').val();
                var idConfOpDe = $('#hdidConfOpDe').val();
                var idConfOp = $('#MtxtIdConfOp').val();
                var Etiqueta = $('#MtxtEtiqueta').val();
                var IdTipoControl = $('#MddlTipoControl').val();
                var CodigoGrupo = (IdTipoControl == '3' ? $('#MddlGrupo').val() : '');
                var MaxCaracter = (IdTipoControl != '3' ? $('#MtxtMaxCaracter').val() : '');
                var Modificable = ($('#chkmodificable').is(':checked') ? 'T' : 'F');
                var Obligatorio = ($('#chkobligatorio').is(':checked') ? 'T' : 'F');
                var Perfiles = ValorComboMultSinAll('#ddlPerfil');
                var input = {
                    idConfOp: idConfOp,
                    index: index, idConfOpDe: idConfOpDe, Etiqueta: Etiqueta,
                    IdTipoControl: IdTipoControl, CodigoGrupo: CodigoGrupo,
                    MaxCaracter: MaxCaracter, Modificable: Modificable,
                    Obligatorio: Obligatorio,
                    Perfiles: Perfiles,
                    IControlPadre: IControlPadre
                }

                var mensaje = "";
                var validateItems = true;
                $('#divControles').find('.requeridCtr').each(function () {
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

                if (validateItems) {
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: "SubTipoActividadNew.aspx/AgregarDetalleEtapa",
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            $("#Table1").find("tbody>tr").remove();
                            $("#Table1").find("tbody").append(data.d);
                            $('#hdid').val("");

                            //cargaComboDSL('ConfOportunidadesNew.aspx/ConsultaControlCombo', '#MddlControlPadre', 'SELECCIONE', {
                            //  ctrid: '', idSelec: '', IdGrupo: $('#MddlGeneral').val()
                            //});
                            clearCamposCtr();
                            addnotify("notify", "La operación se realizó con éxito.");
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message);
                        }
                    });
                    clearCamposCtr();
                } else {
                    addnotify("notify", "Complete los Datos a Ingresar");
                }
            }

            function ObternerListadoTipoActividadPredecesora() {
                var id = $('#MddlTipoActividad').val() == '' ? '0' : $('#MddlTipoActividad').val();
                var input = { Id: id }
                param = JSON.stringify(input);
                $.ajax({
                    type: "POST",
                    url: "SubTipoActividadNew.aspx/ObtenerEstadoOportunidad",
                    data: param,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //addnotify("notify", "La operación se realizó con éxito.");
                        ObtenerTipoActividadOportunidad(data);
                    },
                    error: function (xhr, status, error) {
                        addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                    }
                });
            }

            function ObtenerTipoActividadOportunidad(data) {
                $("#hdIdFlagOportunidad").val(data.d.oportunidad);
                var flagOportunidad = $("#hdIdFlagOportunidad").val();
                if (flagOportunidad == 'T') {
                    //$("#MdivEtapaPredecesora").show();
                    //$("#MdivTiempoEtapa").show();

                    var id = $("#MddlTipoActividad").val();
                    var input = { Id: id }
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: "SubTipoActividadNew.aspx/ObtenerEtapaPredecesora",
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            //addnotify("notify", "La operación se realizó con éxito.");
                            ObtenerSubTipoActividadPredecesora(data);
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                        }
                    });

                    //$("#MtxtIdEtapaPredecesora").addClass("requerid");
                    //$("#MtxtTiempoEtapa").addClass("requerid");

                    //$("#MdivEtapaPredecesora").show();
                    //$("#MdivTiempoEtapa").show();
                    //$("#MtxtTiempoEtapa").addClass("requerid");

                } else {
                    $("#MdivEtapaPredecesora").hide();
                    $("#MdivTiempoEtapa").hide();
                    //$("#MtxtEtapaPredecesora").val('');
                    $("#MddlIdEtapaPredecesora").val('').trigger('change');
                    $("#MtxtTiempoEtapa").val('');
                    //$("#hdIdTipoActividad").val('');
                    //$("#MtxtIdEtapaPredecesora").removeClass("requerid");
                    $("#MtxtTiempoEtapa").removeClass("requerid");
                }
            }


            function ObtenerSubTipoActividadPredecesora(data) {
                var vIdEtapaPredecesora = data.d == null ? 0 : data.d.IDSubTipoActividad
                //$("#MddlIdEtapaPredecesora").val(data.d== null ? '0' : data.d.IDSubTipoActividad);
                //$("#hdIdTipoActividad").val(data.d.IDSubTipoActividad);
                //$("#MtxtEtapaPredecesora").val(data.d.Descripcion);
                //var descripcion = $('#MddlIdEtapaPredecesora').val() == null ? 0 : $('#MddlIdEtapaPredecesora').val();
                console.log(vIdEtapaPredecesora);
                if ((vIdEtapaPredecesora != 0)) {
                    $("#MdivEtapaPredecesora").show();
                    $("#MdivTiempoEtapa").show();
                    $("#MtxtTiempoEtapa").addClass("requerid");

                    var vIdSubTipoActividad = $("#hdIdSubTipoActividad").val() == '' ? '0' : $('#hdIdSubTipoActividad').val();
                    var vId = $('#MddlTipoActividad').val() == '' ? '0' : $('#MddlTipoActividad').val();
                    var input = { Id: vId }
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: 'SubTipoActividadNew.aspx/ListarEtapaPredecesoraAsignados',
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            $.each(data.d, function (key, registro) {
                                if ((registro.IdSubTipoActividadPredecesora != 0) && (registro.IdSubTipoActividadPredecesora != vIdSubTipoActividad)) {
                                    $("#MddlIdEtapaPredecesora option[value='" + registro.IdSubTipoActividadPredecesora + "']").remove(); //removes the option with value = 2
                                    $('#MddlIdEtapaPredecesora').val('').trigger('chosen:updated');
                                }
                            });
                            ManejoControlesDiv();
                        },
                        error: function (data) {
                            alert('error');
                        }
                    });
                }
                else {
                    $("#MdivEtapaPredecesora").hide();
                    $("#MdivTiempoEtapa").hide();
                    //$("#MtxtEtapaPredecesora").val('');
                    $("#MtxtTiempoEtapa").val('');
                    $("#MddlIdEtapaPredecesora").val('').trigger('change');
                    //$("#hdIdTipoActividad").val('');
                    $("#MtxtTiempoEtapa").removeClass("requerid");

                }

            }

            function ManejoControlesDiv() {
                var vIdSubTipoActividad = $("#hdIdSubTipoActividad").val() == '' ? '0' : $('#hdIdSubTipoActividad').val();
                //console.log(vIdSubTipoActividad);

                if ((vIdSubTipoActividad != '') || (vIdSubTipoActividad != '0')) {
                    $("#MddlIdEtapaPredecesora").val(vIdSubTipoActividad).trigger('change');
                }
                else {
                    $("#MddlIdEtapaPredecesora").val('0').trigger('change');
                }
            }

            function EditarSucces(data) {
                $('#hdid').val(data.d.Index);
                $('#hdidConfOpDe').val(data.d.IdConfiguracionoportunidadDetalle);
                $('#MtxtEtiqueta').val(data.d.Etiqueta);
                $('#MddlTipoControl').val(data.d.CodigoTipoControl).change();
                $('#MddlGrupo').val(data.d.CodigoGeneral);
                $('#MtxtMaxCaracter').val(data.d.MaxCaracter);
                $('#MddlControlPadre').val(data.d.IdConfigOportunidadDetPadre).trigger("change");
                var perfiles = data.d.Perfiles.split(',');
                //Descheck
                $("#ddlPerfil").next().find("[type=checkbox]").each(function () {
                    $(this).prop("checked", false);
                    $(this).trigger("change");
                });
                //Check
                var dato;
                $("#ddlPerfil option").each(function () {
                     var vperfil = $(this).val();
                     var dato = perfiles.find(function (element) {                         
                         return element == vperfil; 
                     });
                     if (typeof dato != "undefined") { 
                         $("#ddlPerfil").next().find("[type=checkbox][value=" + dato + "]").each(function () {
                             $(this).prop("checked", true);
                             $(this).trigger("change");
                         }); 
                     }
                 });

                if (data.d.Modificable == "T") {
                    $("#chkmodificable").prop("checked", true);
                } else {
                    $("#chkmodificable").prop("checked", false);
                }
                if (data.d.Obligatorio == "T") {
                    $("#chkobligatorio").prop("checked", true);
                } else {
                    $("#chkobligatorio").prop("checked", false);
                }
            }
            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion
                var strData = new Object();
                strData.Id = $('#MtxtIdConfOp').val();
                strData.Codigo = $('#MtxtCodigo').val();
                strData.Descripcion = $('#MtxtDescripcion').val();
                strData.TipoActividad = $('#MddlTipoActividad').val();
                strData.accion = $('#MhAccion').val();
                strData.IdSubTipoActividadPredecesora = $('#MddlIdEtapaPredecesora').val() == '' ? '0' : $('#MddlIdEtapaPredecesora').val();
                strData.MetaDiaria = $('#MtxtTiempoEtapa').val() == '' ? '0' : $('#MtxtTiempoEtapa').val();
                return strData;
            }

            function clearCampos() {//funcion encargada de limpiar los input
                //$('#MtxtIdEtapa').val('');
                //$('#MtxtCodigo').val('');
                //$('#MtxtDescripcion').val('');
                //$('#MtxtTiempoEtapa').val('');
                //$('#MddlIdEtapaPredecesora').val('').trigger('change');

                $('#MtxtIdConfOp').val('');
                //$('#MddlTipoActividad').val('').trigger('change');

                $('#myModal').modal('hide');
                //window.location.reload(true);
            }
            function clearCamposCtr() {//funcion encargada de limpiar los input
                //$('#MtxtIdEtapa').val('');
                //$('#MtxtCodigo').val('');
                //$('#MtxtDescripcion').val('');
                //$('#MtxtTiempoEtapa').val('');
                //$('#MddlIdEtapaPredecesora').val('').trigger('change');

                $('#hdid').val('');
                $('#hdidConfOpDe').val('');
                $('#MtxtEtiqueta').val('');
                $('#MddlControlPadre').val('').trigger('change');
                $('#MddlTipoControl').val('').trigger('change');
                $('#MddlGrupo').val('').trigger('change');
                $('#MtxtMaxCaracter').val('');
                $("#chkmodificable").prop("checked", true);
                $("#chkobligatorio").prop("checked", true);
                $('#MddlControlPadre').val('').trigger('change');
                //window.location.reload(true);
            }
        </script>
    </form>
</body>
</html>

