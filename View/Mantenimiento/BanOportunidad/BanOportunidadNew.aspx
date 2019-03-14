<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BanOportunidadNew.aspx.cs" Inherits="Mantenimiento_BanOportunidad_BanOportunidadNew" %>

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
                                <div class="row">
                                    <asp:HiddenField ID="hdinamicocontrol" runat="server" />
                                    <asp:HiddenField ID="MtxtIdOportunidad" runat="server" />
                                    <div class="col-sm-6 form-group">
                                        <label for="MddlConfOpor">Configuracion Oportunidad</label>
                                        <asp:DropDownList ID="MddlConfOpor" runat="server" class="requerid form-control"></asp:DropDownList>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label for="MddlResponsable">Vendedor</label>
                                        <span style="color: #b94a48">*</span>
                                        <asp:DropDownList ID="MddlResponsable" runat="server" class="requerid form-control"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row" id="divClienteExiste">
                                    <div class="col-sm-6 form-group">
                                        <label for="MtxtCliente">Cliente</label>
                                        <span style="color: #b94a48">*</span>
                                        <input type="text" id="MtxtCliente" runat="server" class="requerid form-control" maxlength="100" idval="0" />
                                    </div>
                                </div>

                                <div class="row" id="DivAutogenerado" runat="server">
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
        <script src="../../js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
        <script type="text/javascript">

            $(document).ready(function () {
                selectDefault = false;
                $("#MtxtCliente").addClass("requerid");
                $("#MddlConfOpor").change(function (e) {
                    var codigoConf = $(this).val();
                    var IdOp = $("#MtxtIdOportunidad").val();
                    $.ajax({
                        type: 'POST',
                        url: 'BanOportunidadNew.aspx/ObtenerConfiguracion',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        data: JSON.stringify({ CodigoConf: codigoConf, IdOp: IdOp }),
                        success: function (result) {
                            debugger
                            var data = result.d;// $.parseJSON(result.d);
                            $("#DivAutogenerado").html('');
                            $.each(data, function (index, dt) {
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

                $('#MtxtCliente').autocomplete({
                    serviceUrl: '../../Mantenimiento/BanOportunidad/FillCliente.ashx',
                    onSelect: function (suggestion) {
                        //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
                        $(this).attr("idval", suggestion.data);
                    },
                    onSearchStart: function (params) {
                        $(this).attr("idval", "");
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

                if ($('#MtxtIdOportunidad').val() != "") {
                    $("#MddlConfOpor").trigger('change');
                }

            });
            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion
                var strData = new Object();
                strData.id = $('#MtxtIdOportunidad').val();
                strData.ConfOpor = $('#MddlConfOpor').val();
                strData.Responsable = $('#MddlResponsable').val();
                strData.CodCliente = $('#MtxtCliente').attr("idval");
                var controlDinam = "";
                $(".controldinamico").each(function () {
                    controlDinam += $(this).attr("idctrl") + ";" + $(this).val() + "|";
                });
                strData.controldinamico = controlDinam;
                strData.accion = $('#MhAccion').val();
                return strData;
            }

            function clearCampos() {//funcion encargada de limpiar los input
                $('#MddlConfOpor').val('');
                $('#MtxtCliente').val('');
                $('#myModal').modal('hide');
                //window.location.reload(true);
            }
        </script>
    </form>
</body>
</html>

