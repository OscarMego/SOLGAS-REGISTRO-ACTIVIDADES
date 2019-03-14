using business.functions;
using Controller;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace View.Reporte
{
    public partial class ExportaFotos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(Request["MOD"]== "DES_FOTOS")
                {
                    List<FotoBean> loListFoto = (List<FotoBean>)HttpContext.Current.Session["FotosLista"];
                    if (loListFoto.Count > 0)
                    {
                        Byte[] lbDescarga = loListFoto[0].foto;// DescargaController.subDescargaFoto(loListFoto);
                        HttpContext.Current.Response.Clear();
                        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename="+loListFoto[0].titulo);
                        HttpContext.Current.Response.AddHeader("Content-Length", lbDescarga.Length.ToString());
                        HttpContext.Current.Response.ContentType = "application/octet-stream";
                        HttpContext.Current.Response.BinaryWrite(lbDescarga);
                        HttpContext.Current.Response.Flush();
                    }
                    else
                    {
                        string myScript = "<script>alert('No existe data para descargar'); window.location='../Acciones/Descarga/DescargaFoto.aspx';</script>";
                        Response.Write(myScript);
                    }
                }
                else if (Request["MOD"] == "REP_DetalleVisitas")
                {
                    String lsGrupo = Request["IdGrupo"].ToString();
                    String lsUsuario = Request["IdUsuario"].ToString();
                    String lsEstado = Request["IdEstado"].ToString();
                    String lsPuntoInteres = Request["PuntoInteres"].ToString();
                    String lsGeocerca = Request["Geocerca"].ToString();


                    String loDtInicio = Utility.fechaSQL(Request["FechaInicio"].ToString());
                    String loDtFin = Utility.fechaSQL(Request["FechaInicio"].ToString());


                    List<FotoBean> loListFoto = DescargaController.descargaTransaccionFoto(loDtInicio, loDtFin, lsGrupo, lsUsuario, lsEstado, lsPuntoInteres, lsGeocerca);
                    if (loListFoto.Count > 0)
                    {
                        Byte[] lbDescarga = DescargaController.subDescargaFoto(loListFoto);
                        HttpContext.Current.Response.Clear();
                        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=Descarga.zip");
                        HttpContext.Current.Response.AddHeader("Content-Length", lbDescarga.Length.ToString());
                        HttpContext.Current.Response.ContentType = "application/octet-stream";
                        HttpContext.Current.Response.BinaryWrite(lbDescarga);
                        HttpContext.Current.Response.Flush();

                        string myScript = "<script>$('#myModal').html(alertHtml('alertValidacion', 'No existe data para exportar'));$('#myModal').modal('show');</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, true);
                    }
                    else
                    {
                        HttpContext.Current.Response.Clear();
                        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=Descarga.zip");
                        HttpContext.Current.Response.ContentType = "application/octet-stream";
                        HttpContext.Current.Response.Flush();
                    }
                }
            }
            catch (Exception)
            {
            }
        }
    }
}