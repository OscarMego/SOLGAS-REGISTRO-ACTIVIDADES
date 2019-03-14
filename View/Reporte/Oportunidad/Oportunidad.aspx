<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Oportunidad.aspx.cs" Inherits="Reporte_Oportunidad_Oportunidad" %>


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
    <link rel="stylesheet" href="../../css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="../../css/fontawesome-all.min.css">
    <!-- Main css - css personalizacion-->
    <link rel="stylesheet" href="../../css/main.css">
    <!--  css Tabla-->
    <!-- Main css - css tabla responsive-->
    <link href="../../css/stacktable.css" rel="stylesheet" />
    <link href="../../js/multi-selected/dist/css/bootstrap-multiselect.css" rel="stylesheet" />
    <meta name="description" content="The responsive tables jQuery plugin for stacking tables on small screens">

    <link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%=Session["GOOGLE_ANALYTICS"] %>
</head>
<body>
    <form id="form1" runat="server">
        <div id="wrapper">
            <div class="main">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-7 col-md-8 titulo">
                            <h2><i class="far fa-clipboard"></i>
                                <%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.REP_WEB_BAND_OPORTUNIDAD) %></h2>
                        </div>
                        <div class="col-xs-5 col-md-4">
                            <div id="head-agr">
                                <button type="button" class="btn btn-default mas mobil hideFilter">
                                    <i class="fas fa-eye fa-lg"></i>
                                </button>
                            </div>

                            <ul class="btn-edit">
                                <li><a href="#"><i class="fas fa-download"></i>
                                    <button type="button" class="btn nuevo xlsReg">Exportar</button>
                                </a></li>
                                <li><a class="hideFilter"><i class="fas fa-eye"></i>Ver tablas</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="modal fade bd-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    </div>
                    <div class="row filtergrid">
                        <form>

                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="txtFechaInicio">Fecha Inicio</label>
                                <div class="input-group" data-toggle="datepicker">
                                    <asp:TextBox ID="txtFechaInicio" CssClass="form-control" MaxLength="10" type="text" data-date-format="dd/mm/yyyy" name="fechaDesde"
                                        onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);"
                                        runat="server" ReadOnly></asp:TextBox>
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="txtFechaFin">Fecha Fin</label>
                                <div class="input-group" data-toggle="datepicker">
                                    <asp:TextBox ID="txtFechaFin" CssClass="form-control" MaxLength="10" type="text" data-date-format="dd/mm/yyyy" name="fechaHasta"
                                        onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);"
                                        runat="server" ReadOnly></asp:TextBox>
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                             <div class="col-sm-4 col-md-2 form-group">
                                <label for="txtFechaInicio">Fecha Estimada Inicio</label>
                                <div class="input-group" data-toggle="datepicker">
                                    <asp:TextBox ID="txtFechaEstimadaInicio" CssClass="form-control" MaxLength="10" type="text" data-date-format="dd/mm/yyyy" name="fechaDesde"
                                        onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);"
                                        runat="server" ReadOnly></asp:TextBox>
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="txtFechaFin">Fecha Estimada Fin</label>
                                <div class="input-group" data-toggle="datepicker">
                                    <asp:TextBox ID="txtFechaEstimadaFin" CssClass="form-control" MaxLength="10" type="text" data-date-format="dd/mm/yyyy" name="fechaHasta"
                                        onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);"
                                        runat="server" ReadOnly></asp:TextBox>
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="txtCodigoOp">Codigo Op.</label>
                                <asp:TextBox ID="txtCodigoOp" runat="server" MaxLength="15" class="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group" id="divcoo" runat="server">
                                <label for="ddlCoordinador">Coordinador</label>
                                <select id="ddlCoordinador" multiple="multiple" class="form-control">
                                </select>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="ddlResponsable">Vendedor</label>
                                <select id="ddlResponsable" multiple="multiple" class="form-control">
                                </select>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="ddlEstado">Estado</label>
                                <asp:DropDownList ID="ddlEstado" runat="server" class="form-control"></asp:DropDownList>
                            </div>

                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="ddlEtapa">Etapa</label>
                                <select id="ddlEtapa" multiple="multiple" class="form-control">
                                </select>
                            </div>

                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="ddlRubro">Rubro</label>
                                <select id="ddlRubro" multiple="multiple" class="form-control">
                                </select>
                            </div>

                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="txtCliente">Cliente</label>
                                <asp:TextBox ID="txtCliente" runat="server" MaxLength="15" class="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="ddlTexportacion">Tipo Exportación</label>
                                <asp:DropDownList ID="ddlTexportacion" runat="server" class="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group" style="float: right">
                                <button type="button" id="buscar" class="btn btn-danger" style="float: right">Buscar</button>
                            </div>
                        </form>
                    </div>

                    <div class="form-gridview-data" id="divGridViewData" runat="server">
                    </div>
                    <div class="form-gridview-error" id="divGridViewError" runat="server">
                    </div>
                    <div class="form-gridview-search" id="divGridViewSearch" runat="server">
                        <div class="col-sm-12 form-group">
                            <img alt="<>" src="../../images/icons/loader/ico_loader-arrow-orange.gif" style="float: left; height: 32px;">
                            <p style="float: left; line-height: 32px; margin-left: 10px!important;">
                                buscando resultados
                            </p>
                        </div>
                    </div>
                    <!--Hidden Fields to control pagination-->
                    <div id="paginator-hidden-fields">
                        <asp:HiddenField ID="hdnActualPage" Value="1" runat="server" />
                        <asp:HiddenField ID="hdnShowRows" Value="10" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <!-- Modals-->
        <!-- jquery-->
        <script src="../../js/jquery-3.1.1.min.js"></script>
        <!-- bootstrap-->
        <script src="../../js/bootstrap.min.js"></script>

        <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>

        <script src="../../js/bootstrap-datepicker.js"></script>
        <!-- iCheck-->
        <!-- script(src="js/icheck.min.js")-->
        <!-- Bootstrap Select-->
        <!-- script(src="js/bootstrap-select.min.js")-->
        <!-- script(src="js/bootstrap-select-es.min.js")-->
        <!-- Main Script-->
        <script src="../../js/main.js"></script>
        <script src="../../js/cz_main.js" type="text/javascript"></script>
        <script src="../../js/JSModule.js"></script>
        
        <!-- Scripts personalizados-->
        <!-- Scripts tablas-->
        <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/libs/jquery-1.7.min.js"><\/script>')</script>--%>

        <script src="../../js/stacktable.js" type="text/javascript"></script>

        <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
        <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/js/bootstrap-multiselect.min.js"></script>--%>

        <script type="text/javascript">
            var urlPrin = 'Oportunidad.aspx';
            var urlbus = 'OportunidadGrid.aspx'; //grilla
            selectDefault = false;
            var inicia = 1;
            $(document).ready(function () {
                cargaComboMulti(urlPrin + '/ComboMultCoordinador', "#ddlCoordinador");
                cargaComboMulti(urlPrin + '/ComboMultResponsable', "#ddlResponsable", { coordinadores: "-1" });
                cargaComboMulti(urlPrin + '/ComboMultEtapa', "#ddlEtapa");
                cargaComboMulti(urlPrin + '/ComboMultRubro', "#ddlRubro");
                busReg(); //funcion encargada de mostrar la grilla y encargada de la paginacion de esta
                $('#buscar').trigger("click");
                cargarEventoKeyDown();

                $("#ddlCoordinador").change(function (e) {
                    var coordinadores = ValorComboMultSinAll('#ddlCoordinador');
                    cargaComboMulti(urlPrin + '/ComboMultResponsable', "#ddlResponsable", { coordinadores: coordinadores });
                });

                detReg(".btndetalle", "OportunidadDet.aspx");

                //funcion encarga de la exportacion
                var urlXLS = "../ExportarOportunidad.aspx";
                $(".xlsReg").on('click', function (e) {
                    if ( $('#ddlTexportacion').val()=="") {
                        $('#myModal').html(alertHtml('alertValidacion', "Seleccione el tipo de exportación"));
                        $('#myModal').modal('show');
                    } else {
                        var filas = getNumRows('.grilla');
                        if (filas > 0) {
                            window.location.href = urlXLS + '?' + getParametrosXLS();
                        }
                        else {
                            $('#myModal').html(alertHtml('alertValidacion', "No existe data para exportar"));
                            $('#myModal').modal('show');
                        }
                    }
                   
                });
            });

            function getParametros() { //funcion encargada de enviar los parametros a la grilla
                var strData = new Object();

                strData.FechaInicio = $('#txtFechaInicio').val();
                strData.FechaFin = $('#txtFechaFin').val();
                strData.FechaEstimadaInicio = $('#txtFechaEstimadaInicio').val();
                strData.FechaEstimadaFin = $('#txtFechaEstimadaFin').val();

                strData.Codigo = $('#txtCodigoOp').val();
                strData.Coordinador = (inicia == 1 ? "-1" : ValorComboMultSinAll('#ddlCoordinador'));
                //strData.Responsable = ValorComboMultSinAll('#ddlResponsable');
                strData.Estado = $('#ddlEstado').val();
                strData.Etapa = ValorComboMultSinAll('#ddlEtapa');
                strData.Rubro = ValorComboMultSinAll('#ddlRubro');
                strData.ConfRep = $('#ddlTexportacion').val();
                strData.Responsable = (inicia == 1 ? "-1" : ValorComboMultSinAll('#ddlResponsable'));
                strData.Cliente = $('#txtCliente').val();
                //strData.Etapa = $('#txtEtapa').val();
                //strData.Estado = $('#txtEstado').val();
                //PAG
                strData.pagina = $('#hdnActualPage').val();
                strData.filas = $('#hdnShowRows').val();
                inicia = 0;
                
                return strData;
            }
            function getParametrosXLS() {//funcion encargada de enviar los parametros a la exportacion

                var mod = "REP_BANDOPORT";
                return 'MOD=' + mod + '&valores=' + JSON.stringify(getParametros());
            }
        </script>

    </form>
    <div id="calendarwindow" class="calendar-window">
    </div>
</body>
</html>
