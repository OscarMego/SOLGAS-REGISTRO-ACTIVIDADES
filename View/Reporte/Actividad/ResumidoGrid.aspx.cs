using business.functions;
using Controller;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

namespace View.Mantenimiento.Oportunidad
{
    public partial class ResumidoGrid : System.Web.UI.Page
    {
        List<OportunidadBean> lst = new List<OportunidadBean>();

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
                try
                {
                    string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                    Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                    String fechaInicio = dataJSON["FechaInicio"].ToString();
                    String fechaFin = dataJSON["FechaFin"].ToString();
                    String canal = dataJSON["Canal"].ToString();
                    if (canal != string.Empty)
                    {
                        canal = canal.Remove(canal.Length - 1);
                    }
                    String zona = dataJSON["Zona"].ToString();
                    if (zona != string.Empty)
                    {
                        zona = zona.Remove(zona.Length - 1);
                    }
                    String tipoActividad = dataJSON["TipoActividad"].ToString();
                    if (tipoActividad != string.Empty)
                    {
                        tipoActividad = tipoActividad.Remove(tipoActividad.Length - 1);
                    }
                    String detalleActividad = dataJSON["DetalleActividad"].ToString();
                    if (detalleActividad != string.Empty)
                    {
                        detalleActividad = detalleActividad.Remove(detalleActividad.Length - 1);
                    }
                    String usuario = dataJSON["Usuario"].ToString();
                    if (usuario != string.Empty)
                    {
                        usuario = usuario.Remove(usuario.Length - 1);
                    }
                    String cliente = dataJSON["Cliente"].ToString();
                    if (cliente != string.Empty)
                    {
                        cliente = cliente.Remove(cliente.Length - 1);
                    }
                    String campo = dataJSON["Campo"].ToString();
                    if (campo != string.Empty)
                    {
                        campo = campo.Remove(campo.Length - 1);
                    }

                    String tipoReporte = dataJSON["TipoReporte"].ToString();
                    String usuaSession = HttpContext.Current.Session["lgn_id"].ToString();
                    //PAG
                    String pagina = dataJSON["pagina"].ToString();
                    String filas = dataJSON["filas"].ToString();

                    if (campo == string.Empty)
                    {
                        campo = "[Fecha],[Canal],[Zona],[Tipo Actividad],[Usuario],[Cliente]";
                    }

                    var item = new OportunidadBean
                    {
                        FechaInicio = DateUtils.getStringDateYYMMDDHHMM(fechaInicio),
                        FechaFin = DateUtils.getStringDateYYMMDDHHMM(fechaFin),
                        Canal = canal,
                        Zona = zona,
                        TipoActividad = tipoActividad,
                        DetalleActividad = detalleActividad,
                        Usuario = usuario,
                        Cliente = cliente,
                        Campo = campo,
                        TipoReporte = tipoReporte,
                        UsuSession = usuaSession,

                        page = int.Parse(pagina),
                        rows = int.Parse(filas)
                    };

                    PaginateOportunidadBean paginate = OportunidadController.GetReporteAllPaginate(item);

                    if (tipoReporte == "RESUMIDO")
                    {
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

                            StringBuilder strHTML = new StringBuilder();

                            strHTML.Append("<table class='grilla table' id='Table1' style='width: 100%;'>");
                            strHTML.Append("<thead>");
                            strHTML.Append("<tr>");

                            if (lst.Count > 0)
                            {
                                OportunidadBean headFields = lst[0];
                                for (int i = 0; i < headFields.columnasDinamicas.Count - 1; i++)
                                {
                                    strHTML.Append("<th scope='col'>");
                                    if (i == headFields.columnasDinamicas.Count - 2)
                                    {
                                        strHTML.Append("Detalle");
                                    }
                                    else
                                    {
                                        strHTML.Append(headFields.columnasDinamicas[i].Codigo);
                                    }

                                    strHTML.Append("</th>");
                                }
                                strHTML.Append("</th>");
                            }
                            strHTML.Append("</tr>");
                            strHTML.Append("</thead>");
                            strHTML.Append("<tbody>");

                            foreach (OportunidadBean obj in lst)
                            {
                                strHTML.Append("<tr>");
                                List<ComboBean> data = obj.columnasDinamicas;

                                for (int i = 0; i < data.Count - 1; i++)
                                {
                                    strHTML.Append("<td>");
                                    if (i == data.Count - 2)
                                    {
                                        strHTML.Append("<button type = 'button' class='btn btndetalle nuevo movil' title='Ver Detalle' " +
                                                                                      "cod='" + (data[i].Nombre) + "'>" +
                                                                                      "<i class='fas fa-search'></i>" +
                                                                                 "</button>");
                                    }
                                    else
                                    {
                                        strHTML.Append(data[i].Nombre);
                                    }
                                    strHTML.Append("</td>");
                                }
                                strHTML.Append("</tr>");
                            }

                            strHTML.Append("</tbody>");
                            strHTML.Append("</table>");

                            litGrilla.Text = strHTML.ToString();

                        }
                    }
                    else if (tipoReporte == "DETALLADO")
                    {

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
                            StringBuilder html = new StringBuilder();
                            html.Append("<table class='grilla table' id='Table1' style='width: 100%;'>" +
                           "<thead>" +
                            "   <tr>" +
                             "      <th scope='col'>Fecha</th>" +
                              "     <th scope='col'>Canal</th>" +
                              "     <th scope='col'>Zona</th>" +
                              "     <th scope='col'>Tipo Actividad</th>" +
                            //"     <th scope='col'>Detalle Actividad</th>" +
                            "     <th scope='col'>Usuario</th>" +
                            "     <th scope='col'>RUC</th>" +
                            "     <th scope='col'>Cliente</th>" +
                            "     <th scope='col'>Contacto</th>" +
                            "     <th scope='col'>Telefono</th>" +
                            "     <th scope='col'>Email</th>" +
                            "     <th scope='col'>Cargo</th>");

                            foreach (var col in lst[0].columnasDinamicas)
                            {
                                html.Append("<th scope='col' >" + col.Codigo.Replace("_IMG_", "") + "</th>");
                            }
                            html.Append("<th scope='col'>GPS</th>");
                            html.Append("</tr>");
                            html.Append("</thead>");
                            html.Append("<tbody>");
                            foreach (var eRepor in lst)
                            {
                                //red
                                html.Append("<tr>" +
                                            "<td align='center'  >" + eRepor.Fecha + "</td>" +
                                            "<td align='center'  >" + eRepor.Canal + "</td>" +
                                            "<td align='center'  >" + eRepor.Zona + "</td>" +
                                            "<td align='center'  >" + eRepor.TipoActividad + "</td>" +
                                            //"<td align='center'  >" + eRepor.DetalleActividad + "</td>" +
                                            "<td align='center'  >" + eRepor.Usuario + "</td>" +
                                            "<td align='center'  >" + eRepor.Ruc + "</td>" +
                                            "<td align='center'  >" + eRepor.Cliente + "</td>" +
                                            "<td align='center'  >" + eRepor.Contacto + "</td>" +
                                            "<td align='center'  >" + eRepor.Telefono + "</td>" +
                                            "<td align='center'  >" + eRepor.Email + "</td>" +
                                            "<td align='center'  >" + eRepor.Cargo + "</td>");

                                foreach (var ecd in eRepor.columnasDinamicas)
                                {
                                    if (ecd.Codigo.Contains("_IMG_"))
                                    {
                                        if (ecd.Nombre != null && ecd.Nombre != "")
                                        {
                                            html.Append("<td align='center'><div style='cursor:pointer' onclick='fcVerFoto(\"" + ecd.Nombre + "\");' class='verFoto'><i class='fa fa-camera'></i>Ver Foto</div></td>");
                                        }
                                        else
                                        {
                                            html.Append("<td align='center' ></td>");
                                        }
                                    }
                                    else
                                    {
                                        html.Append("<td align='center' >" + ecd.Nombre + "</td>");
                                    }
                                }
                                if (eRepor.Latitud != null && eRepor.Latitud != "" && eRepor.Latitud != "0" && eRepor.Longitud != null && eRepor.Longitud != "" && eRepor.Longitud != "0")
                                {
                                    html.Append("<td align='center'  > <a href='https://www.google.com/maps/search/?api=1&query=" + eRepor.Latitud + "," + eRepor.Longitud + "' target='_blank'><img src='../../imagery/all/icons/pin.png' style='width:30px'/></a> </td>");
                                }
                                else
                                {
                                    html.Append("<td align='center'  ></td>");
                                }

                                html.Append("</tr>");
                            }

                            html.Append("</tbody>" + "</table>");

                            litGrilla.Text = html.ToString();

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