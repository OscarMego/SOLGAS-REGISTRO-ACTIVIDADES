<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DescargaFoto.aspx.cs" Inherits="Descarga_Foto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<head id="Head1" runat="server">
    <meta name="robots" content="noindex, nofollow, noarchive, noodp, nosnippet">
    <script src="../../js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="../../js/Validacion.js" type="text/javascript"></script>
    <script src="../../js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../../js/JSModule.js" type="text/javascript"></script>
    <link href="../../css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
    <script src="../../js/jquery.autocomplete.js" type="text/javascript"></script>
    <link href="../../css/PopupCalendar.css" type="text/css" rel="stylesheet" />
    <script src="../../js/PopupCalendar.js" type="text/javascript"></script>

    <link href="../../css/cz_main.ashx" type="text/css" rel="stylesheet" />
    <script src="../../js/cz_main.js" type="text/javascript"></script>
    <link href="../../css/jquery.timepicker.css" type="text/css" rel="stylesheet" />
    <script src="../../js/jquery.timepicker.js" type="text/javascript"></script>



    <link href="../../css/bootstrapMod.css" rel="stylesheet" />


    <script type="text/javascript">
        var urlPrin = 'DescargaFoto.aspx';
        $(document).ready(function () {
            realizarAccion = true;
            $(".desFoto").live('click', function (e) {
                window.location.href = "../../Reporte/ExportaFotos.aspx" + '?' + getParametrosXLS();
            });
        });

        function getParametrosXLS() {//funcion encargada de enviar los parametros a la exportacion

            var FechaInicio = $('#txtFecini').val();
            var FechaFin = $('#txtFecfin').val();

            var mod = "DES_FOTOS";
            return 'mod=' + mod + '&FechaInicio=' + FechaInicio + '&FechaFin=' + FechaFin;
        }

        function clearCampos() {   
            var urlPrin = 'DescargaFoto.aspx';
            var now = new Date();
            gruposSeleccionados = "";
            function pad(s) { return (s < 10) ? '0' + s : s; }

            $('#txtFecini').val(pad(now.getDate()) + '/' + pad((now.getMonth() + 1)) + '/' + now.getFullYear());
            $('#txtFecfin').val(pad(now.getDate()) + '/' + pad((now.getMonth() + 1)) + '/' + now.getFullYear());
        }
    </script>
</head>
<body class="formularyW">
    <form id="form1" runat="server">
        <div class="cz-submain cz-submain-form-background">
            <div id="cz-form-box">
                <div class="cz-form-box-content">
                    <div id="cz-form-box-content-title">
                        <img id="cz-form-box-content-title-icon" src="../../imagery/all/icons/config.png" alt="<>" />
                        <div id="cz-form-box-content-title-text">
                            <p>Modulo de Descarga de Foto</p>
                        </div>
                    </div>
                </div>
                <div class="cz-form-box-content">
                    <div class="cz-form-content">
                        <p>Fecha inicio</p>
                        <asp:TextBox ID="txtFecini" class="cz-form-content-input-calendar" MaxLength="10" onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);" runat="server"></asp:TextBox>
                        <div class="cz-form-content-input-calendar-visible">
                            <div class="cz-form-content-input-calendar-visible-button">
                                <img alt="<>" id="fecini-img" name="fecini-img" class="form-input-date-image cz-form-content-input-text-calendar" src="../../images/icons/calendar.png" />
                            </div>
                        </div>
                    </div>
                    <div class="cz-form-content">
                        <p>Fecha fin</p>
                        <asp:TextBox ID="txtFecfin" class="cz-form-content-input-calendar" MaxLength="10" onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);" runat="server"></asp:TextBox>
                        <div class="cz-form-content-input-calendar-visible">
                            <div class="cz-form-content-input-calendar-visible-button">
                                <img alt="<>" id="fecfin-img" name="fecfin-img" class="form-input-date-image cz-form-content-input-text-calendar" src="../../images/icons/calendar.png" />
                            </div>
                        </div>
                    </div>
                    <div class="cz-form-content">
                        <input type="button" id="cz-form-box-exportar" class="desFoto cz-form-content-input-button cz-form-content-input-button-image form-button cz-form-box-content-button cz-util-right" value="Descargar" />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div id="calendarwindow" class="calendar-window">
    </div>
</body>
</html>
