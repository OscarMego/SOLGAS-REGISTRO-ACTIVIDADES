<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="B2B.aspx.cs" Inherits="View.Movil.B2B.B2B" %>

<!DOCTYPE html>

<html lang="es">
<head id="Head1" runat="server">
    <!-- #### META tags ####-->
    <!-- Meta tags browser-->
    <meta charset="utf-8">
    <meta http.equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Meta tags Description-->
    <meta name="description" content="Sistema Entel">
    <meta name="author" content="GMD">
    <meta property="og:url" content="">
    <!-- -TITULO DE LA APLICACION-->
    <meta property="og:site_name" content="Sistema Entel">
    <!-- -TITULO DE LA PAGINA-->
    <meta property="og:title" content="Sistema Entel">
    <!-- -DESCRIPCION-->
    <meta property="og:description" content="Sistema Entel">
    <!-- -UBICACIÓN-->
    <meta property="og:locale" content="es_PE">
    <!-- -IMAGEN REPRESENTATIVA-->
    <meta property="og:image" content="">
    <!-- #### TITLE ####-->
    <title>Entel</title>
    <!-- Open Sans - Body-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,400i,600,600i,700,700i" rel="stylesheet">
    <!-- Heebo - Body-->
    <link href="https://fonts.googleapis.com/css?family=Heebo:100,400,500,700" rel="stylesheet">
    <!-- #### ICON ####-->
    <!-- Bootstrap css - css base-->
    <link rel="stylesheet" href="../../css/fontawesome-all.min.css" />
    <link rel="stylesheet" href="../../css/bootstrap.min.css" />
    <link href="../../js/multi-selected/dist/css/bootstrap-multiselect.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../css/autocomplete-main.css" />
    <link rel="stylesheet" href="../../css/jquery.autocomplete.css" />
    <link rel="stylesheet" href="../../css/css_datepicker.css" />
    <!-- Main css - css personalizacion-->

    <!--  css Tabla-->
    <!-- Main css - css tabla responsive-->


    <link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%=Session["GOOGLE_ANALYTICS"] %>
