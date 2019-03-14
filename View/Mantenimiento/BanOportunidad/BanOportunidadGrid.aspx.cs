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
    public partial class BanOportunidadGrid : System.Web.UI.Page
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

                    String cliente = dataJSON["Cliente"].ToString();
                    String coordinador = dataJSON["Coordinador"].ToString();
                    String responsable = dataJSON["Responsable"].ToString();
                    String etapa = dataJSON["Etapa"].ToString();
                    String estado = dataJSON["Estado"].ToString();

                    String chkHabilitado = dataJSON["chkFlgHabilitado"].ToString();
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
                        Cliente = cliente,
                        Coordinador = coordinador,
                        Responsable = responsable,
                        Etapa = etapa,
                        Estado = estado,
                        UsuSession = usuaSession,
                        FlgHabilitado = chkHabilitado,
                        //AllIdPerfil = Perfiles,
                        page = int.Parse(pagina),
                        rows = int.Parse(filas)
                    };

                    PaginateOportunidadBean paginate = OportunidadController.GetAllPaginate(item);

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

                        litGrilla.Text = DibujarTabla(lst, chkHabilitado);


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
        public String DibujarTabla(List<OportunidadBean> lst, String chkHabilitado)
        {
            String strString = "<table class='grilla table' id='Table1' style='width: 100%;'>" +
                       "<thead>" +
                        "   <tr>" +
                         "      <th scope='col'>Código</th>" +
                          "     <th scope='col'>Vendedor</th>" +
                          "     <th scope='col'>Fecha Registro</th>" +
                          "     <th scope='col'>Cliente</th>" +
                          "     <th scope='col'>Rubro</th>" +
                        "     <th scope='col'>Etapa</th>";


            foreach (var col in lst[0].columnasDinamicas)
            {
                strString += "     <th scope='col' >" + col.Codigo + "</th>";
            }
            strString += "     <th scope='col' ><img src='../../images/icons/grid/log-title.png' style='width: 13px;'></img></th>";
            strString += "     <th scope='col' ><i class='far fa-file-alt'></i></button></th>";
            strString += "     <th scope='col' ><i class='fas fa-history'></i></button></th>";
            strString += "     <th scope='col' ><i class='fas fa-pencil-alt'></i></th>";
            strString += "     <th scope='col' ><i class='fa fa-trash-alt'></i></button></th>";
            strString += "     <th scope='col' ><i class='fas fa-times-circle'></i></th>";
            strString += "</tr>";
            strString += "</thead>";
            strString += "</tbody>";
            int row = 0;
            foreach (var eRepor in lst)
            {
                String btnLogOpor = "", btnHisto = "", btnEtapa = "", btnEditar = "", btnEliminar = "", btnCerrarOportunidad = "";
                String btnLogOporMv = "", btnHistoMv = "", btnEtapaMv = "", btnEditarMv = "", btnEliminarMv = "", btnCerrarOportunidadMv = "";

                //Log Oportunidad
                btnLogOporMv = "<button type='button' class='btn nuevo movil log-oportunidad' title='Historial de edición de oportuniades'" +
                                   "cod='" + eRepor.Codigo + "' cli='" + eRepor.Cliente + "'>" +
                                   "<img src='../../images/icons/grid/log-64.png'  style='width: 13px;'></img>" +
                              "</button>";

                btnLogOpor = "<button type='button' class='btn log-oportunidad nuevo' title='Historial de edición de oportuniades'" +
                                    "cod='" + eRepor.Codigo + "' cli='" + eRepor.Cliente + "'>" +
                                    "<img src='../../images/icons/grid/log-64.png'  style='width: 13px;'></img>" +
                               "</button>";

                //Historial
                btnHistoMv = "<button type='button' class='btn nuevo movil historial' title='Historial'" +
                                    "cod='" + eRepor.Codigo + "'>" +
                                    "<i class='far fa-file-alt'></i>" +
                               "</button>";
                btnHisto = "<button type='button' class='btn historial nuevo' title='Historial' " +
                "cod='" + eRepor.Codigo + "'>" +
                "<i class='far fa-file-alt'></i></button>";
                //Cambio de etapa y editar etapa actual                
                if (chkHabilitado == "T" && eRepor.Cerrar == "T")
                {
                    btnEtapaMv = "<button type='button' class='btn nuevo movil cametapa' title='Cambio de Etapa'" +
                                    "cod='" + eRepor.Codigo + "'>" +
                                    "<i class='fas fa-history'></i>" +
                               "</button>";

                    btnEtapa = "<button type='button' class='btn cametapa nuevo' title='Cambio de Etapa' " +
                     "cod='" + eRepor.Codigo + "'>" +
                    "<i class='fas fa-history'></i></button>";
                }
                //Editar
                if (chkHabilitado == "T" && eRepor.Cerrar == "T" || eRepor.IdEstadoActual != "2")
                {
                    btnEditar = "<button type='button' class='btn nuevo editItemReg' title='Editar' " +
                     "cod='" + eRepor.Codigo + "'>" +
                    "<i class='fas fa-pencil-alt'></i></button>";
                }
                if (eRepor.IdEstadoActual != "3")
                {
                    btnEditarMv = "<button type='button' class='btn nuevo movil editItemReg' title='Editar'" +
                                     "cod='" + eRepor.Codigo + "'>" +
                                     "<i class='fas fa-pencil-alt'></i>" +
                                "</button>";
                }
                //Eliminar

                if (chkHabilitado == "T" && eRepor.eliminar == "T")
                {
                    btnEliminar += "<button type='button' class='btn nuevo delItemReg' title='Eliminar' " +
                    "cod='" + eRepor.Codigo + "'>" +
                    "<i class='fa fa-trash-alt'></i></button>";

                    btnEliminarMv =
                                    "<button type='button' class='btn nuevo movil delItemReg' title='Eliminar'" +
                                        "cod='" + eRepor.Codigo + "'>" +
                                        "<i class='fa fa-trash-alt'></i>" +
                                   "</button>";
                }

                //Cerrar Oportunidad
                if (chkHabilitado == "T" && eRepor.Cerrar == "T")
                {
                    btnCerrarOportunidadMv = "<button type='button' class='btn nuevo movil cerrarItemReg' title='Cerrar Oportunidad'" +
                                       "cod='" + eRepor.Codigo + "'>" +
                                       "<i class='fas fa-times-circle'></i>" +
                                  "</button>";
                    btnCerrarOportunidad += "<button type='button' class='btn nuevo cerrarItemReg' title='Cerrar Oportunidad' " +
                    "cod='" + eRepor.Codigo + "'>" +
                    "<i class='fas fa-times-circle'></i></button>";
                }


                strString += "<tr " + (row++ % 2 == 0 ? "" : "class='file'") + ">" +
                            "<td align='center'  >" + eRepor.Codigo + "" +
                            //Historial
                            "<div class='btnmovil'>" +
                            btnLogOporMv +
                            "</div>" +
                            //Historial
                            "<div class='btnmovil'>" +
                            btnHistoMv +
                            "</div>" +
                            //Cambio de etapa y editar etapa actual
                            "<div class='btnmovil'>" +
                            btnEtapaMv +
                            "</div>" +
                            //Editar
                            "<div class='btnmovil'>" +
                            btnEditarMv +
                            "</div>" +
                            //Eliminar
                            "<div class='btnmovil'>" +
                            btnEliminarMv +
                            "</div>" +
                            //Cerrar Oportunidad
                            "<div class='btnmovil'>" +
                            btnCerrarOportunidadMv +
                            "</div>" +
                            "</td>" +
                            "<td align='center'  >" + eRepor.Responsable + "</td>" +
                            "<td align='center'  >" + eRepor.FechaRegistro + "</td>" +
                            "<td align='center'  >" + eRepor.Cliente + "</td>" +
                            "<td align='center'  >" + eRepor.Rubro + "</td>" +
                            "<td align='center'  >" + eRepor.Etapa + "</td>";
                foreach (var ecd in eRepor.columnasDinamicas)
                {
                    strString += "<td align='center' >" + ecd.Nombre + "</td>";
                }
                //Log de cmavbios de oportunidades
                strString += "<td  class='tbmovil'>";
                strString += btnLogOpor;
                strString += "</td>";
                //Historial
                strString += "<td  class='tbmovil'>";
                strString += btnHisto;
                strString += "</td>";

                //Cambio de etapa y editar etapa actual
                strString += "<td  class='tbmovil'>";
                strString += btnEtapa;

                strString += "</td>";

                //Editar
                strString += "<td  class='tbmovil'>";
                strString += btnEditarMv;
                strString += "</td>";

                //Eliminar
                strString += "<td  class='tbmovil'>";
                strString += btnEliminarMv;
                strString += "</td>";

                //Cerrar Oportunidad
                strString += "<td  class='tbmovil'>";
                strString += btnCerrarOportunidad;

                strString += "</td>";

                strString += "</tr>";
            }

            strString += "</tbody>" + "</table>";
            return strString;
        }
    }
}