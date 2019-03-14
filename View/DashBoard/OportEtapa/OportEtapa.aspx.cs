using business.functions;
using Controller;
using Controller.functions;
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



public partial class Reporte_OportEtapa_OportEtapa : PageController
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
            }
        }
    }
    #region WebService
    private void CargaCombos()
    {
        try
        {

            //Utility.ComboBuscar(ddlEstado, OportunidadController.GetEstado(), "Codigo", "Nombre");
            //ddlEstado.SelectedValue = "1";
            //Utility.ComboBuscar(ddlEtapa, OportunidadController.GetEtapas(""), "Codigo", "Nombre");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }
    //[WebMethod(EnableSession = true)]
    //public static dynamic reporteGrafico(String cantos, String fechaini, String fechafin, String zona, String centro)
    //{
    //    var usuarioBean = (UsuarioBean)HttpContext.Current.Session[SessionManager.USER_SESSION];

    //    var usuario = "";
    //    var perfil = "";
    //    usuario = usuarioBean.codigo;
    //    if (usuarioBean.codigoperfil == "DIR")//Director
    //    {
    //        perfil = "";
    //    }
    //    else if (usuarioBean.tipoPerfil == "CUS" && usuarioBean.flgSupervisor == "T")//Gerente de Zona
    //    {
    //        perfil = usuarioBean.codPerfil;
    //        zona = usuarioBean.codPerfil;
    //    }

    //    fechaini = Utils.getStringFechaYYMMDDHHMM(fechaini);
    //    fechafin = Utils.getStringFechaYYMMDDHHMM(fechafin);
    //    var data = ReporteController.ReporteCantoPorZona(usuario, perfil, cantos, fechaini, fechafin);
    //    var total = data[0].Sum(x => x.y);
    //    var dashCantoZona = new GraficoBean
    //    {
    //        Titulo = "Consolidados de Cantos por Zona",
    //        SubTitulo = "Total: " + total.ToString(),
    //        items = data[0],
    //        grupo = data[1],
    //    };

    //    if (usuarioBean.codigoperfil == "4")//Jefe de Venta
    //    {
    //        zona = "";
    //        centro = usuarioBean.codcliente;
    //    }

    //    var data2 = ReporteController.ReporteCantosPorCentroFinanciero(usuario, perfil, cantos, fechaini, fechafin, zona, centro);
    //    var total2 = data2[0].Sum(x => x.y);
    //    var dashCantoCentro = new GraficoBean
    //    {
    //        Titulo = "Consolidados de Cantos por Centro Financiero",
    //        SubTitulo = "Total: " + total2.ToString(),
    //        items = data2[0],
    //        grupo = data2[1],
    //    };

    //    return new { dashCantoZona = dashCantoZona, dashCantoCentro = dashCantoCentro };
    //}

    [WebMethod(EnableSession = true)]
    public static dynamic reporteGrafico(String fechaini, String fechafin, String coordinador, String responsable, String estado, String etapa, String tipoTotal)
    {
        try
        {
            String usuaSession = HttpContext.Current.Session["lgn_id"].ToString();
            fechaini = Utils.getStringFechaYYMMDDHHMM(fechaini);
            fechafin = Utils.getStringFechaYYMMDDHHMM(fechafin);
            OportunidadBean eOport = new OportunidadBean
            {
                FechaInicio = fechaini,
                FechaFin = fechafin,
                Coordinador = coordinador,
                Responsable = responsable,
                Estado = estado,
                Etapa = etapa,
                UsuSession = usuaSession,
                tipoTotal = tipoTotal
            };
            String tituloPye = "Total Oportunidades";
            if (tipoTotal == "2")
            {
                tituloPye = "Total TM Estimado";

            }
            var data = ReporteController.ReporteGraficoOportPorEtapa(eOport);
            var dashOpPorEtapas = new GraficoBean
            {
                Titulo = tituloPye,
                items = data,
            };


            return new { dashOpPorEtapas = dashOpPorEtapas };
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :OportEtapa_grafico : ");
            return new List<ListItem>();
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
            LogHelper.LogException(ex, "Error :EtapaEstado_Coordinador : ");
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
            LogHelper.LogException(ex, "Error :EtapaEstado_Coordinador : ");
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
    #endregion
}