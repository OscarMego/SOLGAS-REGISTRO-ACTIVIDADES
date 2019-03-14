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



public partial class Reporte_EtapaEstado_EtapaEstado : PageController
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
            String tituloPye = "Etapas por Estado";
            if (tipoTotal == "2")
            {
                tituloPye = "Total TM Estimado";

            }
            var data = ReporteController.ReporteGraficoEstadoPorEtapa(eOport);
            var dashEtapasPorEstado = new GraficoBean
            {
                Titulo = tituloPye,
                itemsArr = data.itemsArr,
                categorias = data.categorias,
                SubTitulo = "Oportunidades",
            };


            return new { dashEtapasPorEstado = dashEtapasPorEstado };
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :EtapaEstado_grafico : ");
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