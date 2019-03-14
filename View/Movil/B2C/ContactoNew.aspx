<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactoNew.aspx.cs" Inherits="View.Movil.B2C.ContactoNew" %>
<!DOCTYPE html>
<html lang="es">
<body>
    <form id="form1" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Contacto</h4>
                </div>
                <div class="modal-body">
                    <div class="container-modal">
                        <div class="form-group">
                            <label for="txtNombreC">Nombre</label>
                            <span style="color: #b94a48">*</span>
                            <input type="text" id="txtNombreC" runat="server" class="requerid form-control" maxlength="150" />
                        </div>
                        <div class="form-group">
                            <label for="txtTelefonoC">Telefono</label>
                            <span style="color: #b94a48">*</span>
                            <input type="text" id="txtTelefonoC" runat="server" class="requerid form-control" maxlength="80" />
                        </div>
                        <div class="form-group">
                            <label for="txtEmailC">Email</label>
                            <span style="color: #b94a48">*</span>
                            <input type="text" id="txtEmailC" runat="server" class="requerid form-control" maxlength="80" />
                        </div>
                        <div class="form-group">
                            <label for="txtCargoC">Cargo</label>
                            <span style="color: #b94a48">*</span>
                            <input type="text" id="txtCargoC" runat="server" class="requerid form-control" maxlength="80" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="container-modal">
                        <button type="button" class="btn btn-danger" id="saveRegC">Grabar</button>

                    </div>
                </div>
                <asp:HiddenField ID="MhAccion" runat="server" />
            </div>
        </div>
        <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
        <script type="text/javascript">

            $(document).ready(function () {
                addRegCon();
            });

            function getDataCon() {//funcion encargada de enviar los parametros para la insercion o edicion
                debugger;
                var strData = new Object();
                strData.NombreC = $('#txtNombreC').val();
                strData.TelefonoC = $('#txtTelefonoC').val();
                strData.EmailC = $('#txtEmailC').val();
                strData.CargoC = $('#txtCargoC').val();
                strData.idclienteC = $('#txtCliente').attr("idval");
                return strData;
            }
        </script>
    </form>
</body>
</html>

