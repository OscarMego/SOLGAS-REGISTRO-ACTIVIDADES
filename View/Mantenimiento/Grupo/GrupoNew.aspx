<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GrupoNew.aspx.cs" Inherits="View.Mantenimiento.Grupo.GrupoNew" %>

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
                                <asp:HiddenField ID="hdIdGrupo" runat="server" />
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCodigo">Codigo</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCodigo" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="15" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtDescripcion">Nombre</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtDescripcion" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="50" />
                                </div>
                                <%--<div class="col-sm-3 form-group">
                                    <label for="Mddlnivel">Nivel</label>
                                    <asp:DropDownList ID="Mddlnivel" runat="server" CssClass="requerid form-control"></asp:DropDownList>
                                </div>--%>
                                
                                <div class="col-sm-6 form-group" id="divPadre">
                                    <label for="MddlPadre">Padre</label>
                                    <asp:DropDownList ID="MddlPadre" runat="server" CssClass="form-control"></asp:DropDownList>
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
            });

            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion
                debugger;

                var strData = new Object();

                strData.Id = $('#hdIdGrupo').val();
                strData.Codigo = $('#MtxtCodigo').val();
                strData.Nombre = $('#MtxtDescripcion').val();
                strData.Padre = $('#MddlPadre').val();

                strData.accion = $('#MhAccion').val();

                return strData;
            }

            function clearCampos() {//funcion encargada de limpiar los input
                $('#MtxtIdGrupo').val('');
                $('#MtxtCodigo').val('');
                $('#MtxtDescripcion').val('');
                $('#MddlPadre').val('').trigger("change");

                $('#myModal').modal('hide');
                //window.location.reload(true);
            }
        </script>
    </form>
</body>
</html>

