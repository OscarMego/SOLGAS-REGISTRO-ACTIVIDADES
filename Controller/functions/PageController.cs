using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model.bean;
using System.Configuration;
using System.IO;
using System.Web;
using System.Web.Security;
using Model;
using Controller;


public abstract class PageController : System.Web.UI.Page
{

    abstract protected void initialize();

    protected void Page_Load(object sender, EventArgs e)
    {
        bool retorno = false;
        //if (!fnValidarAccesoRemoto())
        //{
        retorno = validateSession();
        //}
        //else
        //{
        //    retorno = (GeneralController.fnValidarIntegridad() && fnLoginRemoto());
        //}

        if (!retorno)
        {
            string myScript = ConfigurationManager.AppSettings["URL_LOGIN"];
            myScript = "parent.parent.document.location.href = '" + myScript + "/default.aspx?acc=EXT&tipo=PAGECONTROLLER" + "&validateSession=" + validateSession() + "';";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, true);

        }
        else
        {
            initialize();
        }
    }

    public Boolean fnValidarPerfilMenu(String codMenu, Enumerados.FlagPermisoPerfil permiso)
    {
        Boolean retorno = false;
        try
        {
            switch (permiso)
            {
                case Enumerados.FlagPermisoPerfil.VER:
                    retorno = ((Dictionary<String, RolBean>)Session["lgn_perfilmenu"])[codMenu].FlgVer.Equals(Enumerados.FlagHabilitado.T.ToString());
                    break;
                case Enumerados.FlagPermisoPerfil.EDITAR:
                    retorno = ((Dictionary<String, RolBean>)Session["lgn_perfilmenu"])[codMenu].FlgEditar.Equals(Enumerados.FlagHabilitado.T.ToString());
                    break;
                case Enumerados.FlagPermisoPerfil.CREAR:
                    retorno = ((Dictionary<String, RolBean>)Session["lgn_perfilmenu"])[codMenu].FlgCrear.Equals(Enumerados.FlagHabilitado.T.ToString());
                    break;
                case Enumerados.FlagPermisoPerfil.ELIMINAR:
                    retorno = ((Dictionary<String, RolBean>)Session["lgn_perfilmenu"])[codMenu].FlgEliminar.Equals(Enumerados.FlagHabilitado.T.ToString());
                    break;
            }
        }
        catch (Exception)
        {
            retorno = false;
        }
        return retorno;
    }

    private bool validateSession()
    {
        return (Session["lgn_id"] == null) ? false : true;
    }

    private Boolean fnValidarAccesoRemoto()
    {
        if (Request.UrlReferrer != null && ConfigurationManager.AppSettings["NSERVICES_INSTANCIA_PADRE"] != null)
        {
            foreach (string hijo in ConfigurationManager.AppSettings["NSERVICES_INSTANCIA_PADRE"].Split(';'))
            {
                string[] arrSegmentosOrigen = Request.UrlReferrer.AbsoluteUri.Split('/');
                StringBuilder segmentos = new StringBuilder();
                for (int i = 0; i < arrSegmentosOrigen.Length - 1; i++)
                {
                    segmentos.Append(arrSegmentosOrigen[i]);
                }
                string rutaOrigen = segmentos.ToString();
                string[] arrSegmentosPadre = hijo.Split('/');
                StringBuilder segmentosPadre = new StringBuilder();
                for (int i = 0; i < arrSegmentosPadre.Length - 1; i++)
                {
                    segmentosPadre.Append(arrSegmentosPadre[i]);
                }
                return rutaOrigen.ToString().ToUpper().Equals(segmentosPadre.ToString().ToUpper());
            }
            return false;
        }
        else
        {
            return false;
        }
    }

    private bool fnLoginRemoto()
    {
        StreamReader stream = new StreamReader(Request.InputStream);
        string entrada = stream.ReadToEnd();
        bool retorno = false;
        if (!entrada.Equals(""))
        {
            entrada = entrada.Substring(2);
            string[] usuarioPassword = HttpUtility.UrlDecode(entrada).Split(new char[] { '|', '@', '|' });

            String pwcrypt = FormsAuthentication.HashPasswordForStoringInConfigFile(usuarioPassword[1], "sha1");

            if (subLogin(usuarioPassword[0], pwcrypt))
            {
                HttpCookie loCookieUsr = new HttpCookie("usr");
                loCookieUsr.Value = usuarioPassword[0];

                HttpCookie loCookiePsw = new HttpCookie("psw");
                loCookiePsw.Value = usuarioPassword[1];

                Response.Cookies.Add(loCookieUsr);
                Response.Cookies.Add(loCookiePsw);

                //Response.Cookies["usr"].Value = usuarioPassword[0];
                //Response.Cookies["psw"].Value = usuarioPassword[1];
                retorno = true;
            }
        }
        return retorno;
    }

    public virtual bool subLogin(String usuario, String password)
    {
        return false;
    }
}