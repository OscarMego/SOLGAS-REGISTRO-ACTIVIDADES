<%@ Page Language="C#" AutoEventWireup="true" Inherits="_Default" CodeBehind="Default.aspx.cs" %>
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
    <!--  css Tabla-->
    <meta name="description" content="The responsive tables jQuery plugin for stacking tables on small screens">
    
    <link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>
    <link href="css/stacktable.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <%=Session["GOOGLE_ANALYTICS"] %>
  </head>
  <body style="background-image:url(images/logo/login_bg.jpg); ">
      <form id="form1" runat="server" autocomplete="off">
    <div id="wrapper">
      <div class="main">
          <div class="container">
            <div class="row">
              <div class="col-md-offset-5 col-md-4 login">
                <div class="form-login">
                  <h1>SOLGAS</h1>
                  <div class="logologin"><img src="images/logo/logo.png"></div>
                  <label>Usuario</label>
                  <asp:TextBox type="text" id="txtUsuario" class="form-control input-sm chat-input" placeholder="Usuario" runat="server"></asp:TextBox>
                  <br/>
                  <label>Password</label>
                  <asp:TextBox id="txtClave" class="form-control input-sm chat-input" placeholder="password" TextMode="Password" runat="server"></asp:TextBox>
                    <asp:HiddenField ID="txtmsg" runat="server" />
                    
                   <div class="controls">
                    <label class="checkbox inline" for="rememberme-0">
                      <%--<input type="checkbox" name="rememberme" id="rememberme-0" value="Remember me">
                        Si olvidaste tu contraseña <a class="cont" href="#">haz click aquí</a>--%>
                    </label>
                   </div>
                  <div class="wrapper login">
                    <span class="group-btn">
                        <asp:Button ID="btnIngresar" class="btn btn-danger" runat="server" Text="Ingresar" OnClick="btnIngresar_Click" />
                        
                    </span>
                  </div>


                </div>
              </div>
            </div>
          </div>
      </div>
    </div>
    <!-- Modals-->
    <!-- jquery-->
    <script src="js/jquery-3.1.1.min.js"></script>
    <!-- bootstrap-->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/selecct-multiple.js"></script>
    <!-- iCheck-->
    <!-- script(src="js/icheck.min.js")-->
    <!-- Bootstrap Select-->
    <!-- script(src="js/bootstrap-select.min.js")-->
    <!-- script(src="js/bootstrap-select-es.min.js")-->
    <!-- Main Script-->
    <script src="js/main.js"></script>
    <!-- Scripts personalizados-->
    <!-- Scripts select multiple-->

    <script src="js/ckeckbox.js"></script>
          <script src="js/cz_main.js" type="text/javascript"></script>
          </form>
      <script>
          $(document).ready(function () {
              if ($("#txtmsg").val()!="") {
                  addnotify("alert", $("#txtmsg").val(), "usernregister");
              }
              
          });
      </script>
  </body>
</html>
