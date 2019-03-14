<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactosNew.aspx.cs" Inherits="Mantenimiento_Contactos_ContactosNew" %>

<!DOCTYPE html>
<html lang="es">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../js/multi-selected/dist/css/bootstrap-multiselect.css" rel="stylesheet" />

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
                        <form>
                            <div class="row">
                                <asp:HiddenField ID="MtxtIdContacto" runat="server" />
                                <asp:HiddenField ID="MhdiCodClie" runat="server" />
                                <asp:HiddenField ID="MhdiCodClieIns" runat="server" />
                                <asp:HiddenField ID="hddIdZona" runat="server" />
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtNombre">Nombres</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtNombre" runat="server" maxlength="150" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" />
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MtxtTelefono">Teléfono</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtTelefono" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="10" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtEmail">Email</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtEmail" runat="server" class="requerid form-control" maxlength="50" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCargo">Cargo</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCargo" runat="server" onkeypress="return SoloAlfanumerico(event);" class="requerid form-control" maxlength="50" />
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MtxtCliente">Cliente</label>
                                    <span style="color: #b94a48">*</span>
                                    <input type="text" id="MtxtCliente" runat="server" class="requerid form-control" maxlength="80" idval="0" />
                                </div>

                                <div class="col-sm-6 form-group">
                                    <label for="MddlIdZona">Zona</label>
                                    <span style="color: #b94a48">*</span>
                                    <asp:DropDownList ID="MddlIdZona" runat="server" class="requerid form-control"></asp:DropDownList>
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
            function getData() {//funcion encargada de enviar los parametros para la insercion o edicion

                var strData = new Object();
                strData.IdContacto = $('#MtxtIdContacto').val();
                strData.Nombre = $('#MtxtNombre').val();
                strData.Telefono = $('#MtxtTelefono').val();
                strData.Email = $('#MtxtEmail').val();
                strData.Cargo = $('#MtxtCargo').val();
                strData.IdCliente = $('#MhdiCodClie').val();
                strData.IdClienteInstalacion = $('#MhdiCodClieIns').val();
                strData.IdZona = $('#MddlIdZona').val();
                strData.accion = $('#MhAccion').val();

                return strData;
            }
            function clearCampos() {//funcion encargada de limpiar los input
                camClave = 0;
                $('#MtxtNombre').val('');
                $('#MtxtTelefono').val('');
                $('#MtxtEmail').val('');
                $('#MtxtCargo').val('');
                $('#MhdiCodClie').val('');
                $('#MhdiCodClieIns').val('');
                $('#MddlIdZona').val('').trigger('change');
                $('#myModal').modal('hide');
            }

            $('#MtxtCliente').autocomplete({
                serviceUrl: '../../Mantenimiento/Contactos/FillCliente.ashx',
                onSelect: function (suggestion) {
                    //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
                    $(this).attr("idval", suggestion.data);
                    $('#MhdiCodClieIns').val(suggestion.data);
                    var vCodClieInst = $('#MhdiCodClieIns').val();
                    console.log(vCodClieInst);
                    ObternerClienteId(vCodClieInst);
                    cargaComboDSL(urlPrin + '/ComboZonas', '#MddlIdZona', 'SELECCIONE', {
                        idCliente: suggestion.data, idZona: $('#hddIdZona').val()
                    });
                },
                onSearchStart: function (params) {
                    $(this).attr("idval", "");
                    cargaComboDSL(urlPrin + '/ComboZonas', '#MddlIdZona', 'SELECCIONE', {
                        idCliente: '0', idZona: '0'
                    });
                    //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
                },
                paramName: 'query',
                transformResult: function (response) {
                    response = $.parseJSON(response);
                    return {
                        suggestions: $.map(response, function (dataItem) {
                            return { value: dataItem.Nombre, data: dataItem.Codigo };
                        })
                    };
                }
            });

            function ObternerClienteId(IdClieInst) {
                var id = IdClieInst == '' ? '0' : IdClieInst
                var input = { Id: id }
                param = JSON.stringify(input);
                $.ajax({
                    type: "POST",
                    url: "ContactosNew.aspx/ObtenerClienteId",
                    data: param,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //addnotify("notify", "La operación se realizó con éxito.");
                        $('#MhdiCodClie').val(data.d.IdCliente);
                    },
                    error: function (xhr, status, error) {
                        addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "registeruser");
                    }
                });
            }

            //$(document).ready(function () {
                $('#MtxtCliente').focus();
              //  $('#MtxtNombre').focus();
            //});
        </script>
    </form>
</body>
</html>
