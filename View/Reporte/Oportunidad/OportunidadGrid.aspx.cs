using business.functions;
using Controller;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

namespace View.Mantenimiento.Oportunidad
{
    public partial class OportunidadGrid : System.Web.UI.Page
    {
        List<OportunidadBean> lst = new List<OportunidadBean>();

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
                    string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                    Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                    String fechaInicio = dataJSON["FechaInicio"].ToString();
                    String fechaFin = dataJSON["FechaFin"].ToString();
                    String fechaEstimadaInicio = dataJSON["FechaEstimadaInicio"].ToString();
                    String fechaEstimadaFin = dataJSON["FechaEstimadaFin"].ToString();
                    String codigo = dataJSON["Codigo"].ToString();

                    String coordinador = dataJSON["Coordinador"].ToString();
                    String responsable = dataJSON["Responsable"].ToString();
                    String estado = dataJSON["Estado"].ToString();
                    String etapa = dataJSON["Etapa"].ToString();
                    String rubro = dataJSON["Rubro"].ToString();
                    String cliente = dataJSON["Cliente"].ToString();
                    //String Perfiles = dataJSON["Perfiles"].ToString();
                    String usuaSession = HttpContext.Current.Session["lgn_id"].ToString();
                    //PAG
                    String pagina = dataJSON["pagina"].ToString();
                    String filas = dataJSON["filas"].ToString();

                    var item = new OportunidadBean
                    {
                        FechaInicio = DateUtils.getStringDateYYMMDDHHMM(fechaInicio),
                        FechaFin = DateUtils.getStringDateYYMMDDHHMM(fechaFin),
                        FechaEstimadaInicio = DateUtils.getStringDateYYMMDDHHMM(fechaEstimadaInicio),
                        FechaEstimadaFin = DateUtils.getStringDateYYMMDDHHMM(fechaEstimadaFin),
                        Codigo = codigo,
                        Coordinador = coordinador,
                        Responsable = responsable,
                        Estado = estado,
                        Etapa = etapa,
                        Rubro = rubro,
                        Cliente = cliente,
                        UsuSession = usuaSession,
                        //AllIdPerfil = Perfiles,
                        page = int.Parse(pagina),
                        rows = int.Parse(filas)
                    };

                    PaginateOportunidadBean paginate = OportunidadController.GetReporteAllPaginateOportunidades(item);

