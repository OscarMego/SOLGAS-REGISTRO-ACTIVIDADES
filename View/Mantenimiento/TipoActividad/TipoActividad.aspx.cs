using business.functions;
using Controller;
using Model.bean;
using System;
using System.Configuration;
using System.Web.Services;
using System.Web.UI;
using Tools;

public partial class Mantenimiento_TipoActividad_TipoActividad : PageController
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
            var canal = NegocioController.GetAll(new NegocioBean());
            Utility.ComboBuscar(ddlNegocio, canal, "IdNegocio", "Nombre");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }
    #region WebService
    [WebMethod]
    public static String Insert(string codigo, string nombre, int idnegocio, string meta, string oportunidad, string contacto)
    {
        try
        {
            var item = new TipoActividadBean
            {
                codigo = codigo,
                nombre = nombre,
                idNegocio = idnegocio,
                meta = meta,
                oportunidad = oportunidad,
                contacto = contacto
            };
            TipoActividadController.Insert(item);

            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :TipoActividad_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static String Update(string Id, string codigo, string nombre, string idnegocio, string meta, string oportunidad, string contacto)
    {
        try
        {
            var item = new TipoActividadBean
            {
                id = int.Parse(Id),
                codigo = codigo,
                nombre = nombre,
                idNegocio = Int64.Parse(idnegocio),
                meta = meta,
                oportunidad = oportunidad,
                contacto = contacto
            };
            TipoActividadController.Update(item);
            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :TipoActividad_Update : ");
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
                    TipoActividadController.Disabled(new TipoActividadBean { id = int.Parse(item) }
                        );
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :TipoActividad_Desactivate : ");
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
                    TipoActividadController.Activate(new TipoActividadBean { id = int.Parse(item) });
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :TipoActividad_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }




    #endregion
}