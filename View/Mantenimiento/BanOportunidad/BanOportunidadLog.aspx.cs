using business.functions;
using Controller;
using Model;
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

public partial class Mantenimiento_BanOportunidad_BanOportunidadLog : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);
                String codigo = "0";
                if (dataJSON != null)
                {
                    myModalLabel.InnerText = "Historial por Edición de Oportunidad";
                    codigo = dataJSON["codigo"].ToString();
                    List<LogOportunidadBean> lOport = LogOportunidadController.getAll(codigo);
                    MtxtCodigoOportunidad.Value = codigo;
                    MtxtCliente.Value = dataJSON["cli"].ToString(); ;
                    if (lOport != null && lOport.Count > 0)
                    {
                        String strString = "<table class='grilla table' id='Table1' style='width: 100%;'>" +
                       "<thead>" +
                        "   <tr>" +
                         "      <th scope='col'>Id</th>" +
                          "     <th scope='col'>Campo Editado</th>" +
                          "     <th scope='col'>Fecha y Hora</th>" +
                          "     <th scope='col'>Responsable</th>";
                        strString += "</tr>";
                        strString += "</thead>";
                        strString += "</tbody>";
                        int row = 0;

                        foreach (var eRepor in lOport)
                        {
                            row++;
                            strString += "<tr><td align='center'  >" + row + "</td>";
                            strString += "<td align='center'  >" + eRepor.nombreCampo + "</td>";
                            strString += "<td align='center'  >" + eRepor.fechaModificacion + "</td>";
                            strString += "<td align='center'  >" + eRepor.nombreUsuario + "</td></tr>";
                        }
                        strString += "</tbody>" + "</table>";
                        litGrilla.Text = strString;
                    }
                    else
                    {
                        String htmlNoData = "<div class='gridNoData'><div class='col-sm-12 form-group'>" +
                                       "<img src='../../images/alert/ico_alert.png' style='float: left;height: 32px;'>" +
                                       "<p style='float: left;line-height: 32px;margin-left: 10px!important;'>No se encontraron datos para mostrar</p>" +
                                       "</p></div>";

                        this.divGridView.InnerHtml = htmlNoData;
                    }
                }
                else
                {
                    myModalLabel.InnerText = "Historial por Edición de Oportunidad";
                }

            }
        }
    }

}