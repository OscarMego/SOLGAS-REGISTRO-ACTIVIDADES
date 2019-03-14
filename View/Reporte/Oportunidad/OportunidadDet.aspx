<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OportunidadDet.aspx.cs" Inherits="Reporte_Oportunidad_OportunidadDet" %>

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
                                <asp:HiddenField ID="MtxtIdOportunidad" runat="server" />
                                
                                <div class="tb-pc-modal" runat="server">
                                    <asp:Literal runat="server" ID="litGrillaDetalle"></asp:Literal>
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
                selectDefault = false;

                $(".infoItemReg").click(function (e) {

                    var codigo = $(this).attr("cod");
                    var ent = $.parseJSON(codigo);
                    console.log(ent);
                    $.ajax({
                        type: 'POST',
                        url: 'BanOportunidad.aspx/ObtenerConfiguracionEtapa',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        data: JSON.stringify(ent),
                        success: function (result) {
                            var data = result.d;// $.parseJSON(result.d);
                            $("#DivAutogenerado").html('');
                            $.each(data, function (index, dt) {

                                generadorControles("#DivAutogenerado", "T", "F",
                                    index, "F", "1", dt.MaxCaracter,
                                    dt.ValorControl, dt.Etiqueta, dt.CodigoGeneral);
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

