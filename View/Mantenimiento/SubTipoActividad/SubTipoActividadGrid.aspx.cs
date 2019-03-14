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

public partial class Mantenimiento_SubTipoActividad_SubTipoActividadGrid : System.Web.UI.Page
    {
        List<SubTipoActividadBean> lst = new List<SubTipoActividadBean>();
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
                    String Codigo = dataJSON["Codigo"].ToString();
                    String Descripcion = dataJSON["Descripcion"].ToString();                    
                    String chkHabilitado = dataJSON["chkFlgHabilitado"].ToString();
                    String TipoActividad = dataJSON["tipoActividad"].ToString();
                

                //PAG
                String pagina = dataJSON["pagina"].ToString();
                    String filas = dataJSON["filas"].ToString();

                    var item = new SubTipoActividadBean
                    {
                        Codigo = Codigo,
                        Descripcion = Descripcion,
                        FlgHabilitado = chkHabilitado,
                        idtipoactividad = Int64.Parse((TipoActividad == "" ? "0" : TipoActividad)),


                        page = int.Parse(pagina),
                        rows = int.Parse(filas)
                    };
                

                    PaginateConfiguracionOportunidadBean paginate = SubTipoActividadController.GetAllPaginate(item);

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
                    string myScript = "parent.document.location.href = '../../default.aspx?acc=EXT';";

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, true);
                }
            }
        }
    }