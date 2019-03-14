<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BanOportunidadLog.aspx.cs" Inherits="Mantenimiento_BanOportunidad_BanOportunidadLog" %>

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
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label for="MtxtCodigoOportunidad">Código Oportunidad</label>
                                <input type="text" id="MtxtCodigoOportunidad" runat="server" class=" form-control" disabled="disabled" maxlength="100" idval="0" />
                            </div>
                            <div class="col-sm-6 form-group">
                                <label for="MtxtCliente">Cliente</label>
                                <input type="text" id="MtxtCliente" runat="server" class=" form-control" disabled="disabled" maxlength="100" idval="0" />
                            </div>
                        </div>
                        <h4 class="modal-title" style="color: #0057a4">Lista de Ediciones</h4>
                        <div id="divGridView" class="tb-pc-modal" runat="server">
                            <div>
                                <asp:Literal runat="server" ID="litGrilla"></asp:Literal>
                            </div>
                        </div>
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
    </form>
</body>
</html>

