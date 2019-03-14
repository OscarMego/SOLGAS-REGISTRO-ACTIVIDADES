<%@ Page Language="C#" AutoEventWireup="true" Inherits="Mantenimiento_Config" Codebehind="Config.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<head id="Head1" runat="server">
    <meta name="robots" content="noindex, nofollow, noarchive, noodp, nosnippet">
    <script src="../../js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="../../js/Validacion.js" type="text/javascript"></script>
    <script src="../../js/bootstrap.min.js" type="text/javascript"></script>
    <link href="../../css/PopupCalendar.css" type="text/css" rel="stylesheet" />
    <script src="../../js/PopupCalendar.js" type="text/javascript"></script>
    <script src="../../js/jsmodule.js" type="text/javascript"></script>
    <link href="../../css/cz_main.ashx" type="text/css" rel="stylesheet" />
    <script src="../../js/cz_main.js" type="text/javascript"></script>
    <link href="../../css/jquery.timepicker.css" type="text/css" rel="stylesheet" />
    <script src="../../js/jquery.timepicker.js" type="text/javascript"></script>
    <%=Session["GOOGLE_ANALYTICS"] %>

    <script type="text/javascript">


        var urlsavN = 'Config.aspx/guardarConfig'; //WebMethod para insercion

        $(document).ready(function () {

            $('#btnSave').click(function (e) {
                var validateItems = true;

                $('.requerid').each(function () {
                    $(this).parent().find('span').remove();
                    if ($(this).val() == "") {

                        $(this).after("<span style='color:#b94a48'>*</span>");

                        validateItems = false;
                    }
                });

                var validateValues = (($('#TGPS_COF').val() === undefined) || ($('#TGPS_COF').val() >= 5));
                var validateBateria = (($('#NOTI_COF').val() === undefined) || (($('#NOTI_COF').val() >= 0) && ($('#NOTI_COF').val() <= 100)));

                if (!validateItems) {
                    addnotify("notify", "Ingrese los campos obligatorios.", "datacomplete");
                } else if (!validateValues) {
                    addnotify("notify", "Debe ingresar un valor mayor a 5.", "datacomplete");
                } else if (!validateBateria) {
                    addnotify("notify", "Debe ingresar un valor entre 0 y 100.", "datacomplete");
                } else {
                    var jdata = new Object();
                    jdata.json = JSON.stringify(getData())

                    $.ajax({
                        type: 'POST',
                        url: urlsavN,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        data: JSON.stringify(jdata),
                        success: function (data) {
                            parent.document.location.href = "../../Main.aspx?acc=ACT";
                        },
                        error: function (xhr, status, error) {
                            addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "configsatisfact");

                        }
                    });

                }
            });

        });

        function getData() {
            var strData = new Object();
            var strDias = "";
            $('#cz-form-box :input').each(function () {
                if ($(this).attr('tipo') == "HDIA_COF") {
                    if ($(this).val() == "T") {
                        strDias += "1";
                    } else {
                        strDias += "0";
                    }
                } else {
                    strData[$(this).attr("id")] = $(this).val();
                }
            });
            strData["HDIA_COF"] = strDias;
            return strData;
        }

        function modifiacarValorChecked(liId) {
            var idChecked = "#" + liId;
            if ($(idChecked).is(':checked')) {
                $(idChecked).val("T");
            }
            else {
                $(idChecked).val("F");
            }
        }


        function modifiacarValorCheckedModulo(liId) {
            var idChecked = "#" + liId;
            var claseChecked = "." + liId;
            if ($(idChecked).is(':checked')) {
                $(idChecked).val("T");
                modificarValoresModuloConfig(claseChecked, true);
                modificarValoresFuncionConfig(claseChecked + "_FUN", true);
            }
            else {
                $(idChecked).val("F");
                modificarValoresModuloConfig(claseChecked, false);
                modificarValoresFuncionConfig(claseChecked + "_FUN", false);
            }

        }

        function modificarValoresFuncion(liId) {
            var idChecked = "#" + liId;
            var claseChecked = "." + liId;

            if ($(idChecked).is(':checked')) {
                $(idChecked).val("T");
                modificarValoresFuncionConfig(claseChecked, true);
            }
            else {
                $(idChecked).val("F");
                modificarValoresFuncionConfig(claseChecked, false);
            }
        }


        function modificarValoresModuloConfig(claseChecked, estado) {
            if (estado) {
                $(claseChecked).prop("checked", true);
                $(claseChecked).removeAttr("disabled");
                $(claseChecked).val("T");
            } else {
                $(claseChecked).prop("checked", false);
                $(claseChecked).attr("disabled", true);
                $(claseChecked).val("F");
            }
        }

        function modificarValoresFuncionConfig(claseChecked, estado) {

            if (estado) {
                $(claseChecked).removeAttr("disabled");
            } else {
                $(claseChecked).attr("disabled", true);
            }
        }
         
    </script>
