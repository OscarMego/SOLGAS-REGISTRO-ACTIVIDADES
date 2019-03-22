<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuariosNew.aspx.cs" Inherits="Mantenimiento_Usuarios_UsuariosNew" %>

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
                                <asp:HiddenField ID="MtxtIdUsuario" runat="server" />
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCodigo">Codigo</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCodigo" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="50" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtNombres">Nombres</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtNombres" runat="server" class="requerid form-control" maxlength="80" />
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MtxtLoginUsuario">Login</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtLoginUsuario" runat="server" class="requerid form-control" maxlength="100" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="Mtxtclave">Clave</label>
                                    <input type="password" id="MtxtClave" runat="server" class="requerid form-control" maxlength="100" />
                                    <input type="hidden" id="hidClave" runat="server" />
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdPerfil">Perfil</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdPerfil" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-6 form-group" id="divNegocio">
                                    <label for="MddlIdCanal">Negocio</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdCanal" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-6 form-group" id="divVendedor" style="display: none">
                                    <label for="MddlVendedor" id="lblVendedor">Vendedor</label>
                                    <span style="color: #b94a48">*</span>
                                    <select id="MddlVendedor" multiple="multiple" class="form-control">
                                    </select>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtEmail">Correo Electrónico</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtEmail" runat="server" placeholder="Correo Electrónico" class="requerid form-control" maxlength="100" />
                                </div>

                                <div class="col-sm-6 form-group">
                                    <div class="checkbox">
                                        <input type="checkbox" class="requeridCtr" name="chkmodificable" value="notify" id="chkmodificable" checked="checked" runat="server" />
                                        <label for="chkmodificable">Validar Directorio Activo</label>
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
                if ($('#MtxtIdUsuario').val() != "") {
                    $("#MtxtClave").val($("#hidClave").val());
                }
                $("#MtxtNombres").on("keypress", function (e) {
                    return SoloAlfanumerico(e);
                });
                $("#MtxtLoginUsuario").on("keypress", function (e) {
                    return SoloAlfanumerico(e);
                });
                $("#MtxtClave").on("keypress", function (e) {
                    camClave = 1;
                });

                $("#divVendedor").hide();
                $("#MddlVendedor").removeClass("requerid");

                selectAllOption = false;
                cargaComboMulti('Usuarios.aspx/ComboMultVendedores', "#MddlVendedor", { idUsuario: $('#MtxtIdUsuario').val() });

                $("#MddlIdPerfil").change(function (e) {
                    ObtenerGrupo($(this).val());
                });
                ObtenerGrupo($("#MddlIdPerfil").val());
            });
            function ObtenerGrupo(perfil) {
                //cargaComboMulti("Usuarios.aspx" + '/ComboMultPerfilusuario', "#MddlVendedor", { usuario: $("#MtxtIdUsuario").val(), perfil: perfil });
                if (perfil == "5") {
                    $("#divNegocio").show();
                    $("#divVendedor").show();
                    $("#MddlVendedor").addClass("requerid");
                    $("#MddlIdCanal").addClass("requerid");
                } else if (perfil == "2" || perfil == "6") {
                    $("#divNegocio").hide();
                    $("#MddlIdCanal").removeClass("requerid");
                } else {
                    $("#divNegocio").show();
                    $("#divVendedor").hide();
                    $("#MddlVendedor").removeClass("requerid");
                    $("#MddlIdCanal").addClass("requerid");
                }
            }
            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion
                debugger
                var strData = new Object();
                strData.IdUsuario = $('#MtxtIdUsuario').val();
                strData.Codigo = $('#MtxtCodigo').val();
                strData.Nombres = $('#MtxtNombres').val();
                strData.LoginUsuario = $('#MtxtLoginUsuario').val();
                strData.Email = $('#MtxtEmail').val();
                strData.clave = $('#MtxtClave').val();
                strData.CamClave = (camClave == 1 ? 'T' : 'F');
                strData.IdPerfil = $('#MddlIdPerfil').val();
                strData.IdCanal = $('#MddlIdCanal').val() == '' ? '0' : $('#MddlIdCanal').val();
                strData.Vendedores = ValorComboMultSinAll('#MddlVendedor');
                strData.Modificable = ($('#chkmodificable').is(':checked') ? 'T' : 'F');
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
                $('#MddlIdPerfil').val('').trigger('change');
                $('#MddlIdCanal').val('').trigger('change');
                $('#myModal').modal('hide');
            }
        </script>
    </form>
</body>
</html>
