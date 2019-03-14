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

namespace View.Mantenimiento.Cliente
{
    public partial class Cliente : PageController
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
                CargaCombo();
                if (!IsPostBack)
                {
                    hdnShowRows.Value = "10";//Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_TOTAL_PAGE);
                }
            }
        }

        private void CargaCombo()
        {
            try
            {
                //var zona = ZonaController.GetAll(new ZonaBean { Flag = "T" });
                //Utility.ComboBuscar(ddlIdZona, zona, "IdZona", "Nombre");
                var canal = NegocioController.GetAll(new NegocioBean { Nombre = "" });
                Utility.ComboBuscar(ddlIdCanal, canal, "IdNegocio", "Nombre");
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :" + this);
                throw new Exception("ERROR: " + ex.Message);
            }
        }
        #region Webservice
        [WebMethod]
        public static String Insert(String Razon_Social, String RUC, String Direccion, String Referencia, int IdNegocio, int IdRubro, int IdRegion, int IdOrganizacionVenta, int IdCanal, int IdTipo)
        {
            try
            {
                List<ClienteInstalacionBean> obj = (List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"];
                var item = new ClienteBean
                {
                    Razon_Social = Razon_Social,
                    RUC = RUC,
                    Direccion = Direccion,
                    Referencia = Referencia,
                    IdNegocio = IdNegocio,
                    IdRubro = IdRubro,
                    IdRegion = IdRegion,
                    IdOrganizacionVenta = IdOrganizacionVenta,
                    IdCanal = IdCanal,
                    IdTipo = IdTipo,
                    lstClienteInstalacion = obj
                };

                int id = ClienteController.Insert(item);
                return "OK";
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error: Cliente_Insert : ");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static String Update(String CLI_PK, String Razon_Social, String RUC, String Direccion, String Referencia, int IdNegocio, int IdRubro, int IdRegion, int IdOrganizacionVenta, int IdCanal, int IdTipo)
        {
            try
            {
                List<ClienteInstalacionBean> obj = (List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"];
                var item = new ClienteBean
                {
                    CLI_PK = int.Parse(CLI_PK),
                    Razon_Social = Razon_Social,
                    RUC = RUC,
                    Direccion = Direccion,
                    Referencia = Referencia,
                    IdNegocio = IdNegocio,
                    IdRubro = IdRubro,
                    IdRegion = IdRegion,
                    IdOrganizacionVenta = IdOrganizacionVenta,
                    IdCanal = IdCanal,
                    IdTipo = IdTipo,
                    lstClienteInstalacion = obj
                };
                ClienteController.Update(item);
                return "OK";
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error: Cliente_Update : ");
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
                        ClienteController.Activate(new ClienteBean { CLI_PK = int.Parse(item), FlgHabilitado = "F" });
                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :Cliente_Desactivate : ");
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
                        ClienteController.Activate(new ClienteBean { CLI_PK = int.Parse(item), FlgHabilitado = "T" });
                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :Cliente_Activate : ");
                throw new Exception("ERROR: " + ex.Message);
            }
        }
        [WebMethod]
        public static List<ListItem> ComboMultCliente(String idCliente)
        {
            try
            {
                List<ListItem> lstComboBean = ZonaController.getClienteZonas(idCliente).Select(x => new ListItem()
                {
                    Text = x.Nombre.ToString(),
                    Value = x.IdZona.ToString(),
                    Selected = (x.Flag == "T" ? true : false),
                }).ToList();
                return lstComboBean;
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :Oportunidad_Coordinador : ");
                return new List<ListItem>();
            }
        }
        #endregion
    }
}