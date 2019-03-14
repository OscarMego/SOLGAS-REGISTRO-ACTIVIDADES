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

public partial class Mantenimiento_Contactos_Contactos : PageController
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
            var perfil = ClienteController.GetAll(new ClienteBean { FlgHabilitado = "T" });
            Utility.ComboBuscar(ddlCliente, perfil, "CLI_PK", "Razon_Social");

            //var zona = ZonaController.GetAll(new ZonaBean { Flag = "T" });
            //Utility.ComboBuscar(ddlZona, zona, "IdZona", "Nombre");

            var lstComboBean = ClienteController.getClienteInstalacion("").Where(x => x.Habilitado != "F").ToList();
            Utility.ComboNuevo(ddlIdInstalacion, lstComboBean, "IDClienteInstalacion", "Descripcion");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }
    #region WebService
    [WebMethod]
    public static String Insert(string Nombre, string Telefono, string Email, string Cargo, int IdCliente, int IdClienteInstalacion)
    {
        try
        {
            var item = new ContactoBean
            {
                Nombre = Nombre,
                Telefono = Telefono,
                Email = Email,
                Cargo = Cargo,
                IdCliente = IdCliente,
                IdClienteInstalacion = IdClienteInstalacion
                //IdZona = IdZona
            };
            ContactoController.Insert(item);

            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Contacto_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static String Update(int IdContacto, string Nombre, string Telefono, string Email, string Cargo, int IdCliente, int IdClienteInstalacion)
    {
        try
        {
            var item = new ContactoBean
            {
                IdContacto = IdContacto,
                Nombre = Nombre,
                Telefono = Telefono,
                Email = Email,
                Cargo = Cargo,
                IdCliente = IdCliente,
                IdClienteInstalacion = IdClienteInstalacion
            };
            ContactoController.Update(item);
            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Contacto_Update : ");
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
                    ContactoController.Disabled(new ContactoBean { IdContacto = int.Parse(item) }
                        );
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Contacto_Desactivate : ");
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
                    ContactoController.Activate(new ContactoBean { IdContacto = int.Parse(item) });
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Contacto_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static List<ListItem> ComboZonas(string idCliente, string idZona)
    {

        if (idCliente != String.Empty && !idCliente.Equals("0"))
        {
            try
            {
                List<ListItem> lstComboBean = ZonaController.getClienteZonas(idCliente).Where(x => x.Flag != "F").Select(x => new ListItem()
                {
                    Text = x.Nombre.ToString(),
                    Value = x.IdZona.ToString(),
                    Selected = (idZona == "0" ? false : (idZona == x.IdZona.ToString() ? true : false)),
                }).ToList();
                return lstComboBean;
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :" + ex);
                throw new Exception("ERROR: " + ex.Message);
            }
        }
        return new List<ListItem>();
    }

    [WebMethod]
    public static List<ListItem> ComboClienteInstalacion(string idCliente, string idInstalacion)
    {

        if (idCliente != String.Empty && !idCliente.Equals("0"))
        {
            try
            {
                List<ListItem> lstComboBean = ClienteController.getClienteInstalacion(idCliente).Where(x => x.Habilitado != "F").Select(x => new ListItem()
                {
                    Text = x.Descripcion.ToString(),
                    Value = x.IDClienteInstalacion.ToString(),
                    Selected = (idInstalacion == "0" ? false : (idInstalacion == x.IDClienteInstalacion.ToString() ? true : false)),
                }).ToList();
                return lstComboBean;
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :" + ex);
                throw new Exception("ERROR: " + ex.Message);
            }
        }
        return new List<ListItem>();
    }

    #endregion
}