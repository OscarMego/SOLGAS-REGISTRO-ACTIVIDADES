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



public partial class Reporte_Oportunidad_Oportunidad : PageController
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
                divcoo.Disabled = true;
                txtFechaInicio.Text = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
                txtFechaFin.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtFechaEstimadaInicio.Text = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
                txtFechaEstimadaFin.Text = DateTime.Now.AddMonths(2).ToString("dd/MM/yyyy");
                hdnShowRows.Value = "10";//Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_TOTAL_PAGE);
            }
        }
    }

    private void CargaCombos()
    {
        try
        {
            Utility.ComboBuscar(ddlEstado, OportunidadController.GetEstado(), "Codigo", "Nombre");

            Utility.ComboNuevo(ddlTexportacion, new List<Combo> {
                new Combo{Codigo="1",Nombre="Resumida"},
                new Combo{Codigo="2",Nombre="Detallada"}
            }, "Codigo", "Nombre");

            ddlTexportacion.SelectedValue = "1";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }
    #region WebService
    [WebMethod]
    public static String Insert(string id, string ConfOpor, string CliExist, string RazonSocial, string Ruc, String Rubro, String Region, String Canal, String Responsable, String CodCliente, String controldinamico)
    {
        try
        {
            var lcontrol = controldinamico.Split('|');
            List<controlDinamico> lControlDin = new List<controlDinamico>();
            foreach (var control in lcontrol)
            {
                if (control != "")
                {
                    var econtrol = control.Split(';');
                    controlDinamico eControlDin = new controlDinamico
                    {
                        id = econtrol[0],
                        valor = econtrol[1]
                    };
                    lControlDin.Add(eControlDin);
                }
            }
            var usuSession = HttpContext.Current.Session["lgn_id"].ToString();
            var item = new OportunidadBean
            {
                id = id,
                ConfOpor = ConfOpor,
                CliExist = CliExist,
                RazonSocial = RazonSocial,
                Ruc = Ruc,//FormsAuthentication.HashPasswordForStoringInConfigFile(clave, "sha1"),
                Rubro = Rubro,
                Region = Region,
                Canal = Canal,
                Responsable = Responsable,
                CodCliente = CodCliente,
                lstControlDinamico = lControlDin,
                UsuSession = usuSession,
            };
           int idOp= OportunidadController.Insert(item,"0");
            return idOp.ToString();
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static String Update(string id, string ConfOpor, string CliExist, string RazonSocial, string Ruc, String Rubro, String Region, String Canal, String Responsable, String CodCliente, String controldinamico)
    {
        try
        {
            var lcontrol = controldinamico.Split('|');
            List<controlDinamico> lControlDin = new List<controlDinamico>();
            foreach (var control in lcontrol)
            {
                if (control != "")
                {
                    var econtrol = control.Split(';');
                    controlDinamico eControlDin = new controlDinamico
                    {
                        id = econtrol[0],
                        valor = econtrol[1]
                    };
                    lControlDin.Add(eControlDin);
                }
            }
            var item = new OportunidadBean
            {
                id = id,
                ConfOpor = ConfOpor,
                CliExist = CliExist,
                RazonSocial = RazonSocial,
                Ruc = Ruc,//FormsAuthentication.HashPasswordForStoringInConfigFile(clave, "sha1"),
                Rubro = Rubro,
                Region = Region,
                Canal = Canal,
                Responsable = Responsable,
                CodCliente = CodCliente,
                lstControlDinamico = lControlDin,
            };
            OportunidadController.Update(item);
            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
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
                    OportunidadController.Active(item, "F");
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
                    OportunidadController.Active(item, "T");
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static void Cerrar(String codigos)
    {
        try
        {
            foreach (var item in codigos.Split('|'))
            {
                if (!item.Equals(""))
                {
                    OportunidadController.Cerrar(item, "T");
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultCoordinador()
    {
        try
        {

            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = UsuarioController.GetOportunidadUsuarioAll(
                new UsuarioBean
                {
                    Codigo = codigo,
                    FlgHabilitado = "T",
                    IdPerfil = 5,
                    Coordinadores = "-1"
                }
                ).Select(x => new ListItem()
                {
                    Text = x.Nombres.ToString(),
                    Value = x.IdUsuario.ToString(),
                    Selected = true,
                }).ToList();
            return lstComboBean;
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Oportunidad_Coordinador : ");
            return new List<ListItem>();
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultResponsable(String coordinadores)
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = UsuarioController.GetOportunidadUsuarioAll(
                new UsuarioBean
                {
                    Codigo = codigo,
                    FlgHabilitado = "T",
                    IdPerfil = 4,
                    Coordinadores = coordinadores
                }
                ).Select(x => new ListItem()
                {
                    Text = x.Nombres.ToString(),
                    Value = x.IdUsuario.ToString(),
                    Selected = true,
                }).ToList();
            return lstComboBean;
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Oportunidad_Responsable : ");
            return new List<ListItem>();
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultEtapa()
    {
        List<ListItem> lstComboBean = OportunidadController.GetEtapas("").Select(x => new ListItem()
        {
            Text = x.Nombre,
            Value = x.Codigo.ToString(),
            Selected = true,
        }).ToList();
        return lstComboBean;
    }

    [WebMethod]
    public static List<ListItem> ComboMultEstado()
    {
        List<ListItem> lstComboBean = OportunidadController.GetEstado().Select(x => new ListItem()
        {
            Text = x.Nombre,
            Value = x.Codigo.ToString(),
            Selected = (x.Codigo.ToString() == "1" ? true : false),
        }).ToList();
        return lstComboBean;
    }

    [WebMethod]
    public static List<ListItem> ComboMultRubro()
    {
        List<ListItem> lstComboBean = OportunidadController.GetGenerales(Constantes.EnumGenerales.Rubro).Select(x => new ListItem()
        {
            Text = x.Nombre,
            Value = x.Codigo.ToString(),
            Selected = true,
        }).ToList();
        return lstComboBean;
    }

    [WebMethod]
    public static List<ListItem> ComboGeneralDinamico(String Grupo, String defaultVal)
    {
        List<ListItem> lstComboBean = OportunidadController.GetGenerales(Grupo).Select(x => new ListItem()
        {
            Text = x.Nombre,
            Value = x.Codigo.ToString(),
            Selected = (x.Codigo.ToString() == defaultVal ? true : false),
        }).ToList();
        return lstComboBean;
    }

    [WebMethod]
    public static List<OportunidadBean> ObtenerConfiguracionEtapa(String idEtapa, String IdOp)
    {
        var codigo = HttpContext.Current.Session["lgn_perfil"].ToString();
        return OportunidadController.GetConfiguracionEtapa(idEtapa, IdOp, codigo);
    }

    [WebMethod]
    public static String InsertEtapa(string id, String CambiaEtapa, String controldinamico)
    {
        try
        {
            var lcontrol = controldinamico.Split('|');
            List<controlDinamico> lControlDin = new List<controlDinamico>();
            foreach (var control in lcontrol)
            {
                if (control != "")
                {
                    var econtrol = control.Split(';');
                    controlDinamico eControlDin = new controlDinamico
                    {
                        id = econtrol[0],
                        valor = econtrol[1]
                    };
                    lControlDin.Add(eControlDin);
                }
            }
            var usuSession = HttpContext.Current.Session["lgn_id"].ToString();
            var item = new OportunidadBean
            {
                id = id,
                lstControlDinamico = lControlDin,
                UsuSession = usuSession,
                CambiaEtapa = CambiaEtapa,
            };
            OportunidadController.InsertEtapa(item);
            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }
    #endregion
}
