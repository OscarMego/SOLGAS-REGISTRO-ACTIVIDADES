using business.functions;
using Controller;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

public partial class Mantenimiento_GrupoDetalle_GrupoDetalleNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
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
                string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                if (dataJSON != null)
                {

                    GrupoDetalleBean obj = GrupoDetalleController.Get(new GrupoDetalleBean { IdGrupoDetalle = int.Parse(dataJSON["codigo"].ToString()) });
                    myModalLabel.InnerText = "Editar " + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_GENERAL);

                    hdIdGrupoDetalle.Value = obj.IdGrupoDetalle.ToString();
                    MtxtCodigo.Value = obj.Codigo;
                    MtxtNombre.Value = obj.Nombre;
                    MddlGrupo.SelectedValue = obj.IdGrupo.ToString();

                    MtxtCodigo.Disabled = true;
                    MddlGrupo.Enabled = false;

                }
                else
                {
                    myModalLabel.InnerText = "Crear " + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_GENERAL);
                }
            }
        }
    }

    private void CargaCombos()
    {
        try
        {

            Utility.ComboNuevo(MddlGrupo, GrupoController.GetAllPaginate(new GrupoBean { FlgHabilitado = "T", page = 0, rows = 1 }).lstResultados, "IDGrupo", "Nombre");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }
    [WebMethod]
    public static dynamic ConsultaControlCombo(String IdGrupo, String IdGrupoDetalle)
    {
        var Result = GrupoDetalleController.GetAllPadre(
            new GrupoDetalleBean
            {
                IdGrupo = int.Parse((IdGrupo == "" ? "0" : IdGrupo)),
                IdGrupoDetalle = int.Parse((IdGrupoDetalle == "" ? "0" : IdGrupoDetalle))
            });
        var listResult = Result.Select(x => new ListItem()
            {
                Text = x.Nombre,
                Value = x.Codigo,
                Selected = (x.Selecc == "T" ? true : false),
            }).ToList(); ;
        String Padre = "";
        if (listResult.Count > 0)
        {
            Padre = Result[0].Grupo;
        }
        return new { padre = Padre, d = listResult };
    }
    [WebMethod]
    public static String ConsultaNombrePadre(String IdGrupo, String IdGrupoDetalle)
    {
        var listResult = GrupoDetalleController.GetAllPadre(
            new GrupoDetalleBean
            {
                IdGrupo = int.Parse((IdGrupo == "" ? "0" : IdGrupo)),
                IdGrupoDetalle = int.Parse((IdGrupoDetalle == "" ? "0" : IdGrupoDetalle))
            });
        if (listResult.Count>0)
        {
            return listResult[0].Grupo;
        }

        return "";
    }
}