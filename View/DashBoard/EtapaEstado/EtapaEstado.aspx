<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EtapaEstado.aspx.cs" Inherits="Reporte_EtapaEstado_EtapaEstado" %>


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
    <style type="text/css">
        .red {
            background: red;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="wrapper">
            <div class="main">
                <div class="container">
                    <div class="row">
                        <div class="col-12 col-md-8 titulo">
                            <h2><i class="far fa-clipboard"></i>
                                <%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.MAN_WEB_ETAPA_ESTADO) %></h2>
                        </div>
                        <div class="col-6 col-md-4">
                            <div id="head-agr">
                                <button type="button" class="btn btn-default mas mobil hideFilter">
                                    <i class="fas fa-eye fa-lg"></i>
                                </button>
                            </div>

                            <ul class="btn-edit">
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
                                <select id="ddlEstado" multiple="multiple" class="form-control">
                                </select>
                            </div>

                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="ddlEtapa">Etapa</label>
                                <select id="ddlEtapa" multiple="multiple" class="form-control">
                                </select>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group">
                                <label for="ddlTipoTotal">Tipo Total</label>
                                <select id="ddlTipoTotal" class="form-control">
                                    <option value="1">CANTIDAD</option>
                                    <option value="2">TM ESTIMADO</option>
                                </select>
                            </div>
                            <div class="col-sm-4 col-md-2 form-group" style="float: right">
                                <button type="button" id="buscar" class="btn btn-danger" style="float: right">Buscar</button>
                            </div>
                        </form>
                    </div>

                    <div class="row">
                        <div id="DivEtapasPorEstado" style="width: 90%; height: 500px; float: left"></div>
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
        >
        <!-- Scripts personalizados-->
        <!-- Scripts tablas-->
        <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/libs/jquery-1.7.min.js"><\/script>')</script>--%>

        <script src="../../js/stacktable.js" type="text/javascript"></script>

        <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
        <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/js/bootstrap-multiselect.min.js"></script>--%>

        <script type="text/javascript" src="../../js/highCharts/highcharts.js"></script>
        <script type="text/javascript" src="../../js/highCharts/data.js"></script>
        <script type="text/javascript" src="../../js/highCharts/exporting.js"></script>
        <style>
            .highcharts-title > tspan {
                fill: #434348;
                font-weight: bold;
                font-size: 30px;
            }

            .highcharts-subtitle > tspan {
                fill: #434348;
                font-size: 20px;
            }
        </style>

        <script type="text/javascript">
            var urlPrin = 'EtapaEstado.aspx';
            var urlbus = 'EtapaEstadoGrid.aspx'; //grilla
            selectDefault = false;
            var inicia = 1;
            $(document).ready(function () {
                cargaComboMulti(urlPrin + '/ComboMultCoordinador', "#ddlCoordinador");
                cargaComboMulti(urlPrin + '/ComboMultResponsable', "#ddlResponsable", { coordinadores: "-1" });
                cargaComboMulti(urlPrin + '/ComboMultEtapa', "#ddlEtapa");
                cargaComboMulti(urlPrin + '/ComboMultEstado', "#ddlEstado");
                $("#buscar").click(
                    function (e) {
                        reporteGrafico();
                    });
                $('#buscar').trigger("click");
                cargarEventoKeyDown();

                $("#ddlCoordinador").change(function (e) {
                    var coordinadores = ValorComboMultSinAll('#ddlCoordinador');
                    cargaComboMulti(urlPrin + '/ComboMultResponsable', "#ddlResponsable", { coordinadores: coordinadores });
                });
            });
            function reporteGrafico() { //funcion encargada de enviar los parametros a la grilla
                rutaUrl = 'Etapaestado.aspx/reporteGrafico';
                $("#loading").show();
                $("#carousel").hide();
                var strData = new Object();//getParametros();
                $.ajax({
                    type: 'POST',
                    url: rutaUrl,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify(getParametros()),//strData
                    success: function (data) {
                        console.log(data);
                        reporteGraficoEtapasPorEstado('DivEtapasPorEstado', data.d.dashEtapasPorEstado);
                        //reporteGraficoCantosPorCentro('cantosporcentrofinanciero', data.d.dashCantoCentro);
                        $(".highcharts-credits").remove();
                        $("#loading").hide();
                    }
                    ,
                    error: function (xhr, status, error) {
                        alert(error);
                    }
                });
            }
            function getParametros() { //funcion encargada de enviar los parametros a la grilla
                var strData = new Object();
                strData.fechaini = $('#txtFechaInicio').val();
                strData.fechafin = $('#txtFechaFin').val();
                strData.coordinador = (inicia == 1 ? '-1' : ValorComboMultSinAll('#ddlCoordinador'));
                strData.responsable = (inicia == 1 ? '-1' : ValorComboMultSinAll('#ddlResponsable'));
                strData.estado = (inicia == 1 ? '1' : ValorComboMultSinAll('#ddlEstado'));
                strData.etapa = ValorComboMultSinAll('#ddlEtapa');
                strData.tipoTotal = $('#ddlTipoTotal').val();
                inicia = 2;
                return strData;
            }
            function reporteGraficoEtapasPorEstado(div, data) {
                console.log(data);
                Highcharts.theme = {
                    colors: ['#2E64FE', '#A4A4A4', '#FE9A2E', '#DDDF00', '#24CBE5', '#64E572',
                             '#FF9655', '#FFF263', '#6AF9C4']
                }
                Highcharts.setOptions(Highcharts.theme);
                Highcharts.chart(div, {
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: data.Titulo
                    },
                    xAxis: {
                        categories: data.categorias
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: data.SubTitulo
                        },
                        //stackLabels: {
                        //    enabled: true,
                        //    style: {
                        //        fontWeight: 'bold',
                        //        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                        //    }
                        //}
                    },
                    tooltip: {
                        headerFormat: '<b>{point.x}</b><br/>',
                        pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
                    },
                    plotOptions: {
                        column: {
                            stacking: 'normal',
                            dataLabels: {
                                format: '<b>{point.y}' + ($('#ddlTipoTotal').val() == '2' ? ' TM' : ''),
                                enabled: true,
                                color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'black'
                            }
                        }
                    },
                    series: data.itemsArr
                });
            }
        </script>

    </form>
    <div id="calendarwindow" class="calendar-window">
    </div>
</body>
</html>
