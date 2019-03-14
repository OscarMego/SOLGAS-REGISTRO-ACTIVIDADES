<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TipoActividadNew.aspx.cs" Inherits="Mantenimiento_TipoActividad_TipoActividadNew" %>

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
                                <asp:HiddenField ID="MtxtId" runat="server" />
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCodigo">Codigo</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCodigo" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="10" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtNombres">Nombre</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtNombre" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="80" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdNegocio">Negocio</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdNegocio" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtMeta">Meta</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtMeta" runat="server" onkeypress="return fc_PermiteNumeros(event,this);" class="requerid form-control" maxlength="80" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <div class="checkbox">
                                        <input type="checkbox" class="requeridCtr" name="MchkOportunidad" value="notify" id="MchkOportunidad" runat="server" />
                                        <label for="MchkOportunidad">Oportunidad</label>
                                    </div>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <div class="checkbox">
                                        <input type="checkbox" class="requeridCtr" name="MchkContacto" value="notify" id="MchkContacto" runat="server"/>
                                        <label for="MchkContacto">Contacto</label>
                                    </div>
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
                if ($('#MtxtCodigo').val() != "") {

                }
                $("#MtxtNombre").on("keypress", function (e) {
                    return SoloAlfanumerico(e);
                });
                selectAllOption = false;

            });

            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion

                var strData = new Object();
                strData.Id = $('#MtxtId').val();
                strData.codigo = $('#MtxtCodigo').val();
                strData.nombre = $('#MtxtNombre').val();
                strData.idnegocio = $('#MddlIdNegocio').val();
                strData.meta = $('#MtxtMeta').val();
                strData.oportunidad = ($('#MchkOportunidad').is(':checked') ? 'T' : 'F');
                strData.contacto = ($('#MchkContacto').is(':checked') ? 'T' : 'F');
                strData.accion = $('#MhAccion').val();
                return strData;
            }
            function clearCampos() {//funcion encargada de limpiar los input
                camClave = 0;
                $('#MtxtIdUsuario').val('');
                $('#MtxtCodigo').val('');
                $('#MtxtNombres').val('');
                $('#MtxtLoginUsuario').val('');
                $('#MtxtEmail').val('');
                $('#MtxtClave').val('');
                $('#MchkOportunidad').attr('checked', false);
                $('#MchkContacto').attr('checked', false);
                $('#MddlIdPerfil').val('').trigger('change');
                $('#MddlIdNegocio').val('').trigger('change');
                $('#myModal').modal('hide');
            }
        </script>
    </form>
</body>
</html>
