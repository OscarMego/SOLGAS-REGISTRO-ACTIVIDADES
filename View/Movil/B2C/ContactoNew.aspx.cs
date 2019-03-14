using business.functions;
using Controller;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

namespace View.Movil.B2C
{
    public partial class ContactoNew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["lgn_id"] == null)
            {
                Session.Clear();
                String lsScript = "parent.document.location.href = '../../default.aspx?acc=SES';";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
            }
            else
            {
                Session["lstPerfiles"] = PerfilController.GetAll(new PerfilBean { FlgHabilitado = "T" });

                if (!IsPostBack)
                {
                    string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();
                    Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                    if (dataJSON != null)
                    {
                        String Codigo = dataJSON["CodCliente"].ToString();
                        CargaCombos(Codigo);
                        String codInstalacion = dataJSON["codInstalacion"].ToString();
                        if (!String.IsNullOrEmpty(codInstalacion))
                        {
                            MddlIdInstalacion.SelectedValue = codInstalacion.Trim();
                            MddlIdInstalacion.Attributes.Add("disabled", "disabled");
                        }
                    }
                }
            }
        }
        private void CargaCombos(String idCliente)
        {
            try
            {
                var lstComboBean = ClienteController.getClienteInstalacion(idCliente).Where(x => x.Habilitado != "F").ToList();
                Utility.ComboNuevo(MddlIdInstalacion, lstComboBean, "codInstalacion", "Descripcion");
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :" + this);
                throw new Exception("ERROR: " + ex.Message);
            }
        }

    }
}