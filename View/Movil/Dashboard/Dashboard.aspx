<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="View.Movil.Dashboard.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">



<head runat="server">

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- Bootstrap css - css base-->
    <link rel="stylesheet" href="../../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../css/bootstrap-datepicker.css" />
    <link rel="stylesheet" href="../../css/fontawesome-all.min.css" />
    <link rel="stylesheet" href="../../css/grafico.css" />
    <title></title>
</head>
<body>

    <div class="container">
        <h1>Dashboard</h1>
    </div>
    <div id="grafico"></div>
    <div class="container" id="contData">
        <div class="col-md-4">
            <div id="tipoActividad_1">

            </div>
        </div>
    </div>

    <hr />
    <form id="formDash" runat="server">
        <div class="col-md-2 col-md-offset-6 form-group">
            <asp:Button ID="btnVisita" class="btn btn-danger" runat="server" Text="Registrar Actividad" OnClick="visita" Style="width: 100%;" />
        </div>

        <div class="col-md-2 col-md-offset-6">
            <asp:Button ID="btnsalir" class="btn btn-danger" runat="server" Text="Salir" OnClick="Salir" Style="width: 100%;" />
        </div>

    </form>
    <script src="../../js/jquery-3.1.1.min.js"></script>
    <script src="../../js/highCharts/highcharts.js"></script>
    <script src="../../js/highCharts/highcharts-more.js"></script>
    <script src="../../js/highCharts/solid-gauge.js"></script>        
    <script src="../../js/highCharts/exporting.js"></script>

    <!-- bootstrap-->
    <script src="../../js/bootstrap.min.js"></script>
    <script src="../../js/bootstrap-datepicker.js"></script>
    <script src="../../js/selecct-multiple.js"></script>

    <script type="text/javascript">  

        
        

        function PintarGraficoTiempoPromedio() {

            var gaugeOptions = {
                chart: {
                    type: 'solidgauge'
                },
                title: {
                    text: 'Tiempo Promedio'
                },
                subtitle: {
                    text: 'Tiempo referencial de ' + 30 + ' minutos'
                },
                pane: {
                    center: ['50%', '50%'],
                    size: '100%',
                    startAngle: 0,
                    endAngle: 360,
                    background: {
                        backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
                        innerRadius: '60%',
                        outerRadius: '100%',
                        shape: 'arc'
                    }
                },
                tooltip: {
                    enabled: true
                },
                // the value axis

                yAxis: {
                    stops: [
                    [0.1, '#DF5353'],// red
                    [0.5, '#DDDF0D'], // yellow
                    [0.9, '#55BF3B']  // green
                    ],
                    lineWidth: 0,
                    minorTickInterval: null,
                    tickPixelInterval: 400,
                    tickWidth: 0,
                    title: {
                        y: -70
                    },
                    labels: {
                        enabled: false
                    }
                },
                plotOptions: {
                    solidgauge: {
                        dataLabels: {
                            y: -10,
                            borderWidth: 0,
                            useHTML: false
                        }
                    }
                }
            };

            // The speed gauge

            var chartSpeed = Highcharts.chart('grafico', Highcharts.merge(gaugeOptions, {

                yAxis: {
                    min: 0,
                    max: 100,//Tiempo referencial de permanencia en un punto de venta
                    title: {
                        text: '',
                        y: -35
                    }
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: 'Actividades',
                    data: [10], //Tiempo promedio calculado
                    dataLabels: {
                        format: '<div style="text-align:center"><span style="font-size:25px;color:' +
                        ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y}</span><br/></div>'
                    },
                    tooltip: {
                        valueSuffix: ' Actividades'
                    }
                }]
            }));
        }


        
        function fcDibujarPlantilla() {

            var strData = new Object();

            $.ajax({
                type: 'POST',
                url: "Dashboard.aspx/GetReporteDashboard",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(strData),
                async: true,
                cache: false,
                success: function (data) {
                    $("#contData").html("");
                    $.each(data.d, function () {
                        var template = '<div class="col-md-4" ><div id="actividad_' + this.codigo + '">' + this.nombre + '</div>'+ 
                                        '</div>';
                        $("#contData").append(template);                        
                    });

                    $.each(data.d, function () {
                        var total = [];
                        total.push(parseInt(this.total));
                        fcDibujarGrafico("actividad_" + this.codigo, this.meta, total, this.nombre, "");
                    });
                },
                error: function (xhr, status, error) {
                    $("#myModal").html(alertHtml('error', xhr.responseText));
                }
            });
        }

        function fcDibujarGrafico(divName, meta, total, tipoActividad, subTitulo) {

            var gaugeOptions = {
                chart: {
                    type: 'solidgauge'
                },
                title: {
                    text: tipoActividad
                },
                subtitle: {
                    text: "Meta: " + meta
                },
                pane: {
                    center: ['50%', '50%'],
                    size: '100%',
                    startAngle: 0,
                    endAngle: 360,
                    background: {
                        backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
                        innerRadius: '60%',
                        outerRadius: '100%',
                        shape: 'arc'
                    }
                },
                tooltip: {
                    enabled: true
                },
                // the value axis

                yAxis: {
                    stops: [
                    [0.1, '#DF5353'], // red
                    [0.5, '#DDDF0D'], // yellow
                    [0.9, '#55BF3B'] // green
                    ],
                    lineWidth: 0,
                    minorTickInterval: null,
                    tickPixelInterval: 400,
                    tickWidth: 0,
                    title: {
                        y: -70
                    },
                    labels: {
                        enabled: false
                    }
                },
                plotOptions: {
                    solidgauge: {
                        dataLabels: {
                            y: -10,
                            borderWidth: 0,
                            useHTML: false
                        }
                    }
                }
            };

            var chart = Highcharts.chart(divName, Highcharts.merge(gaugeOptions, {
                yAxis: {
                    min: 0,
                    max: meta,
                    title: {
                        text: '',
                        y: -35
                    }
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: 'Actividades',
                    data: [5], //Tiempo promedio calculado
                    dataLabels: {
                        format: '<div style="text-align:center"><span style="font-size:25px;color:' +
                        ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y}</span><br/></div>'
                    },
                    tooltip: {
                        valueSuffix: 'Actividades'
                    }
                }]
            }));
            
            console.log(total);
            chart.series[0].setData(total, true);

        }

        fcDibujarPlantilla();


    </script>
</body>
</html>
