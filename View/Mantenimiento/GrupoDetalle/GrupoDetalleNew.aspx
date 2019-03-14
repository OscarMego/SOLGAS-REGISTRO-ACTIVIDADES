<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GrupoDetalleNew.aspx.cs" Inherits="Mantenimiento_GrupoDetalle_GrupoDetalleNew" %>

<!DOCTYPE html>
<html lang="es">
<head id="Head1" runat="server">
    <title></title>

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
                                <div class="col-sm-6 form-group">
                                    <asp:HiddenField ID="hdIdGrupoDetalle" runat="server" />
                                    <label for="MddlGrupo">Grupo </label> <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlGrupo" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCodigo">Código </label> 
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCodigo" class="requerid form-control" onkeypress="return SoloAlfanumerico(event);" maxlength="15" runat="server"/>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtNombre">Nombre</label> <span style="color: #b94a48">*</span>
                                    <input runat="server" type="text" id="MtxtNombre" maxlength="50" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtPadre">Padre</label>
                                    <input runat="server" type="text" id="MtxtPadre" disabled maxlength="50" class="form-control" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MddlPadre">Detalle Padre</label>
                                    <asp:DropDownList ID="MddlPadre" runat="server" class="form-control">
                                        <asp:ListItem Value="">.:SELECCIONE:.</asp:ListItem>
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
        
        
        <script type="text/javascript">

            $(document).ready(function () {
                if ($("#MtxtPadre").val().length>0) {
                    $("#MddlPadre").addClass("requerid");
                }
                $("#MtxtNombres #MtxtCodigo").on("keypress", function (e) {
                    return SoloAlfanumerico(e);
                });
                $("#MddlGrupo").change(function () {
                    var idGrupo = $(this).val();
                    $.ajax({
                        type: 'POST',
                        url: 'GrupoDetalleNew.aspx/ConsultaControlCombo',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        data: JSON.stringify({ IdGrupo: idGrupo, IdGrupoDetalle: $("#hdIdGrupoDetalle").val() }),
                        success: function (result) {
                            console.log(result);
                            $("#MtxtPadre").val(result.d.padre);
                            cargaItemsDSL(result.d, '#MddlPadre', 'SELECCIONE');
                            if (result.d.padre.length>0) {
                                $("#MddlPadre").addClass("requerid");
                            } else {
                                $("#MddlPadre").removeClass("requerid");
                            }
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", xhr.responseJSON.Message, "registeruser");
                        }
                    });
                });
                $("#MddlGrupo").trigger("change");
            });

            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion

                var strData = new Object();
                strData.Id = $('#hdIdGrupoDetalle').val();
                strData.Grupo = $('#MddlGrupo').val();
                strData.Codigo = $('#MtxtCodigo').val();
                strData.Nombre = $('#MtxtNombre').val();
                strData.Padre = $("#MddlPadre").val();
                strData.accion = $('#MhAccion').val();

                return strData;
            }

            function clearCampos() {//funcion encargada de limpiar los input
                $('#MtxtCodigo').val('');
                $('#MtxtNombre').val('');
                $('#MddlGrupo').val('').trigger('change');
                $('#MddlPadre').val('').trigger('change');
                $('#myModal').modal('hide');
            }
        </script>
    </form>
</body>
</html>
