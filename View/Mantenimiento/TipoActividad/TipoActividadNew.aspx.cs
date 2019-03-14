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

public partial class Mantenimiento_TipoActividad_TipoActividadNew : System.Web.UI.Page
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

                    TipoActividadBean obj = TipoActividadController.Get(new TipoActividadBean { id = int.Parse(dataJSON["codigo"].ToString()) });
                    myModalLabel.InnerText = "Editar Tipo Actividad "; //+ Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_USUARIO);
                    MtxtId.Value = obj.id.ToString();
                    //MtxtIdUsuario.Value = obj.IdUsuario.ToString();
                    MtxtCodigo.Value = obj.codigo;
                    MtxtNombre.Value = obj.nombre;
                    MtxtMeta.Value = obj.meta;

                    MddlIdNegocio.SelectedValue = obj.idNegocio.ToString();
                    if (obj.oportunidad.Equals("T"))
                    {
                        MchkOportunidad.Checked = true;
                    }
                    else
                    {
                        MchkOportunidad.Checked = false;
                    }
                    if (obj.contacto.Equals("T"))
                    {
                        MchkContacto.Checked = true;
                    }
                    else
                    {
                        MchkContacto.Checked = false;
                    }
                    MtxtCodigo.Disabled = true;

                }
                else
                {
                    myModalLabel.InnerText = "Crear Tipo Actividad ";  //+ Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_USUARIO);
                }
            }
        }
    }

    private void CargaCombos()
    {
        try
        {
            var canal = NegocioController.GetAll(new NegocioBean { Nombre = "" });
            Utility.ComboNuevo(MddlIdNegocio, canal, "IdNegocio", "Nombre");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }

}