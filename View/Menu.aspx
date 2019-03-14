<%@ Page Language="C#" AutoEventWireup="true" Inherits="Menu" CodeBehind="Menu.aspx.cs" %>

<!DOCTYPE html>

<!DOCTYPE html>
<html lang="es">
<head id="Head1" runat="server">
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
    <title>Entel</title>
    <!-- Open Sans - Body-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,400i,600,600i,700,700i" rel="stylesheet">
    <!-- Heebo - Body-->
    <link href="https://fonts.googleapis.com/css?family=Heebo:100,400,500,700" rel="stylesheet">
    <!-- #### ICON ####-->
    <link rel="icon" href="images/favicon.ico">
    <!-- Bootstrap css - css base-->
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="./css/fontawesome-all.min.css">
    <!-- Main css - css personalizacion-->
    <link rel="stylesheet" href="./css/main.css">
    <!--  css Tabla-->
    <meta name="description" content="The responsive tables jQuery plugin for stacking tables on small screens">

    <link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>
    <link href="./css/stacktable.css" rel="stylesheet" />
    <link href="./js/multi-selected/dist/css/bootstrap-multiselect.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%=Session["GOOGLE_ANALYTICS"] %>
</head>
<body style="background: #e8edf1;">
    <form id="form1" runat="server">
        <div id="wrapper">
            <div class="main">
                <div class="container">
                    <div class="row">
                        <asp:Literal ID="MenuInicio" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>
        <script src="./js/jquery-3.1.1.min.js"></script>
        <!-- bootstrap-->
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/bootstrap-datepicker.js"></script>
        <script src="./js/selecct-multiple.js"></script>
        <!-- iCheck-->
        <!-- script(src="js/icheck.min.js")-->
        <!-- Bootstrap Select-->
        <!-- script(src="js/bootstrap-select.min.js")-->
        <!-- script(src="js/bootstrap-select-es.min.js")-->
        <!-- Main Script-->
        <script src="./js/main.js"></script>
        <script src="./js/cz_main.js" type="text/javascript"></script>
        <script src="./js/JSModule.js"></script>
        <script src="./js/Validacion.js"></script>
        <!-- Scripts personalizados-->
        <!-- Scripts select multiple-->
        <script type="text/javascript" src="./js/multi-selected/dist/js/bootstrap-multiselect.js"></script>
    </form>
</body>
</html>