</head>
<body class="formularyW">
    <form id="form1" runat="server">
    <div class="cz-submain cz-submain-form-background">
        <div id="cz-form-box">
            <div class="cz-form-box-content">
                <div id="cz-form-box-content-title">
                    <img id="cz-form-box-content-title-icon" src="../../imagery/all/icons/config.png"
                        alt="<>" />
                    <div id="cz-form-box-content-title-text">
                        <p>
                            <%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.ETI_MNT_CNF).Substring(0,1).ToUpper() + Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.ETI_MNT_CNF).Substring(1) %></p>
                    </div>
                </div>
            </div>
            <div class="cz-form-box-content cz-util-nopad">
                <div class="cz-form-box-content-subtitle cz-util-pad-min">
                    <p>Módulos y parámetros configurables</p>
                </div>
                <div class="cz-util-pad">
                    <asp:Literal ID="litModulo" runat="server"></asp:Literal>
                    <asp:Literal ID="litFunciones" runat="server"></asp:Literal>
                    <asp:Literal ID="litValoresConfiguracion" runat="server"></asp:Literal>
                    <div class="cz-form-content-wall">
                        <% if(fnValidarPerfilMenu("COF",Model.Enumerados.FlagPermisoPerfil.EDITAR)){ %>
                        <input type="button" id="btnSave" class="cz-form-content-input-button" value="Guardar" />
                        <%} %>
                    </div>
                </div>
            </div>
            <div class="cz-form-box-content cz-util-nopad">
                <div class="cz-form-box-content-subtitle cz-util-pad-min">
                    <p>Ayuda</p>
                </div>
                    <asp:Literal ID="litManual" runat="server"></asp:Literal>
                
            </div>
            <div class="alert fade" style="margin-left: 140px; width: 3   00px;" id="divError">
                <strong id="tituloMensajeError"></strong>
                <p id="mensajeError">
                </p>
            </div>
            <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                aria-hidden="true">
            </div>
        </div>
    </div>
    </form>
    <div id="calendarwindow" class="calendar-window">
    </div>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#MGPS_MOD").click(function () {
                if ($(this).prop("checked")) {
                    $("#imgHorSin").on("click", function () { $('#HSIN_COF').timepicker('show'); });
                    $("#imgHorIni").on("click", function () { $('#HINI_COF').timepicker('show'); });
                    $("#imgHorFin").on("click", function () { $('#HFIN_COF').timepicker('show'); });
                } else {
                    $("#imgHorSin").off("click");
                    $("#imgHorIni").off("click");
                    $("#imgHorFin").off("click"); 
                }
            });


            $('#HSIN_COF').timepicker({
                timeFormat: 'H:i',
                maxTime: '23:59'
            });
            $('#imgHorSin').on('click', function () {
                $('#HSIN_COF').timepicker('show');
            });

            $('#HINI_COF').timepicker({
                timeFormat: 'H:i',
                maxTime: '23:59'
            });
            $('#imgHorIni').on('click', function () {
                $('#HINI_COF').timepicker('show');
            });

            $('#HFIN_COF').timepicker({
                timeFormat: 'H:i',
                maxTime: '23:59'
            });
            $('#imgHorFin').on('click', function () {
                $('#HFIN_COF').timepicker('show');
            });

        });
    </script>
</body>
</html>