</head>
<body>

    <div class="container">
        <h1>Formulario B2B</h1>
    </div>

    <form id="form1" runat="server">
        <div class="main">
            <div class="container" style="z-index: -1; overflow-y: scroll;">
                <asp:HiddenField ID="hdiCodClie" runat="server" />
                <asp:HiddenField ID="MtxtIdOportunidad" runat="server" />
                <asp:HiddenField ID="MtxtIdNewOportunidad" runat="server" />
                <asp:HiddenField ID="hddEsOportunidad" runat="server" />
                <asp:HiddenField ID="hdinamicocontrol" runat="server" />
                <asp:HiddenField ID="hddLatitude" runat="server" Value="0" />
                <asp:HiddenField ID="hddLongitude" runat="server" Value="0" />
                <asp:HiddenField ID="hddIdContacto" runat="server" />
                <asp:HiddenField ID="hddIdUsuario" runat="server" />

                <div class="row">
                    <div class="col-sm-12 form-group">
                        <label for="txtFechaInicio">Fecha Inicio</label>
                        <span style="color: #b94a48">*</span>
                        <div class="input-group" data-toggle="datepicker">
                            <input id="txtFechaInicio" class="form-control" maxlength="10" type="text" data-date-format="dd/mm/yyyy" name="fechaDesde" onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);" runat="server" readonly="readonly" />
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                            </span>
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <label for="cboTipoActividad">Tipo de Actividad</label>
                        <span style="color: #b94a48">*</span>
                        <asp:DropDownList ID="cboTipoActividad" runat="server" class="requerid form-control"></asp:DropDownList>
                    </div>
                    <div class="col-sm-12 form-group">
                        <label for="cboSubTipoActividad" id="lblSubTipoOportunidad">Sub Tipo de Actividad</label>
                        <span style="color: #b94a48">*</span>
                        <asp:DropDownList ID="cboSubTipoActividad" runat="server" class="requerid form-control"></asp:DropDownList>
                    </div>
                    <div class="col-sm-12 form-group">
                        <label for="txtCliente">Cliente</label>
                        <span style="color: #b94a48">*</span>
                        <input type="text" id="txtCliente" runat="server" class="requerid form-control" maxlength="80" idval="0" />
                    </div>

                    <div id="dvClienteInstalacion">
                        <div class="col-sm-12 col-md-12 col-lg-12 col-sm-12">
                            <label for="txtCodInstalacion">Codigo de Instalación</label>
                            <span style="color: #b94a48">*</span>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-12 col-sm-12">
                            <div class="form-group">
                                <div class="row">
                                    <div class="row col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                        <div class="col-xs-10 col-sm-10 col-md-10 col-lg-11">
                                            <input type="text" id="txtCodInstalacion" disabled="disabled" runat="server" class="requerid form-control" maxlength="80" />
                                        </div>
                                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
                                            <a id="InstalacionAdd" data-toggle="modal" onclick="obtenerInstalacion()" style="cursor: pointer">
                                                <img src="../../images/lupa.png" alt="" /></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 form-group" id="dvCambiarEtapa">
                        <label for="MchkCambiarEtapa" id="lblCambiarEtapa" runat="server">Cambiar Etapa</label>
                        <input type="checkbox" name="MchkCambiarEtapa" value="notify" id="MchkCambiarEtapa" class="" checked="checked" />
                    </div>
                    <div class="form-group" id="DivAutogenerado" runat="server">
                    </div>

                    <div class="col-sm-12 col-md-12 col-lg-12 col-sm-12">
                        <label for="txtContacto">Contacto</label>
                        <span style="color: #b94a48">*</span>
                    </div>
                    <div class="col-sm-12 col-md-12 col-lg-12 col-sm-12">
                        <div class="form-group">
                            <div class="row">
                                <div class="row col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <div class="col-xs-10 col-sm-10 col-md-10 col-lg-11">
                                        <input type="text" id="txtContacto" disabled="disabled" runat="server" class="requerid form-control" maxlength="80" />
                                    </div>
                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
                                        <a id="ContactoAdd" data-toggle="modal" onclick="obtenerContactos()" style="cursor: pointer">
                                            <img src="../../images/man-user.png" alt="" /></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <label for="txtMail">Mail</label>
                        <input type="text" id="txtMail" runat="server" disabled="disabled" class="form-control" maxlength="80" />
                    </div>
                    <div class="col-sm-12 form-group">
                        <label for="txtTelefono">Telefono</label>
                        <input type="text" id="txtTelefono" runat="server" disabled="disabled" class="form-control" maxlength="80" />
                    </div>
                    <div class="col-sm-12 form-group">
                        <label for="txtCargo">Cargo</label>
                        <input type="text" id="txtCargo" runat="server" disabled="disabled" class="form-control" maxlength="80" />
                    </div>
                    <div class="col-sm-12 form-group">
                        <label for="txtObservaciones">Observaciones</label>
                        <textarea id="txtObservaciones" runat="server" class="form-control" rows="4" maxlength="400"></textarea>
                    </div>
                    <div class="col-sm-12 form-group">
                        <button type="button" class="btn btn-danger form-control" id="saveRegD">Guardar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>


    <!-- Modal Listado Contacto -->
    <div class="modal fade" id="User" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div style="z-index: -1; overflow-y: scroll; height: 200px; cursor: pointer;" id="ContactosLista"></div>
                </div>
                <div style="text-align: center;" class="modal-footer">
                    <a class="btn nuevo addRegC" data-toggle="modal" data-target=".bd-example-modal-lg" data-dismiss="modal">
                        <img src="../../images/add-button.png" alt="" /></a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bd-example-modal-lg" id="mdNuevoContacto" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"></div>
    <div class="modal fade bd-example-modal-lg" id="mdNewOportunidad" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    </div>


    <script src="../../js/jquery-3.1.1.min.js"></script>
    <script src="../../js/bootstrap.min.js"></script>
    <script src="../../js/bootstrap-datepicker.min.js"></script>
    <script src="../../js/selecct-multiple.js"></script>
    <script src="../../js/jquery.autocomplete.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
    <script src="../../js/JSModule.js"></script>
    <script type="text/javascript">
        //var urlins = 'BanOportunidadNew.aspx'//pantalla de registros
        var urlPrin = 'B2B.aspx';
        var urlFillCliente = '../../Movil/B2B/FillCliente.ashx'
    </script>
    <script type="text/javascript" src="../../js/formularios-movil.js"></script>
    <script src="../../js/main.js"></script>
    <script src="../../js/cz_main.js" type="text/javascript"></script>
    <script src="../../js/Validacion.js"></script>
    <script src="../../js/stacktable.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>

</body>
</html>
