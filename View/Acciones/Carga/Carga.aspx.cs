using Controller;
using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace View.Acciones.Carga
{
    public partial class Carga : PageController
    {
        private int PositionOfKMLOption = 2;
        protected override void initialize()
        {
            if (!IsPostBack)
            {
                String fileLocation = HttpContext.Current.Server.MapPath("~") + System.Configuration.ConfigurationManager.AppSettings["rutaTMP"].ToString();
                CargaController.deleteDataFiles(fileLocation);
            }
            //rblTipoCarga.Items[0].Selected = true;
        }

        private void subEscribirManuales(List<ManualBean> poLstManuales)
        {
            StringBuilder loBuilder = new StringBuilder();
            string lsRutaManual = ConfigurationManager.AppSettings["urlDocs"] + "/" + Model.bean.ManagerConfiguracion.Version + "/";
            loBuilder.Append("<ul>");

            ManualBean loManual = poLstManuales.Single<ManualBean>(s => s.Codigo.Equals("CAR"));
            loBuilder.Append("<li><a href=\"" + lsRutaManual + loManual.Url + "." + loManual.Formato + "\" >" + loManual.Descripcion + "</a></li>");
            loBuilder.Append("</ul>");
            MenuUtilitario.Text = loBuilder.ToString();
        }

        private static String tableResult(List<FileCargaBean> lista)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<table class='grilla table table-bordered table-striped' cellspacing='0' id='grdMantUsuario' style='border-collapse:collapse;'><tbody>\n");
            sb.Append("<tr><th scope='col'>Archivo</th>");
            sb.Append("<th scope='col'>Estado</th>\n");
            sb.Append("<th scope='col'>#Subidos</th>\n");
            sb.Append("<th scope='col'>#Insertados</th>\n");
            sb.Append("<th scope='col'>#Actualizados</th>\n");
            sb.Append("<th scope='col'>#Cargados</th>\n");
            sb.Append("<th scope='col'>#No Cargados</th></tr>\n");

            foreach (FileCargaBean BE in lista)
            {
                sb.Append("<tr>\n");

                sb.Append("<td align='center' valign='middle' >" + BE.archivo + "</td>\n");
                sb.Append("<td align='center' valign='middle' >" + BE.EstadoToHTML + "  <div style='display:none' class='errmsg'>Archivo inválido: " + BE.archivo + ". Por favor, revíselo. <br/>" + BE.errorExecute + "</div>   </td>\n");
                sb.Append("<td align='center' valign='middle' >" + BE.subidos + "</td>\n");
                sb.Append("<td align='center' valign='middle' >" + BE.insertados + "</td>\n");
                sb.Append("<td align='center' valign='middle' >" + BE.actualizados + "</td>\n");
                sb.Append("<td align='center' valign='middle' >" + (BE.actualizados + BE.insertados) + "</td>\n");
                sb.Append("<td align='center' valign='middle' >" + Convert.ToString(BE.subidos - (BE.actualizados + BE.insertados)) + "</td>\n");

                sb.Append("</tr>\n");
            }


            sb.Append("</tbody></table>\n");



            return sb.ToString();
        }



        [WebMethod]
        public static String ejecutarArchivoXLS(String Tipo)
        {
            String fileLocation = HttpContext.Current.Server.MapPath("~") + System.Configuration.ConfigurationManager.AppSettings["rutaTMP"].ToString();

            List<FileCargaBean> lst;
            //if (!Tipo.ToUpper().Equals("KML"))
            //{
            String XLSLocation = HttpContext.Current.Server.MapPath("~") + System.Configuration.ConfigurationManager.AppSettings["rutaDTS"].ToString();
            lst = CargaController.ejecutarArchivoXLS(fileLocation, XLSLocation, Tipo);
            //}
            //else
            //    lst = KMLController.ejecutarArchivoKML(fileLocation);
            return tableResult(lst);
        }

        [WebMethod]
        public static Boolean borrarArchivo(String filename, String fileext)
        {
            try
            {
                String fileLocation = HttpContext.Current.Server.MapPath("~") + System.Configuration.ConfigurationManager.AppSettings["rutaTMP"].ToString();
                FileInfo fileInfo = new FileInfo(fileLocation + filename + "." + fileext);
                fileInfo.Delete();
            }
            catch (Exception e)
            {
                throw new Exception("[ERROR] Se presentan errores al borrar el archivo");
            }

            return true;
        }
    }
}