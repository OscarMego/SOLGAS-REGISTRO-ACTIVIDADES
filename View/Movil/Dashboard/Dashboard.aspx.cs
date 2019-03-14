using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using System.Configuration;
using Model.bean;
using Controller.functions;
using System.Text;
using System.Linq;
using System.Web.Services;
using System.IO;
using System.Net;
using System.Web.Script.Serialization;
using Model;

namespace View.Movil.Dashboard
{
    public partial class Dashboard : PageController
    {

        protected override void initialize()
        {
            

        }

        protected void Salir(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("../Default.aspx?acc=EXT");
        }

        protected void visita(object sender, EventArgs e)
        {
            
            if (Session["lgn_idcanal"].ToString().Equals("1"))
            {
                Response.Redirect("../B2B/B2B.aspx");
            }
            else 
            {
                Response.Redirect("../B2C/B2C.aspx");
            }
        }

        [WebMethod]
        public static List<TipoActividadBean> GetReporteDashboard()
        {
            try
            {
                var codigo = HttpContext.Current.Session["lgn_id"].ToString();

                List<TipoActividadBean> lstData = TipoActividadController.GetReporteDashboard(codigo).
                    Select(x => new TipoActividadBean()
                    {
                        codigo = x.codigo,
                        nombre = x.nombre,
                        meta = x.meta,
                        total = x.total
                    }).ToList();

                return lstData;
            }
            catch (Exception ex)
            {               
                return new List<TipoActividadBean>();
            }
        }
    }
}