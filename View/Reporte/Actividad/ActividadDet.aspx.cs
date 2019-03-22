using business.functions;
using Controller;
using Model;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

public partial class Reporte_Actividad_ActividadDet : System.Web.UI.Page
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
                    List<OportunidadBean> letapa = OportunidadController.GetReporteDetalle(codigo);
                    litGrillaDetalle.Text = DibujaTabla(letapa);

                }
            }
        }
    }

    public String DibujaTabla(List<OportunidadBean> lst)
    {
        String idperfil = HttpContext.Current.Session["lgn_perfil"].ToString();
        StringBuilder html = new StringBuilder();
        html.Append("<table class='grilla table' id='Table1' style='width: 100%;'>" +
       "<thead>" +
        "   <tr>" +
         "      <th scope='col'>Fecha</th>" +
          "     <th scope='col'>Negocio</th>" +
          "     <th scope='col'>Zona</th>" +
          "     <th scope='col'>Tipo Actividad</th>" +
        "     <th scope='col'>Sub Tipo de Actividad</th>" +
        "     <th scope='col'>Vendedor</th>" +
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
        if (idperfil != "4")
        {
            html.Append("<th scope='col'>GPS</th>");
        }
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
                        "<td align='center'  >" + eRepor.DetalleActividad + "</td>" +
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
            if (idperfil != "4")
            {
                if (eRepor.Latitud != null && eRepor.Latitud != "" && eRepor.Latitud != "0" && eRepor.Longitud != null && eRepor.Longitud != "" && eRepor.Longitud != "0")
                {
                    html.Append("<td align='center'  > <a href='https://www.google.com/maps/search/?api=1&query=" + eRepor.Latitud + "," + eRepor.Longitud + "' target='_blank'><img src='../../imagery/all/icons/pin.png' style='width:30px'/></a> </td>");
                }
                else
                {
                    html.Append("<td align='center'  ></td>");
                }
            }

            html.Append("</tr>");
        }

        html.Append("</tbody>" + "</table>");
        return html.ToString();
    }
}