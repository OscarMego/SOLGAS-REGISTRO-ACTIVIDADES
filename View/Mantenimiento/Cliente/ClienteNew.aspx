<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClienteNew.aspx.cs" Inherits="View.Mantenimiento.Cliente.ClienteNew" %>

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
                                <asp:HiddenField ID="hdIdCliente" runat="server" />
                                <div class="col-sm-6 form-group" id="divId" runat="server">
                                    <label for="MtxtIdCliente">Id</label>
                                    <input type="text" id="MtxtIdCliente" disabled runat="server" class="form-control" maxlength="100" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtRazonSocial">Razón Social</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtRazonSocial" runat="server"  class="requerid form-control" maxlength="50" />
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MtxtRUC">RUC</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtRUC" runat="server" onkeypress="return fc_PermiteNumeros(event,this);" class="requerid form-control" maxlength="11" />
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MtxtDireccion">Dirección</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtDireccion" runat="server"  class="requerid form-control" maxlength="200" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtReferencia">Referencia</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtReferencia" runat="server"  class="requerid form-control" maxlength="200" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdNegocio">Negocio</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdNegocio" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdRubro">Rubro</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdRubro" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdRegion">Region</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdRegion" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdOrganizacionVenta">Organización Venta</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdOrganizacionVenta" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdCanal">Canal</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdCanal" runat="server" class="requerid form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdTipo">Tipo</label>
                                    <span style="color: #b94a48">*</span>
                                    <%--<select class="requerid form-control">
                                        <option value="-1">Seleccione...</option>
                                        <option value="1">Cliente Solgas</option>
                                        <option value="2">Cliente Potencial</option>
                                    </select>--%>
                                    <asp:DropDownList ID="MddlIdTipo" runat="server" class="requerid form-control">
                                        <asp:ListItem Value="0" Selected="True">Seleccione...</asp:ListItem>
                                        <asp:ListItem Value="1">Cliente Solgas</asp:ListItem>
                                        <asp:ListItem Value="2">Cliente Potencial</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row">
                                <h4 id="H1" class="modal-title" style="color: #0057a4" runat="server">Instalaciones</h4>
                            </div>
                            <div class="row" id="divControles">
                                <asp:HiddenField runat="server" ID="hdid" />

                                <div class="col-sm-3 form-group">
                                    <label for="MtxtCodInstalacion">Código Instalación</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCodInstalacion" runat="server" onkeypress="return SoloAlfanumerico(event);" class=" form-control requeridCtr" maxlength="15" />
                                </div>
                                <div class="col-sm-3 form-group">
                                    <label for="MddlIdZona">Zona</label>
                                    <span style="color: #b94a48">*</span>
                                    <%--<select id="MddlIdZona" multiple="multiple" class="requerid form-control"></select>--%>
                                    <asp:DropDownList ID="MddlIdZona" runat="server" class="requeridCtr form-control"></asp:DropDownList>
                                </div>

                                <div class="col-sm-3 form-group">
                                    <label for="MtxtDescripcion">Descripción</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtDescripcion" onkeypress='fc_PermiteNumeros(event,this)' runat="server" class=" form-control requeridCtr" />
                                </div>
                                <div class="col-sm-3 form-group">
                                    <label for="MtxtDireccionI">Dirección</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtDireccionI" onkeypress='fc_PermiteNumeros(event,this)' runat="server" class=" form-control requeridCtr" />
                                </div>
                                <div class="col-sm-3 form-group">
                                    <label for="MtxtReferenciaI">Referencia</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtReferenciaI" onkeypress='fc_PermiteNumeros(event,this)' runat="server" class=" form-control requeridCtr" />
                                </div>
                                <div class="col-sm-3 form-group">
                                    <label for="MddlIdUsuario">Usuario</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdUsuario" runat="server" class="requeridCtr form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-3 form-group">
                                    <div class="checkbox">
                                        <input type="checkbox" class="requeridCtr" name="chkHabilitadoI" value="notify" id="chkHabilitadoI" checked="checked" />
                                        <label for="chkHabilitadoI">Habilitado</label>
                                    </div>
                                </div>
                                <div class="col-sm-3 form-group" style="float: right">
                                    <br>
                                    <button type="button" id="idAgregar" class="btn btn-danger" onclick="Agregar_Click()" style="float: right">Agregar</button>
                                </div>

                            </div>
                            <div class="row">
                                <h4 class="modal-title" style="color: #0057a4" runat="server">Lista de Instalaciones</h4>
                            </div>
                            <div class="row">
                                <div class="tb-pc-modal" runat="server">
                                    <asp:Literal runat="server" ID="litGrillaInstalacion"></asp:Literal>
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
            var inicia = 1;
            $(document).ready(function () {
                //cargaComboMulti(urlPrin + '/ComboMultCliente', "#MddlIdZona", { idCliente: $('#hdIdCliente').val() });
                $("#Table1").on("click", ".delItemRegCtr", function () {
                    var codigo = $('#MtxtCodInstalacion').val();
                    var index = $(this).attr("cod");
                    var input = { Codigo: codigo, index: index }
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: "ClienteNew.aspx/EliminarInstalacion",
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            //addnotify("notify", "La operación se realizó con éxito.");
                            $("#Table1").find("tbody>tr").remove();
                            $("#Table1").find("tbody").append(data.d);
                            $('#hdid').val("");
                            $('#hdidConfOpDe').val("");
                            clearCamposCtr();
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                        }
                    });
                });
                $("#Table1").on("click", ".editItemReg2", function () {
                    var codigo = $('#MtxtCodInstalacion').val();
                    var index = $(this).attr("cod");
                    var input = { Codigo: codigo, Index: index }
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: "ClienteNew.aspx/EditarInstalacion",
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            EditarSucces(data);
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                        }
                    });
                });
            });
            function EditarSucces(data) {
                $('#hdid').val(data.d.Index);
                $('#hdIdCliente').val(data.d.IDCliente);
                $('#MddlIdZona').val(data.d.IDZona).change();
                $('#MddlIdUsuario').val(data.d.IDUsuario).change();
                $('#MtxtCodInstalacion').val(data.d.CodInstalacion);
                $('#MtxtDescripcion').val(data.d.Descripcion);
                $('#MtxtDireccionI').val(data.d.Direccion);
                $('#MtxtReferenciaI').val(data.d.Referencia);
               // $('#MtxtDireccion').val(data.d.Direccion);
            }
            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion
                debugger
                var strData = new Object();
                strData.CLI_PK = $('#hdIdCliente').val();
                strData.Razon_Social = $('#MtxtRazonSocial').val();
                strData.RUC = $('#MtxtRUC').val();
                strData.Direccion = $('#MtxtDireccion').val();
                strData.Referencia = $('#MtxtReferencia').val();
                strData.IdNegocio = $('#MddlIdNegocio').val();
                strData.IdRubro = $('#MddlIdRubro').val();//1;
                strData.IdRegion = $('#MddlIdRegion').val();//1;
                strData.IdOrganizacionVenta = $('#MddlIdOrganizacionVenta').val();//1;
                strData.IdCanal = $('#MddlIdCanal').val();//1; 
                strData.IdTipo = $('#MddlIdTipo').val();
                var inicia = 0;
                return strData;
            }

            function clearCampos() {//funcion encargada de limpiar los input
                $('#hdIdCliente').val('');
                $('#MtxtrazonSocial').val('');
                $('#MtxtRuc').val('');
                $('#MtxtDireccion').val('');
                $('#MtxtReferencia').val('');
                $('#MddlIdNegocio').val('').trigger('change');
                $('#MddlIdRubro').val('').trigger('change');
                $('#MddlIdRegion').val('').trigger('change');
                $('#MddlIdOrganizacionVenta').val('').trigger('change');
                $('#MddlIdCanal').val('').trigger('change');
                $('#MddlIdTipo').val('').trigger('change');
                //$('#MddlZona').val('').trigger('change');
                $('#myModal').modal('hide');
            }

            function Agregar_Click() {
                debugger;
                var index = $('#hdid').val();
                var IdCliente = $('#hdIdCliente').val();
                var MtxtCodInstalacion = $('#MtxtCodInstalacion').val();
                var MddlIdZona = $('#MddlIdZona').val();
                var MddlNombreZona = $('#MddlIdZona  option:selected').text();
                var MddlIdUsuario = $('#MddlIdUsuario').val();
                var MddlNombreUsuario = $('#MddlIdUsuario  option:selected').text();
                var MtxtDescripcion = $('#MtxtDescripcion').val();
                var MtxtDireccionI = $('#MtxtDireccionI').val();
                var MtxtReferenciaI = $('#MtxtReferenciaI').val();
                var chkHabilitadoI = ($('#chkHabilitadoI').is(':checked') ? 'T' : 'F');

                var validateItems = true;

                if (MtxtCodInstalacion == '') {
                    validateItems = false;
                }
                if (MddlIdZona == '') {
                    validateItems = false;
                }
                if (MtxtDescripcion == '') {
                    validateItems = false;
                }
                if (MtxtDireccionI == '') {
                    validateItems = false;
                }
                if (MtxtReferenciaI == '') {
                    validateItems = false;
                }
                if (chkHabilitadoI == '') {
                    validateItems = false;
                }

                var input = {
                    index: index,
                    IdCliente: IdCliente,
                    codInstalacion: MtxtCodInstalacion,
                    idZona: MddlIdZona,
                    nombreZona: MddlNombreZona,
                    Descripcion: MtxtDescripcion,
                    Direccion: MtxtDireccionI,
                    Referencia: MtxtReferenciaI,
                    Habilitado: chkHabilitadoI,
                    IdUsuario: MddlIdUsuario,
                    nombreUsuario: MddlNombreUsuario
                }
                if (validateItems) {
                    param = JSON.stringify(input);
                    $.ajax({
                        type: "POST",
                        url: "ClienteNew.aspx/AgregarInstalacion",
                        data: param,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            $("#Table1").find("tbody>tr").remove();
                            $("#Table1").find("tbody").append(data.d);
                            $('#hdid').val("");

                            //cargaComboDSL('ConfOportunidadesNew.aspx/ConsultaControlCombo', '#MddlControlPadre', 'SELECCIONE', {
                            //  ctrid: '', idSelec: '', IdGrupo: $('#MddlGeneral').val()
                            //});
                            clearCamposCtr();
                            addnotify("notify", "La operación se realizó con éxito.");
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message);
                        }
                    });
                    clearCamposCtr();
                } else {
                    addnotify("notify", "Complete los Datos a Ingresar");
                }
            }
            function clearCamposCtr() {//funcion encargada de limpiar los input
                $('#hdid').val('');
                $('#MtxtCodInstalacion').val('');
                $('#MddlIdUsuario').val('').trigger('change');;
                $('#MddlIdZona').val('').trigger('change');
                $('#MtxtDescripcion').val('');
                $('#MtxtDireccionI').val('');
                $('#MtxtReferenciaI').val('');
                $('#chkHabilitadoI').prop("checked", true);
            }
        </script>
    </form>
</body>
</html>

