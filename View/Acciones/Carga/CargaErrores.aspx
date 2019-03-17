<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CargaErrores.aspx.cs" Inherits="View.Acciones.Carga.CargaErrores" %>

<!DOCTYPE html>
<html lang="es">
<head id="Head1" runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="numerReg" runat="server" />
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title" id="modalLabel" runat="server"></h2>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div id="myModalContent" class="modal-body" style="height: 400px">
                    <div class="container-modal">
                        <span id="label2" runat="server"></span>
                        <br />
                        <div id="Div1" style="height: 350px" class="tb-pc-modal" runat="server">
                            <asp:GridView ID="grilla" runat="server" Width="100%" CssClass="grilla table"  />
                        </div>
                        <div class="alert fade" id="divError">
                            <strong id="tituloMensajeError"></strong>
                            <p id="mensajeError">
                            </p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="container-modal">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
