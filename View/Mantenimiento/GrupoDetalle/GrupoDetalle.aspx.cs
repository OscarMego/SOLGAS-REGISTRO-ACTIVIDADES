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

public partial class Mantenimiento_GrupoDetalle_GrupoDetalle : PageController
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
                hdnShowRows.Value = "10";// Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_TOTAL_PAGE);
            }
        }
    }
    #region WebService
    [WebMethod]
    public static String Insert(String Grupo, String Codigo, String Nombre, String Padre)
    {
        try
        {
            var item = new GrupoDetalleBean
            {
                IdGrupo = int.Parse(Grupo),
                Codigo = Codigo,
                Nombre = Nombre,
                IdCodigoDetallePadre = Padre,
            };
            GrupoDetalleController.Insert(item);

            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :General_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static String Update(String Id, String Grupo, String Codigo, String Nombre, String Padre)
    {
        try
        {
            var item = new GrupoDetalleBean
            {
                IdGrupoDetalle= int.Parse(Id),
                IdGrupo = int.Parse(Grupo),
                Codigo = Codigo,
                Nombre = Nombre,
                IdCodigoDetallePadre = Padre,
            };
            GrupoDetalleController.Update(item);
            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :General_Update : ");
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
                    GrupoDetalleController.Activate(new GrupoDetalleBean { IdGrupoDetalle = int.Parse(item), FlgHabilitado="F" });
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :General_Desactivate : ");
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
                    GrupoDetalleController.Activate(new GrupoDetalleBean { IdGrupoDetalle = int.Parse(item), FlgHabilitado = "T" });
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :General_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    #endregion
    private void CargaCombos()
    {
        try
        {
            
            Utility.ComboBuscar(ddlGrupo, GrupoController.GetAllPaginate(new GrupoBean { FlgHabilitado = "T", page = 0 ,rows=1}).lstResultados, "IDGrupo", "Nombre");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }
}