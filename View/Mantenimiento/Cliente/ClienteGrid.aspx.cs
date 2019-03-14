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

namespace View.Mantenimiento.Cliente
{
    public partial class ClienteGrid : System.Web.UI.Page
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
                    string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                    Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                    String Razon_Social = dataJSON["Razon_Social"].ToString();
                    String RUC = dataJSON["RUC"].ToString();
                    String Direccion = dataJSON["Direccion"].ToString();
                    String Referencia = dataJSON["Referencia"].ToString();
                    String IdCanal = dataJSON["IdCanal"].ToString()==String.Empty?"0": dataJSON["IdCanal"].ToString();
                    //String IdZona = dataJSON["IdZona"].ToString() == String.Empty ? "0" : dataJSON["IdZona"].ToString();
                    String chkHabilitado = dataJSON["chkFlgHabilitado"].ToString();

                    //PAG
                    String pagina = dataJSON["pagina"].ToString();
                    String filas = dataJSON["filas"].ToString();

                    var item = new ClienteBean
                    {
                        Razon_Social = Razon_Social,
                        RUC = RUC,
                        Direccion = Direccion,
                        Referencia = Referencia,
                        IdNegocio = Int64.Parse(IdCanal),
                        FlgHabilitado = chkHabilitado,

                        page = int.Parse(pagina),
                        rows = int.Parse(filas)
                    };

                    PaginateClienteBean paginate = ClienteController.GetAllPaginate(item);

                    if ((Int32.Parse(pagina) > 0) && (Int32.Parse(pagina) <= paginate.totalPages))
                    {
                        Utility.ConfiguraPaginacion(this.lbTpaginaTop, this.linkPaginaTop,
                            this.lblTFilasTop, this.linkPaginaAnteriorTop, this.linkPaginaSiguienteTop,
                            paginate.totalPages.ToString(), pagina, paginate.totalrows.ToString(),
                            ddlMostrarTop, filas);

                        Utility.ConfiguraPaginacion(this.lbTpaginaBooton, this.linkPaginaBooton,
                            this.lblTFilasBooton, this.linkPaginaAnteriorBooton, this.linkPaginaSiguienteBooton,
                            paginate.totalPages.ToString(), pagina, paginate.totalrows.ToString(),
                            ddlMostrarBooton, filas);
                        List<ClienteBean> lst = new List<ClienteBean>();
                        lst = paginate.lstResultados;
                        grdMant.DataSource = lst;
                        grdMant.DataBind();
                        grdMant.HeaderRow.TableSection = TableRowSection.TableHeader;

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
                    //string myScript = "parent.document.location.href = '../../default.aspx?acc=EXT';";
                    String htmlNoData = "<div class='col-sm-12 form-group'>" +
                                            "<img src='../../images/icons/grid/ico_grid_nodata.png' style='float: left;height: 32px;'/>" +
                                            "<p style='float: left;line-height: 32px;margin-left: 10px!important;'>No se encontraron datos para mostrar</p>" +
                                            "</div>";

                    this.divGridView.InnerHtml = htmlNoData;
                    this.divGridViewPagintatorBooton.Visible = false;
                    this.divGridViewPagintatorTop.Visible = false;

                    string myScript = "addnotify('notify', \"" + ex.Message + "\", 'registeruser');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, true);
                }
            }
        }
    }
}