                    if ((Int32.Parse(pagina) > 0) && (Int32.Parse(pagina) <= paginate.totalPages))
                    {
                        Utility.ConfiguraPaginacion(this.lbTpaginaTop, this.linkPaginaTop,
                            this.lblTFilasTop, this.linkPaginaAnteriorTop, this.linkPaginaSiguienteTop,
                            paginate.totalPages.ToString(), pagina, paginate.totalrows.ToString(),
                            ddlMostrarTop, filas);

                        Utility.ConfiguraPaginacion(this.lbTpaginaBooton, this.linkPaginaBooton,
                            this.lblTFilasBooton, this.linkPaginaAnteriorBooton, this.linkPaginaSiguienteBooton, paginate.totalPages.ToString(), pagina, paginate.totalrows.ToString(),
                            ddlMostrarBooton, filas);

                        var lst = paginate.lstResultados;

                        litGrilla.Text = "<table class='grilla table' id='Table1' style='width: 100%;'>" +
                       "<thead>" +
                        "   <tr>" +
                         "      <th scope='col'>Cod Op</th>" +
                          "     <th scope='col'>Region</th>" +
                          "     <th scope='col'>Canal</th>" +
                          "     <th scope='col'>Rubro</th>" +
                          "     <th scope='col'>Cliente</th>" +
                        "     <th scope='col'>Coordinador</th>" +
                        "     <th scope='col'>Vendedor</th>" +
                        "     <th scope='col'>Estado</th>" +
                        "     <th scope='col'>Etapa Actual</th>";

                        foreach (var col in lst[0].columnasDinamicas)
                        {
                            litGrilla.Text += "     <th scope='col' >" + col.Codigo + "</th>";
                        }
                        litGrilla.Text += "<td align='center' ><i class='fas fa-search'></i></td>";
                        litGrilla.Text += "</tr>";
                        litGrilla.Text += "</thead>";
                        litGrilla.Text += "<tbody>";
                        int row = 0;
                        foreach (var eRepor in lst)
                        {
                            //red
                            litGrilla.Text += "<tr class='" + (eRepor.Retrazo == "T" ? "red" : (row++ % 2 == 0 ? "" : "file")) + "'>" +
                                        "<td align='center'  >" + eRepor.Codigo +

                                        "<div class='btnmovil'>" +
                                            "<button type='button' class='btn btndetalle nuevo movil' title='Ver Detalle' " +
                                                "cod='" + eRepor.Codigo + "'>" +
                                                "<i class='fas fa-search'></i>" +
                                           "</button>" +
                                        "</div>" +
                                        "</td>" +
                                        "<td align='center'  >" + eRepor.Region + "</td>" +
                                        "<td align='center'  >" + eRepor.Canal + "</td>" +
                                        "<td align='center'  >" + eRepor.Rubro + "</td>" +
                                        "<td align='center'  >" + eRepor.Cliente + "</td>" +
                                        "<td align='center'  >" + eRepor.Coordinador + "</td>" +
                            "<td align='center'  >" + eRepor.Responsable + "</td>" +
                            "<td align='center'  >" + eRepor.Estado + "</td>" +
                            "<td align='center'  >" + eRepor.Etapa + "</td>";

                            foreach (var ecd in eRepor.columnasDinamicas)
                            {
                                litGrilla.Text += "<td align='center' >" + ecd.Nombre + "</td>";
                            }

                            //Detalle
                            litGrilla.Text += "<td class='tbmovil'>";
                            litGrilla.Text += "<button type='button' class='btn btndetalle nuevo' title='Ver Detalle' ";
                            litGrilla.Text += "cod='" + eRepor.Codigo + "'>";
                            litGrilla.Text += "<i class='fas fa-search'></i></button>";
                            litGrilla.Text += "</td>";

                            litGrilla.Text += "</tr>";
                        }

                        litGrilla.Text += "</tbody>" + "</table>";


                        //lst = paginate.lstResultados;
                        //grdMant.DataSource = lst;
                        //grdMant.DataBind();
                        //grdMant.HeaderRow.TableSection = TableRowSection.TableHeader;
                    }
                    else
                    {
                        String htmlNoData = "<div class='gridNoData'><div class='col-sm-12 form-group'>" +
                                        "<img src='../../images/alert/ico_alert.png' style='float: left;height: 32px;'>" +
                                        "<p style='float: left;line-height: 32px;margin-left: 10px!important;'>No se encontraron datos para mostrar</p>" +
                                        "</p></div>";

                        this.divGridView.InnerHtml = htmlNoData;
                        this.divGridViewPagintatorTop.Visible = false;
                        this.divGridViewPagintatorBooton.Visible = false;
                    }

                }
                catch (Exception ex)
                {
                    LogHelper.LogException(ex, "Error :" + this);

                    String htmlNoData = "<div class='gridNoData'><div class='col-sm-12 form-group'>" +
                                        "<img src='../../images/alert/ico_alert.png' style='float: left;height: 32px;'>" +
                                        "<p style='float: left;line-height: 32px;margin-left: 10px!important;'>No se encontraron datos para mostrar</p>" +
                                        "</p></div>";

                    this.divGridView.InnerHtml = htmlNoData;
                    this.divGridViewPagintatorTop.Visible = false;
                    this.divGridViewPagintatorBooton.Visible = false;

                    string myScript = "addnotify('notify', \"" + ex.Message + "\", 'registeruser');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, true);
                }
            }
        }
    }
}