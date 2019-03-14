<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZonasNew.aspx.cs" Inherits="Mantenimiento_Zonas_ZonasNew" %>

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
                                <asp:HiddenField ID="MtxtIdZona" runat="server" />
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
                strData.IdZona = $('#MtxtIdZona').val();
                strData.Codigo = $('#MtxtCodigo').val();
                strData.Nombre = $('#MtxtNombre').val();
                strData.accion = $('#MhAccion').val();
                return strData;
            }
            function clearCampos() {//funcion encargada de limpiar los input
                camClave = 0;
                $('#MtxtIdZona').val('');
                $('#MtxtCodigo').val('');
                $('#MtxtNombre').val('');
                $('#myModal').modal('hide');
            }
        </script>
    </form>
</body>
</html>
