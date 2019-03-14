using business.functions;
using Controller;
using Model;
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

public partial class Mantenimiento_Zonas_Zonas : PageController
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
            if (!IsPostBack)
            {
                hdnShowRows.Value = "10";//Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_TOTAL_PAGE);
            }
        }
    }
  
    #region WebService
    [WebMethod]
    public static String Insert(string Codigo, string Nombre)
    {
        try
        {
            var item = new ZonaBean
            {
                Codigo = Codigo,
                Nombre = Nombre,                
            };
            ZonaController.Insert(item);

            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Zona_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static String Update(string IdZona, string Codigo, string Nombre)
    {
        try
        {
            var item = new ZonaBean
            {
                IdZona = int.Parse(IdZona),
                Codigo = Codigo,
                Nombre = Nombre,
               
            };
            ZonaController.Update(item);
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
                    ZonaController.Disabled(new ZonaBean { IdZona = int.Parse(item) }
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
                    ZonaController.Activate(new ZonaBean { IdZona = int.Parse(item) });
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }   
    #endregion
}