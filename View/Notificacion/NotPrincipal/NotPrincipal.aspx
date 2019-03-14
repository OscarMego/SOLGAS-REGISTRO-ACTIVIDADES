<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NotPrincipal.aspx.cs" Inherits="View.Notificacion.NotPrincipal.NotPrincipal" %>

<!DOCTYPE html>
<html lang="es">
<head id="Head1" runat="server">
    <%=Session["GOOGLE_ANALYTICS"] %>
    <style type="text/css">
        
    </style>

    <link href="../../js/multi-selected/dist/css/bootstrap-multiselect.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title" id="myModalLabel" runat="server">Notificación de Retraso de Oportunidades</h2>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-modal">
                        <form>
                            <div class="row filtergrid">
                                <div class="col-sm-6 col-md-3 form-group">
                                    <label for="txtFechaInicio">Fecha Inicio</label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtFechaInicio" CssClass="form-control" MaxLength="10" type="text" data-date-format="dd/mm/yyyy" name="fechaDesde"
                                            onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);"
                                            runat="server" ReadOnly></asp:TextBox>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3 form-group">
                                    <label for="txtFechaFin">Fecha Fin</label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtFechaFin" CssClass="form-control" MaxLength="10" type="text" data-date-format="dd/mm/yyyy" name="fechaHasta"
                                            onkeypress="javascript:fc_Slash(this.id, '/');" onblur="javascript:fc_ValidaFechaOnblur(this.id);"
                                            runat="server" ReadOnly></asp:TextBox>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3 form-group" id="divcoo" runat="server">
                                    <label for="ddlCoordinador">Coordinador</label>
                                    <select id="ddlCoordinador" multiple="multiple" class="form-control">
                                    </select>
                                </div>
                                <div class="col-sm-6 col-md-3 form-group">
                                    <label for="ddlResponsable">Vendedor</label>
                                    <select id="ddlResponsable" multiple="multiple" class="form-control">
                                    </select>
                                </div>
                                <div class="col-sm-6 col-md-3 form-group" style="float: right">
                                    <button type="button" id="buscar" class="btn btn-danger" style="float: right">Buscar</button>
                                </div>
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
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="container-modal">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
                <asp:HiddenField ID="MhAccion" runat="server" />
            </div>
        </div>
        <script type="text/javascript" src="../../js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
        <script type="text/javascript">
            var urlPrin = 'Notificacion/NotPrincipal/NotPrincipal.aspx';
            selectDefault = false;
            var iniPag = 1;
            var urlbus = 'Notificacion/NotPrincipal/NotPrincipalgrid.aspx'; //grilla
            $(document).ready(function () {
                iniPag = 1;
                cargaComboMulti(urlPrin + '/ComboMultCoordinador', "#ddlCoordinador");
                cargaComboMulti(urlPrin + '/ComboMultResponsable', "#ddlResponsable", { coordinadores: "-1" });
                console.log("prueba");
                
                busReg(); //funcion encargada de mostrar la grilla y encargada de la paginacion de esta
                $('#buscar').trigger("click");
                $("#ddlCoordinador").change(function (e) {
                    var coordinadores = ValorComboMultSinAll('#ddlCoordinador');
                    cargaComboMulti(urlPrin + '/ComboMultResponsable', "#ddlResponsable", { coordinadores: coordinadores });
                });
                //setTimeout(function () {
                //    $("#ddlCoordinador").next().find("input:checkbox").each(function (e) {
                //        $(this).prop("disabled", true);
                //    });
                //    $("#ddlResponsable").next().find("input:checkbox").each(function (e) {
                //        $(this).prop("disabled", true);
                //    });
                //}, 2000);

            });
            function getParametros() { //funcion encargada de enviar los parametros a la grilla
                var strData = new Object();

                strData.Coordinador = (iniPag==1?"-1": ValorComboMultSinAll('#ddlCoordinador'));
                strData.Responsable = (iniPag==1?"-1": ValorComboMultSinAll('#ddlResponsable'));
                //strData.Etapa = $('#txtEtapa').val();
                //strData.Estado = $('#txtEstado').val();
                //PAG
                strData.pagina = $('#hdnActualPage').val();
                strData.filas = $('#hdnShowRows').val();
                iniPag = 0;
                return strData;
            }
        </script>
        <div id="calendarwindow" class="calendar-window">
        </div>
    </form>
</body>
</html>
