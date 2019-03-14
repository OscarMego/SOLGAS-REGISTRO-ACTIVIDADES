using business.functions;
using Controller;
using Model;
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

public partial class Mantenimiento_General_GeneralNew : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                if (dataJSON != null)
                {

                    GeneralTipoBean obj = GeneralTipoController.Get(new GeneralTipoBean { IdGeneral = int.Parse(dataJSON["codigo"].ToString()), Codigo = dataJSON["codigo"].ToString() });
                    myModalLabel.InnerText = "Editar General";

                    MtxtIdGeneral.Value = obj.IdGeneral.ToString();
                    MddlIdTipo.SelectedValue = obj.IdTipo.ToString();
                    MtxtCodigo.Value = obj.Codigo;
                    MtxtNombre.Value = obj.Nombre;
                    MtxtCodigo.Disabled = true;

                }
                else
                {
                    myModalLabel.InnerText = "Crear General";
                }
            }
        }
    }
}