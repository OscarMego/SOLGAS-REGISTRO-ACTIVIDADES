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

namespace View.Notificacion.NotPrincipal
{
    public partial class NotPrincipal : System.Web.UI.Page
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
                try
                {
                    txtFechaInicio.Text = DateTime.Now.AddDays(-365).ToString("dd/MM/yyyy");
                    txtFechaFin.Text = DateTime.Now.ToString("dd/MM/yyyy");
                    string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                    Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                    String fechaInicio = txtFechaInicio.Text;
                    String fechaFin = txtFechaFin.Text;

                    String coordinador = "-1";
                    String responsable = "-1";
                    //String Perfiles = dataJSON["Perfiles"].ToString();
                    String usuaSession = HttpContext.Current.Session["lgn_id"].ToString();
                    //PAG
                    String pagina = "1";
                    String filas = "10";

                    var item = new OportunidadBean
                    {
                        FechaInicio = DateUtils.getStringDateYYMMDDHHMM(fechaInicio),
                        FechaFin = DateUtils.getStringDateYYMMDDHHMM(fechaFin),
                        Coordinador = coordinador,
                        Responsable = responsable,
                        UsuSession = usuaSession,
                        page = int.Parse(pagina),
                        rows = int.Parse(filas)
                    };

                    PaginateOportunidadBean paginate = OportunidadController.GetNotifiReporteAllPaginate(item);
                    if (paginate.lstResultados.Count <= 0)
                    {
                        throw new Exception("Error");
                    }
                    //if ((Int32.Parse(pagina) > 0) && (Int32.Parse(pagina) <= paginate.totalPages))
                    //{
                    //    Utility.ConfiguraPaginacion(this.lbTpaginaTop, this.linkPaginaTop,
                    //        this.lblTFilasTop, this.linkPaginaAnteriorTop, this.linkPaginaSiguienteTop,
                    //        paginate.totalPages.ToString(), pagina, paginate.totalrows.ToString(),
                    //        ddlMostrarTop, filas);

                    //    Utility.ConfiguraPaginacion(this.lbTpaginaBooton, this.linkPaginaBooton,
                    //        this.lblTFilasBooton, this.linkPaginaAnteriorBooton, this.linkPaginaSiguienteBooton, paginate.totalPages.ToString(), pagina, paginate.totalrows.ToString(),
                    //        ddlMostrarBooton, filas);


                    //    List<OportunidadBean> lObj = paginate.lstResultados;
                    //    litGrilla.Text = "<table class='grilla table' id='Table1' style='width: 100%;'>" +
                    //   "<thead>" +
                    //    "   <tr>" +
                    //     "      <th scope='col'>Cod Op</th>" +
                    //      "     <th scope='col'>Region</th>" +
                    //      "     <th scope='col'>Canal</th>" +
                    //      "     <th scope='col'>Rubro</th>" +
                    //      "     <th scope='col'>Cliente</th>" +
                    //    "     <th scope='col'>Coordinador</th>" +
                    //    "     <th scope='col'>Ejecutivo de Ventas</th>" +
                    //    "     <th scope='col'>Estado</th>" +
                    //    "     <th scope='col'>Etapa Actual</th>";
                    //    if (lObj.Count > 0)
                    //    {

                    //        foreach (var col in lObj[0].columnasDinamicas)
                    //        {
                    //            litGrilla.Text += "     <th scope='col' >" + col.Codigo + "</th>";
                    //        }

                    //    }
                    //    else
                    //    {
                    //        throw new Exception("Error");
                    //    }
                    //    litGrilla.Text += "</tr>";
                    //    litGrilla.Text += "</thead>";
                    //    litGrilla.Text += "<tbody>";
                    //    int row = 0;
                    //    foreach (var eRepor in lObj)
                    //    {
                    //        //red
                    //        litGrilla.Text += "<tr class='" + (eRepor.Retrazo == "T" ? "red" : (row++ % 2 == 0 ? "" : "file")) + "'>" +
                    //                    "<td align='center'  >" + eRepor.Codigo +
                    //                    "</td>" +
                    //                    "<td align='center'  >" + eRepor.Region + "</td>" +
                    //                    "<td align='center'  >" + eRepor.Canal + "</td>" +
                    //                    "<td align='center'  >" + eRepor.Rubro + "</td>" +
                    //                    "<td align='center'  >" + eRepor.Cliente + "</td>" +
                    //                    "<td align='center'  >" + eRepor.Coordinador + "</td>" +
                    //        "<td align='center'  >" + eRepor.Responsable + "</td>" +
                    //        "<td align='center'  >" + eRepor.Estado + "</td>" +
                    //        "<td align='center'  >" + eRepor.Etapa + "</td>";

                    //        foreach (var ecd in eRepor.columnasDinamicas)
                    //        {
                    //            litGrilla.Text += "<td align='center' >" + ecd.Nombre + "</td>";
                    //        }

                    //        litGrilla.Text += "</tr>";
                    //    }

                    //    litGrilla.Text += "</tbody>" + "</table>";
                    //}
                    //else
                    //{
                    //    throw new Exception("Error");
                    //}
                }
                catch (Exception ex)
                {
                    LogHelper.LogException(ex, "Error :" + this);

                    //throw new Exception("Error");
                }
            }
        }
        #region WebService
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

        #endregion
    }
}