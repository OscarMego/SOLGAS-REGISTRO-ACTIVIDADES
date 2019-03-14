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

public partial class Reporte_Oportunidad_OportunidadDet : System.Web.UI.Page
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
                    myModalLabel.InnerText = "Detalle de Tiempos por etapa";

                    codigo = dataJSON["codigo"].ToString();

                    OportunidadBean lOport = OportunidadController.GetOportunidad(
                        new OportunidadBean { IdOportunidad = codigo });


                    List<OportunidadBean> letapa = OportunidadController.GetConfiguracionEtapaLista(codigo);
                    litGrillaDetalle.Text = DibujaTabla(letapa);

                }
                else
                {
                }

            }
        }
    }

    public String DibujaTabla(List<OportunidadBean>lst)
    {
        String GenTabla = "";
        GenTabla = "<table class='grilla table' id='tableDetalle' style='width: 100%;'>" +
                       "<thead>" +
                        "   <tr>" +
                         "      <th scope='col'>Etapa</th>" +
                          "     <th scope='col'>Tiempo en Etapa Permitido</th>" +
                          "     <th scope='col'>Tiempo en Etapa Ejecutado</th>" +
                          "     <th scope='col'>Fecha Inicio</th>" +
                          "     <th scope='col'>Fecha Fin</th>";
        GenTabla += "</tr>";
        GenTabla += "</thead>";
        GenTabla += "</tbody>";

        int row = 0;
        foreach (var eRepor in lst)
        {
            GenTabla += "<tr class='" + (eRepor.Retrazo == "T" ? "red" : (row++ % 2 == 0 ? "" : "file")) + "'>" +
                        "<td align='center'  >" + eRepor.Etapa + "</td>" +
                        "<td align='center'  >" + eRepor.TiempoEtapa + "</td>" +
                        "<td align='center'  >" + eRepor.TiempoEtapaEjecutado + "</td>" +
                        "<td align='center'  >" + eRepor.FechaInicio + "</td>" +
                        "<td align='center'  >" + eRepor.FechaFin + "</td>";

            GenTabla += "</tr>";
        }

        GenTabla += "</tbody>" + "</table>";
        return GenTabla;
    }
}