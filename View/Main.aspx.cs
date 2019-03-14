using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using System.Configuration;
using Model.bean;
using Controller.functions;
using System.Text;
using System.Linq;
using System.Web.Services;
using System.IO;
using System.Net;
using System.Web.Script.Serialization;

public partial class Main : PageController
{
    protected override void initialize()
    {
        String accion = Request["acc"];

        if (accion == null)
        { accion = ""; }
        string urlhome = "Menu.aspx";
        if (Session["acc"] != null && Session["acc"].ToString().Equals("RIV"))
        {
            urlhome = "Reporte/InicioVentas/InicioVentas.aspx";
        }
        else if (Session["acc"] != null && Session["acc"].ToString().Equals("RTM"))
        {
            urlhome = "Reporte/TiemposMuertos/TiemposMuertos.aspx";
        }
        else if (Session["lgn_perfil"] != null && !Session["lgn_perfil"].ToString().Equals(String.Empty))
        {
            String newUrlHome = UsuarioController.getUrlHome(Convert.ToInt32(Session["lgn_perfil"].ToString()));
            urlhome = !newUrlHome.Equals(String.Empty) ? newUrlHome : urlhome;
        }

        if (accion.Equals("ACT"))
        {
            string aplicationPath = Request.ApplicationPath;

            string entrada = Request.UrlReferrer.AbsolutePath;

            if (entrada != null && !entrada.Equals(""))
            {

                urlhome = entrada.Substring(aplicationPath.Length + 1);

            }

            String lsScript = "addnotify('notify', 'Configuracion actualizada exitosamente', 'configsatisfact');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
        }
        subInicializarMenu(urlhome);
    }

    public override bool subLogin(String usuario, String password)
    {
        UsuarioBean bean = UsuarioController.validarUsuario(usuario, password, "F");

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
            GeneralController.subInicializarConfiguracion();
            //subInicializarMenu();
            return true;




        }
        else
        {
            return false;
        }
    }

    private void subInicializarMenu(string urlhome)
    {
        Int32 liIdPerfil = 0;
        liIdPerfil = Convert.ToInt32(Session["lgn_perfil"].ToString());

        StringBuilder loMenuTop = new StringBuilder();
        StringBuilder loMenuLateral = new StringBuilder();

        List<MenuBean> loLstMenuBean = MenuController.subObtenerDatosMenu(liIdPerfil);
        if (loLstMenuBean.Count > 0)
        {

            List<MenuBean> loLstMenuBeanPadre = loLstMenuBean.Where(obj => obj.IdMenuPadre.Equals(String.Empty)).ToList();
            loMenuTop.Append("<li class=\"dropdown menuMovil\" >");
            loMenuTop.Append("<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\">");
            loMenuTop.Append("<i class=\"far fa-user\"></i>");
            loMenuTop.Append(Session["lgn_nombre"]);
            loMenuTop.Append("<b class=\"caret\"></b></a>");
            loMenuTop.Append("<ul class=\"dropdown-menu\">");

            loMenuTop.Append("<li version=\"1\"><a id=\"versionApp\">Version</a></li>");
            loMenuTop.Append("<li salir=\"1\"><a \"OnClick=\"opcSalir_Click\">Salir</a></li>");
            loMenuTop.Append("</ul>");
            loMenuLateral.Append("</li>");

            for (int i = 0; i < loLstMenuBeanPadre.Count; i++)
            {

                List<MenuBean> loLstMenuBeanHijo = loLstMenuBean.Where(obj => obj.IdMenuPadre.Equals(loLstMenuBeanPadre[i].IdMenu)).ToList();

                if (loLstMenuBeanHijo.Count > 0)
                {
                    loMenuTop.Append("<li class=\"dropdown\">");
                    loMenuTop.Append("<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\">");
                    loMenuTop.Append("<i class=\"fas fa-" + loLstMenuBeanPadre[i].UrlImagen + "\"></i>");
                    loMenuTop.Append(loLstMenuBeanPadre[i].Descripcion);
                    loMenuTop.Append("<b class=\"caret\"></b></a>");
                    loMenuTop.Append("<ul class=\"dropdown-menu\">");

                    for (int j = 0; j < loLstMenuBeanHijo.Count; j++)
                    {
                        String lsDescripcionMenuLateral = loLstMenuBeanHijo[j].Descripcion;
                        loMenuTop.Append("<li><a href=\"" + loLstMenuBeanHijo[j].Url + "\">" + loLstMenuBeanHijo[j].Descripcion + "</a></li>");
                    }
                    loMenuTop.Append("</ul>");
                    loMenuLateral.Append("</li>");
                }
            }
        }


        MenuTop.Text = loMenuTop.ToString();

        if (Session["lgn_nombre"] != null)
        { this.lbNomUsuario.Text = Session["lgn_nombre"].ToString(); }
        else
        {
            string myScript = ConfigurationManager.AppSettings["URL_LOGIN"];
            String lsScript = "parent.document.location.href = '" + myScript + "/default.aspx?acc=SES';";
            Response.Write("<script>" + lsScript + "</script>");
        }


        StreamReader stream = new StreamReader(Request.InputStream);
        string entrada = stream.ReadToEnd();
        if (entrada != null && !entrada.Equals(""))
        {
            String lsPagina = Uri.UnescapeDataString(entrada.Split('=')[1]);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "initialize", "$('#centerFrame').attr('src', '" + lsPagina + "');", true);
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "initialize", "$('#centerFrame').attr('src', '" + urlhome + "');", true);
        }
    }

    protected void opcInicio_Click(object sender, EventArgs e)
    {
        Response.Redirect("Main.aspx");
    }

    protected void opcSalir_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Default.aspx?acc=EXT");
    }

}

