using Controller;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

namespace View.Mantenimiento.Grupo
{
    public partial class Grupo : PageController
    {
        protected override void initialize()
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
                    hdnShowRows.Value = "10";//Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_TOTAL_PAGE);
                }
            }
        }

        #region Webservice
        [WebMethod]
        public static String Insert(String Codigo, String Nombre, String Padre)
        {
            try
            {
                var item = new GrupoBean
                {
                    Codigo = Codigo,
                    Nombre = Nombre,
                    CodigoPadreGrupo = Padre,
                };
                int id =GrupoController.Insert(item);

                return "OK";
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error: Insert");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static String Update(String Id ,String Codigo, String Nombre, String Padre)
        {
            try
            {
                var item = new GrupoBean
                {
                    IDGrupo = int.Parse(Id),
                    Codigo = Codigo,
                    Nombre = Nombre,
                    CodigoPadreGrupo = Padre,
                };

                GrupoController.Update(item);
                return "OK";
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error : Update");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static void Desactivate(String codigos)
        {
            try
            {
                foreach (var item in codigos.Split('|'))
                {
                    if (!item.Equals(""))
                    {
                        GrupoController.Activate(new GrupoBean { IDGrupo = int.Parse(item), FlgHabilitado="F" }  );
                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :Desactive");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static void Activate(String codigos)
        {
            try
            {
                foreach (var item in codigos.Split('|'))
                {
                    if (!item.Equals(""))
                    {
                        GrupoController.Activate(new GrupoBean { IDGrupo = int.Parse(item), FlgHabilitado = "T" });
                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error : Active");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        #endregion

    }
}