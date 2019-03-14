using business.functions;
using Controller;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

public partial class Mantenimiento_Usuarios_Usuarios : PageController
{
    protected override void initialize()
    {
        if (Session["lgn_id"] == null)
        {
            Session.Clear();
            string myScript = ConfigurationManager.AppSettings["URL_LOGIN"];
            String lsScript = "parent.document.location.href = '" + myScript + "/default.aspx?acc=SES';";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
        }
        else
        {
            CargaCombos();
            if (!IsPostBack)
            {
                hdnShowRows.Value = "10";//Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_TOTAL_PAGE);
            }
        }
    }
    private void CargaCombos()
    {
        try
        {
            var perfil = PerfilController.GetAll(new PerfilBean { FlgHabilitado = "T" });
            Utility.ComboBuscar(ddlPerfil, perfil, "IdPerfil", "Descripcion");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }
    #region WebService
    [WebMethod]
    public static String Insert(string Codigo, string Nombres, string LoginUsuario, string Email, string clave, int IdPerfil, int IdCanal, int IdZona, String Vendedores, String Modificable)
    {
        try
        {
            var item = new UsuarioBean
            {
                Codigo = Codigo,
                Nombres = Nombres,
                LoginUsuario = LoginUsuario,
                Vendedores = Vendedores,
                Email = Email,
                clave = FormsAuthentication.HashPasswordForStoringInConfigFile(clave, "sha1"),
                IdPerfil = IdPerfil,
                IdCanal = IdCanal,
                IdZona = IdZona,
                FlgActiveDirectory = Modificable
            };
            UsuarioController.Insert(item);

            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static String Update(string IdUsuario, string Codigo, string Nombres, string LoginUsuario, string Email, string clave, int IdPerfil, int IdCanal, int IdZona, String Vendedores, String CamClave, String Modificable)
    {
        try
        {
            var item = new UsuarioBean
            {
                IdUsuario = int.Parse(IdUsuario),
                Codigo = Codigo,
                Nombres = Nombres,
                Email = Email,
                LoginUsuario = LoginUsuario,
                Vendedores = Vendedores,
                clave = FormsAuthentication.HashPasswordForStoringInConfigFile(clave, "sha1"),
                IdPerfil = IdPerfil,
                EditPass = CamClave,
                FlgActiveDirectory = Modificable,
                IdCanal=IdCanal,
                IdZona=IdZona
                
            };
            UsuarioController.Update(item);
            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Update : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static void Desactivate(String codigos)
    {
        try
        {
            foreach (var item in codigos.Split('|'))
            {
                if (!item.Equals(""))
                {
                    UsuarioController.Desactivate(new UsuarioBean { IdUsuario = int.Parse(item) }
                        );
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Desactivate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static void Activate(String codigos)
    {
        try
        {
            foreach (var item in codigos.Split('|'))
            {
                if (!item.Equals(""))
                {
                    UsuarioController.Activate(new UsuarioBean { IdUsuario = int.Parse(item) });
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultPerfil()
    {
        List<ListItem> lstComboBean = PerfilController.GetAll(new PerfilBean { FlgHabilitado = "T" }).Select(x => new ListItem()
        {
            Text = x.Nombre,
            Value = x.Descripcion.ToString(),
            Selected = true,
        }).ToList();
        return lstComboBean;
    }

    [WebMethod]
    public static List<ListItem> ComboMultVendedores(String idUsuario)
    {
        try
        {
            List<ListItem> lstComboBean = UsuarioController.GetVendedores(idUsuario).Select(x => new ListItem()
            {
                Text = x.Nombres,
                Value = x.IdUsuario.ToString(),
                Selected = (x.Seleccion == "T" ? true : false),
            }).ToList();
            return lstComboBean;
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Oportunidad_Coordinador : ");
            //return new List<ListItem>();
            throw new Exception(ex.Message);
        }
    }
    #endregion
}