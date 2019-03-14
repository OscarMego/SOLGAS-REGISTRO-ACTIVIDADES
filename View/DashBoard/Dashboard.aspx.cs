using business.functions;
using Controller;
using Model;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

namespace View.DashBoard
{
    public partial class Dashboard : PageController
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected override void initialize()
        {
            if (Session["lgn_id"] == null)
            {
                Session.Clear();
                String lsScript = "parent.document.location.href = '../../default.aspx?acc=SES';";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
            }
            else
            {               
            }
        }


        [WebMethod]
        public static List<TipoActividadBean> GetReporteDashboard()
        {
            try
            {
                var codigo = HttpContext.Current.Session["lgn_id"].ToString();

                //For admin get all
                List<TipoActividadBean> lstData = TipoActividadController.GetReporteDashboard("").
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