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

public partial class Mantenimiento_Usuarios_UsuariosGrid : System.Web.UI.Page
{
    List<UsuarioBean> lst = new List<UsuarioBean>();
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
                String codigo = dataJSON["Codigo"].ToString();
                String Login = dataJSON["Login"].ToString();
                String nombres = dataJSON["Nombres"].ToString();
                String chkHabilitado = dataJSON["chkFlgHabilitado"].ToString();
                String Perfiles = dataJSON["Perfiles"].ToString();
                
                //PAG
                String pagina = dataJSON["pagina"].ToString();
                String filas = dataJSON["filas"].ToString();

                var item = new UsuarioBean
                {
                    Codigo = codigo,
                    LoginUsuario = Login,
                    FlgHabilitado = chkHabilitado,
                    Nombres = nombres,
                    IdPerfil = int.Parse((Perfiles == "" ? "0" : Perfiles)),
                    page = int.Parse(pagina),
                    rows = int.Parse(filas)
                };

                PaginateUsuarioBean paginate = UsuarioController.GetAllPaginate(item);

                if ((Int32.Parse(pagina) > 0) && (Int32.Parse(pagina) <= paginate.totalPages))
                {
                    Utility.ConfiguraPaginacion(this.lbTpaginaTop, this.linkPaginaTop,
                        this.lblTFilasTop, this.linkPaginaAnteriorTop, this.linkPaginaSiguienteTop,
                        paginate.totalPages.ToString(), pagina, paginate.totalrows.ToString(),
                        ddlMostrarTop, filas);

                    Utility.ConfiguraPaginacion(this.lbTpaginaBooton, this.linkPaginaBooton,
                        this.lblTFilasBooton, this.linkPaginaAnteriorBooton, this.linkPaginaSiguienteBooton, paginate.totalPages.ToString(), pagina, paginate.totalrows.ToString(),
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