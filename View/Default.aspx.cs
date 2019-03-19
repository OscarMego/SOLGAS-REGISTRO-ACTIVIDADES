using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.bean;
using Controller;
using Controller.functions;
using System.Configuration;
using System.Text;
using System.Web.Security;
using System.Net;
using System.Web.Script.Serialization;
using System.IO;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //try
        //{
        //    Session.Clear();
        //Session.Abandon();
        //}
        //catch (Exception)
        //{
        //}
        subInicializarAnalytics();

        String accion = Request["acc"];

        if (accion == null)
        { accion = ""; }
        if (accion.Equals("RIV") || accion.Equals("RTM"))
        {
            Session["acc"] = accion;
        }
        //if (accion.Equals("SES"))
        //{
        //    this.txtmsg.Text = "<script>window.onload = function() {addnotify(\"alert\", \"Su sesion ha expirado, ingrese nuevamente.\", \"usernregister\");};</script>";
        //}

        //if (accion.Equals("EXT"))
        //{
        //    this.txtmsg.Text = "<script>window.onload = function() {addnotify(\"alert\", \"Ha cerrado sesión satistactoriamente.\", \"usernregister\");};</script>";
        //}

        GeneralController.subInicializarConfiguracion();
    }

    private void subInicializarAnalytics()
    {
        if (ConfigurationManager.AppSettings["ID_ANALYTICS"] != null && !ConfigurationManager.AppSettings["ID_ANALYTICS"].Trim().Equals(""))
        {
            //inicializar analytics
            StringBuilder loAnal = new StringBuilder();
            loAnal.Append("<script>");
            loAnal.Append("(function (i, s, o, g, r, a, m) {\n");
            loAnal.Append("i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {\n");
            loAnal.Append("(i[r].q = i[r].q || []).push(arguments)\n");
            loAnal.Append("}, i[r].l = 1 * new Date(); a = s.createElement(o),\n");
            loAnal.Append("m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)\n");
            loAnal.Append("})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');\n");
            loAnal.Append("ga('create', '");
            loAnal.Append(ConfigurationManager.AppSettings["ID_ANALYTICS"]);
            loAnal.Append("', { 'cookieDomain': 'auto' });\n");
            loAnal.Append("ga('send', 'pageview');\n");
            loAnal.Append("</script>");
            Session["GOOGLE_ANALYTICS"] = loAnal.ToString();
        }
        else
        {
            Session["GOOGLE_ANALYTICS"] = "";
        }
    }

    protected void btnIngresar_Click(object sender, EventArgs e)
    {
        try
        {
            String login = this.txtUsuario.Text;
            String clave = this.txtClave.Text;

            String pwcrypt = FormsAuthentication.HashPasswordForStoringInConfigFile(clave, "sha1");

            if (GeneralController.fnValidarIntegridad())
            {
                UsuarioBean bean = new UsuarioBean();
                try
                {
                    bean = UsuarioController.validarUsuario(login, pwcrypt,"F");
                }
                catch (Exception ex)
                {
                    this.txtmsg.Value = ex.Message;
                }
                
                // ConfigBean  config = GeneralController.getConfig();
                if (!bean.Codigo.Equals(""))
                {

                    //Session["lgn_id"] = bean.IdUsuario;
                    //Session["lgn_codigo"] = bean.Codigo;
                    //Session["lgn_login"] = bean.LoginUsuario;
                    //Session["lgn_nombre"] = bean.Nombres;
                    //Session["lgn_perfil"] = bean.IdPerfil;
                    //Session["lgn_Nomperfil"] = bean.NombrePerfil;
                    //Session["lgn_perfilmenu"] = bean.hashRol;
                    //Session["Config"] = "" ;
                    //Response.Redirect("Main.aspx");

                    //<add key="URL_WS_ACTIVE_DIRECTORY" value="http://190.216.186.94:8080/ISORest/service/user/AuthByUserPrincipalName?user=@USER&password=@PASSWORD"/>
                    if (bean.FlgActiveDirectory.Equals("T"))
                    {

                        String url = System.Configuration.ConfigurationManager.AppSettings["URL_WS_ACTIVE_DIRECTORY"].ToString() + "user=@USUARIO&password=@PASSWORD";

                        if (login.Contains("@"))
                        {
                            url = url.Replace("@USUARIO", login);
                        }
                        else
                        {
                            url = url.Replace("@USUARIO", bean.Email);
                        }


                        url = url.Replace("@PASSWORD", clave);

                        HttpWebRequest requestNIA = WebRequest.Create(url) as HttpWebRequest;
                        JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
                        StreamReader reader;
                        String Respuesta = string.Empty;
                        //Boolean Respuesta = false;

                        // Get response  

                        try
                        {

                            using (HttpWebResponse response = requestNIA.GetResponse() as HttpWebResponse)
                            {
                                reader = new StreamReader(response.GetResponseStream());
                                Respuesta = reader.ReadToEnd();


                            }


                            if (Respuesta.ToUpper().Equals("TRUE"))
                            {


                                Session["lgn_id"] = bean.IdUsuario;
                                Session["lgn_codigo"] = bean.Codigo;
                                Session["lgn_login"] = bean.LoginUsuario;
                                Session["lgn_nombre"] = bean.Nombres;
                                Session["lgn_perfil"] = bean.IdPerfil;
                                Session["lgn_perfilmenu"] = bean.hashRol;
                                Session["lgn_email"] = bean.Email;
                                Session["lgn_idcanal"] = bean.IdCanal;
                                Response.Redirect("Main.aspx");

                            }

                            else
                            {
                                txtmsg.Value = "Usuario o contraseña incorrecta";
                                //Exception ex=  new Exception("Usuario o contraseña incorrecto");
                                //HttpContext.Current.Response.Write(ExceptionUtils.getHtmlErrorPage(ex));
                                // HttpContext.Current.Response.End();
                            }
                        }
                        catch (Exception ex)
                        {
                            txtmsg.Value = "El Servicio Web de Active Directory no está disponible";

                        }
                    }
                    else
                    {
                        //bean = UsuarioController.validarUsuario(login, pwcrypt, "T");
                        try
                        {
                            bean = new UsuarioBean();
                            bean = UsuarioController.validarUsuario(login, pwcrypt, "T");
                            if (!bean.Codigo.Equals("0"))
                            {
                                Session["lgn_id"] = bean.IdUsuario;
                                Session["lgn_codigo"] = bean.Codigo;
                                Session["lgn_login"] = bean.LoginUsuario;
                                Session["lgn_nombre"] = bean.Nombres;
                                Session["lgn_perfil"] = bean.IdPerfil;
                                Session["lgn_perfilmenu"] = bean.hashRol;
                                Session["lgn_email"] = bean.Email;
                                Session["lgn_idcanal"] = bean.IdCanal;
                                Response.Redirect("Main.aspx");
                                //GeneralController.subInicializarConfiguracion();
                                //subInicializarMenu();
                            }
                            else
                            {
                                txtmsg.Value = "Usuario o contraseña incorrecta";
                            }
                        
                        }
                        catch (Exception ex)
                        {
                            this.txtmsg.Value = ex.Message;
                        }
                    }
                }
                else
                {
                    //this.txtmsg.Text = "<script>window.onload = function() {addnotify(\"alert\", \"Usuario o contraseña incorrecta\", \"usernregister\");};</script>";
                }
            }
            else
            {
                //this.txtmsg.Text = "<script>window.onload = function() {addnotify(\"alert\", \"Error de integridad en las tablas de permisos. Por favor contacte a un consultor de " + IdiomaCultura.getMensajeEncodeHTML(IdiomaCultura.WEB_OPERADOR + Controller.GeneralController.obtenerTemaActual(true)) +".\", \"usernregister\");};</script>";
            }
        }
        catch (Exception ex)
        {
            this.txtmsg.Value = "Ocurrió un error: " +  ex.Message;
            //HttpContext.Current.Response.Write(ExceptionUtils.getHtmlErrorPage(ex));
            //HttpContext.Current.Response.End();
        }

    }
}
