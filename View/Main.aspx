<%@ Page Language="C#" AutoEventWireup="true" Inherits="Main" CodeBehind="Main.aspx.cs" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <!-- #### META tags ####-->
    <!-- Meta tags browser-->
    <meta charset="utf-8">
    <meta http.equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Meta tags Description-->
    <meta name="description" content="<%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_APP_NAME)%>">
    <meta name="author" content="GMD">
    <meta property="og:url" content="">
    <!-- -TITULO DE LA APLICACION-->
    <meta property="og:site_name" content="<%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_APP_NAME)%>">
    <!-- -TITULO DE LA PAGINA-->
    <meta property="og:title" content="<%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_APP_NAME)%>">
    <!-- -DESCRIPCION-->
    <meta property="og:description" content="<%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_APP_NAME)%>">
    <!-- -UBICACIÓN-->
    <meta property="og:locale" content="es_PE">
    <!-- -IMAGEN REPRESENTATIVA-->
    <meta property="og:image" content="">
    <!-- #### TITLE ####-->
    <title>SOLGAS</title>
    <!-- Open Sans - Body-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,400i,600,600i,700,700i" rel="stylesheet">
    <!-- Heebo - Body-->
    <link href="https://fonts.googleapis.com/css?family=Heebo:100,400,500,700" rel="stylesheet">
    <!-- #### ICON ####-->
    <link rel="icon" href="images/icons/shortcuticon0.png">
    <!-- Bootstrap css - css base-->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/fontawesome-all.min.css">


    <!-- Main css - css personalizacion-->
    <link rel="stylesheet" href="css/main.css">
    <link href="js/multi-selected/dist/css/bootstrap-multiselect.css" rel="stylesheet" />
    <!--  css Tabla-->
    <meta name="description" content="The responsive tables jQuery plugin for stacking tables on small screens">

    <link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>
    <link href="css/stacktable.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%=Session["GOOGLE_ANALYTICS"] %>
</head>
<body style="background: #e8edf1;">
    <form id="form1" runat="server">
        <div id="wrapper">
            <nav class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">
                        <div class="temp-logo">
                            <img class="navbar-image" src="images/logo/logo.jpg">
                        </div>
                    </a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav menu">
                        <asp:Literal ID="MenuTop" runat="server"></asp:Literal>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <div class="navbar-profile hidden-sm hidden-xs">
                            <ul class="perfil">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle perfil" data-toggle="dropdown">
                                        <img class="phoperfil" src="images/user.png"><asp:Label ID="lbNomUsuario" runat="server" Text=""></asp:Label><b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="Menu.aspx">Inicio</a></li>
                                        
                                            
                                        <li version="1"><a id="versionApp">Versión</a></li>
                                        <li salir="1">
                                            <asp:LinkButton ID="opcSalir" OnClick="opcSalir_Click" runat="server">Salir</asp:LinkButton></li>
                                        <%--<li>
                                            <asp:LinkButton ID="opcSalir" href="Default.aspx" runat="server" >Cerrar Seción</asp:LinkButton>
                                        </li>--%>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </ul>
                </div>
            </nav>

            <%--<div class="main">  --%>
            <!--(altura/anchura)*100-->
            <div class="embed-container">
                <iframe name="centerFrame" style="width: 100%; height: 100%" id="centerFrame" width="560" height="315" frameborder="0" allowfullscreen></iframe>
                <div class="modal fade bd-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                </div>
                <div class="modal fade bd-example-modal-lg" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                </div>
            </div>
            <%--<iframe name="centerFrame" id="centerFrame" width="100%" height="100%" scrolling="yes" frameborder="0"></iframe>--%>
            <%--</div>--%>
        </div>


        <footer class="footer">
            <div class="container">
                <div class="copyright">
                    <%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_AREA_NAME) + " / " + Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_APP_NAME)%>
                    <%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_PIE_P, Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_OPERADOR + Controller.GeneralController.obtenerTemaActual(true)))%>
                    <%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_PIE_BR)%> VS <%=Model.bean.ManagerConfiguracion.Version%>
                    <%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_PIE2_BR)%>
                </div>
            </div>
        </footer>
        <!-- Modals-->
        <!-- jquery-->
        <script src="js/jquery-3.1.1.min.js"></script>
        <!-- bootstrap-->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <!-- iCheck-->
        <!-- script(src="js/icheck.min.js")-->
        <!-- Bootstrap Select-->
        <!-- script(src="js/bootstrap-select.min.js")-->
        <!-- script(src="js/bootstrap-select-es.min.js")-->
        <!-- Main Script-->
        <script src="js/main.js"></script>
        <script src="js/cz_main.js"></script>
        <script src="js/JSModule.js"></script>
        <!-- Scripts personalizados-->
        <!-- Scripts select multiple-->
        <script type="text/javascript" src="js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
        <script type="text/javascript">
            function Busqueda() {
                console.log('Busqueda');
                $.ajax({
                    type: 'POST',
                    url: "Notificacion/NotPrincipal/NotPrincipal.aspx",
                    contentType: "application/json; charset=utf-8",
                    async: true,
                    cache: false,
                    //data: JSON.stringify(strData),
                    beforeSend: function () {
                        $("#myModal").html('');
                    },
                    success: function (data) {
                        $("#myModal").html(data);

                        $('#myModal').modal('show');

                    },
                    error: function (xhr, status, error) {

                    }
                });
            }
            $(document).ready(function () {
                //inicializarEventos();
<%--                <%if (Controller.NServicesController.nServicesExisteWebConfig())
                {
                    string[] hijos = ConfigurationManager.AppSettings["NSERVICES_INSTANCIA_PADRE"].Split(';');
                    string target = Controller.NServicesController.nServicesEsEmbebido() ? "" : "_blank";
                    for (int i = 0; i < hijos.Length; i++)
                    {
                        string hijo = hijos[i];%>
                        $('#nservices<%=i %>').parent().click(function (e) {
                            unclick();
                            var data = [$.cookie('usr') + '@' + $.cookie('psw')];
                            postData('<%=hijo%>', data, "<%=target %>");
                            e.preventDefault();
                            return false;
                        });
                        <%} %>
                <%} %>--%>
                Busqueda();
            });
        </script>
    </form>
</body>
</html>
