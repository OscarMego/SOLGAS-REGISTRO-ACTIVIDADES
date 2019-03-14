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

public partial class Mantenimiento_General_General : PageController
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
                hdnShowRows.Value = "10";//Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.MAN_WEB_GENERAL_TIPO);
            }
        }
    }

    #region WebService
    [WebMethod]
    public static String Insert(string IdTipo, string Codigo, string Nombre)
    {
        try
        {
            var item = new GeneralTipoBean
            {
                IdTipo = int.Parse(IdTipo),
                Codigo = Codigo,
                Nombre = Nombre,
            };
            GeneralTipoController.Insert(item);

            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :General_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static String Update(string IdGeneral, string IdTipo, string Codigo, string Nombre)
    {
        try
        {
            var item = new GeneralTipoBean
            {
                IdGeneral = int.Parse(IdGeneral),
                IdTipo = int.Parse(IdTipo),
                Codigo = Codigo,
                Nombre = Nombre,

            };
            GeneralTipoController.Update(item);
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
                    GeneralTipoController.Disabled(new GeneralTipoBean { IdGeneral = int.Parse(item) }
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
                    GeneralTipoController.Activate(new GeneralTipoBean { IdGeneral = int.Parse(item) });
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