<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeneralNew.aspx.cs" Inherits="Mantenimiento_General_GeneralNew" %>

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
                                <asp:HiddenField ID="MtxtIdGeneral" runat="server" />
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCodigo">Codigo</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCodigo" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="10" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtNombre">Nombre</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtNombre" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="80" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdTipo">Id Tipo</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdTipo" runat="server" class="requerid form-control">
                                        <asp:ListItem Value="0" Selected="True">.: Seleccione un Item :.</asp:ListItem>
                                        <asp:ListItem Value="1">RUBRO</asp:ListItem>
                                        <asp:ListItem Value="2">REGION</asp:ListItem>
                                        <asp:ListItem Value="3">ORGANIZACION VENTA</asp:ListItem>
                                        <asp:ListItem Value="4">CANAL</asp:ListItem>
                                    </asp:DropDownList>
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
            var camClave = 0;
            $(document).ready(function () {
                $("#MtxtCodigo").on("keypress", function (e) {
                    return SoloAlfanumerico(e);
                });
                $("#MtxtNombre").on("keypress", function (e) {
                    return SoloAlfanumerico(e);
                });
            });
            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion
                var strData = new Object();
                strData.IdGeneral = $('#MtxtIdGeneral').val();
                strData.Codigo = $('#MtxtCodigo').val();
                strData.Nombre = $('#MtxtNombre').val();
                strData.IdTipo = $('#MddlIdTipo').val();
                strData.accion = $('#MhAccion').val();
                return strData;
            }
            function clearCampos() {//funcion encargada de limpiar los input
                camClave = 0;
                $('#MtxtIdZona').val('');
                $('#MtxtCodigo').val('');
                $('#MtxtNombre').val('');
                $('#MddlIdTipo').val('').trigger('change');
                $('#myModal').modal('hide');
            }
        </script>
    </form>
</body>
</html>
