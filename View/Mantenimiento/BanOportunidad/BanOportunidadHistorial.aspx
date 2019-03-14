<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BanOportunidadHistorial.aspx.cs" Inherits="Mantenimiento_BanOportunidad_BanOportunidadHistorial" %>

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
                            <asp:HiddenField ID="MtxtIdOportunidad" runat="server" />
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCodigo">Codigo Oportunidad</label>
                                    <input type="text" id="MtxtCodigo" disabled runat="server" class="form-control" maxlength="100" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCliente">Cliente</label>
                                    <input type="text" id="MtxtCliente" disabled runat="server" class="form-control" maxlength="100" />
                                </div>
                            </div>
                            <div class="row">
                                <h4 id="H2" class="modal-title" style="color: #0057a4" runat="server">Lista de Etapas</h4>
                            </div>
                            <div class="row">
                                <div class="tb-pc-modal" runat="server">
                                    <asp:Literal runat="server" ID="litGrillaHistorial"></asp:Literal>
                                </div>
                            </div>
                            <div class="row">
                                <h4 id="H1" class="modal-title" style="color: #0057a4" runat="server">Informacion de Etapas</h4>
                            </div>
                            <div class="row" id="DivAutogenerado" runat="server">
                            </div>
                            <div class="row" style="display:none">
                                <div class="col-sm-6 form-group">
                                    <div class="col-sm-12 form-group">
                                        <img id="foto" runat="server" style="width: 100%; height: 200px;" src="../../imagery/all/layout/noimg.jpg" />
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <button type="button" class="btn btn-default btnDescarga" disabled>Descargar</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="modal-footer">
                    <div class="container-modal">
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
                //$('#Table1').cardtable();
                selectDefault = false;

                $(".infoItemReg").click(function (e) {
                    debugger
                    var codigo = $(this).attr("cod");
                    var ent = $.parseJSON(codigo);
                    console.log(ent);
                    $.ajax({
                        type: 'POST',
                        url: 'BanOportunidad.aspx/ObtenerConfiguracionEtapaHistorial',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        data: JSON.stringify(ent),
                        success: function (result) {
                            var data = result.d;// $.parseJSON(result.d);
                            $("#DivAutogenerado").html('');
                            console.log(data);
                             $.each(data, function (index, dt) {
                                generadorControles("#DivAutogenerado", "T", "F",
                                    index, "F", (dt.CodigoTipoControl=='9'?'9IMG':"1"), dt.MaxCaracter,
                                    dt.txtcontrol, dt.Etiqueta, dt.CodigoGeneral);
                                if (dt.CodigoTipoControl == '9') {
                                    $.ajax({
                                        type: 'POST',
                                        url: 'BanOportunidadHistorial.aspx/verFoto',
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        async: true,
                                        cache: false,
                                        data: JSON.stringify(ent),
                                        success: function (result) {
                                            if (result.d == "OK") {
                                                $("#MFl" + index).parent().next().find(".btnDescarga")
                                                $("#MFl" + index).attr("src", "../../foto/imagen.aspx?item=0&idEtapa=" + ent.idEtapa + "id=" + jQuery.guid++);
                                                $("#MFl" + index).parent().next().find(".btnDescarga").removeAttr("disabled");
                                                $("#MFl" + index).parent().next().find(".btnDescarga").click(function (e) {
                                                    window.location.href = "../../Reporte/ExportaFotos.aspx" + '?MOD=DES_FOTOS';
                                                });
                                            } else {
                                                $("#MFl" + index).attr("src", "../../imagery/all/layout/noimg.jpg");
                                                $("#MFl" + index).parent().next().find(".btnDescarga").attr("disabled", "disabled");
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            alert(error);
                                        }
                                    });
                                }
                            });

                        },
                        error: function (xhr, status, error) {
                            alert(error);
                        }
                    });
                });

            });
            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion

                var strData = new Object();
                strData.id = $('#MtxtIdOportunidad').val();
                strData.CambiaEtapa = ($('#MchkCambiarEtapa').is(':checked') ? 'T' : 'F');
                var controlDinam = "";
                $(".controldinamico").each(function () {
                    //console.log($(this).attr("idctrl"), $(this).attr("typeCtrl"));
                    controlDinam += $(this).attr("idctrl") + ";" + $(this).val() + "|";
                });
                strData.controldinamico = controlDinam;

                strData.accion = $('#MhAccion').val();

                return strData;
            }

        </script>
    </form>
</body>
</html>

