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

public partial class Mantenimiento_Contactos_ContactosNew : System.Web.UI.Page
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
            //CargaCombos();
            if (!IsPostBack)
            {
                string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                if (dataJSON != null)
                {

                    ContactoBean obj = ContactoController.Get(new ContactoBean { IdContacto = int.Parse(dataJSON["codigo"].ToString()) });
                    myModalLabel.InnerText = "Editar Contacto";// + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_CONTACTO);
                    CargaCombos(obj.IdCliente.ToString());
                    MtxtIdContacto.Value = obj.IdContacto.ToString();
                    MtxtNombre.Value = obj.Nombre.ToString();
                    MtxtTelefono.Value = obj.Telefono;
                    MtxtEmail.Value = obj.Email;
                    MtxtCargo.Value = obj.Cargo;
                    hddIdInstalacion.Value = obj.codInstalacion;
                    MtxtCliente.Value = obj.Cliente.ToString();
                    MhdiCodClie.Value = obj.IdCliente.ToString();
                    //MhdiCodClieIns.Value = obj.IdClienteInstalacion.ToString();
                    MddlIdInstalacion.SelectedValue = obj.codInstalacion.ToString();


                }
                else
                {
                    myModalLabel.InnerText = "Crear Contacto";// + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_CONTACTO);
                }
            }
        }
    }

    private void CargaCombos(String idCliente)
    {
        try
        {
            //var lstComboBean = ZonaController.getClienteZonas(idCliente).Where(x => x.Flag != "F").ToList();
            var lstComboBean = ClienteController.getClienteInstalacion(idCliente).Where(x => x.Habilitado != "F").ToList();
            //Utility.ComboNuevo(MddlIdInstalacion, lstComboBean, "IdZona", "Nombre");
            Utility.ComboNuevo(MddlIdInstalacion, lstComboBean, "codInstalacion", "Descripcion");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static ContactoBean ObtenerClienteId(string Id)
    {
        Int64 vID = 0;
        if (Id == "")
            vID = 0;
        else vID = Int64.Parse(Id);
        ContactoBean obj = ContactoController.GetClienteId(vID);
        return obj;
    }

}