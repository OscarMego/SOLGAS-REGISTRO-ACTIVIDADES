using business.functions;
using Controller;
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

namespace View.Mantenimiento.Grupo
{
    public partial class GrupoNew : System.Web.UI.Page
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
                Session["lstPerfiles"] = PerfilController.GetAll(new PerfilBean { FlgHabilitado = "T" });
                
                if (!IsPostBack)
                {
                    string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                    Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);
                    
                    if (dataJSON != null )
                    {
                        String Codigo = dataJSON["codigo"].ToString();

                        
                        GrupoBean obj = GrupoController.Get(new GrupoBean { IDGrupo = int.Parse( dataJSON["codigo"].ToString()) });
                        myModalLabel.InnerText = "Editar " + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_GRUPO);

                        if (obj != null)
                        {
                            CargaComboPadre(obj.IDGrupo);
                            hdIdGrupo.Value = (obj.IDGrupo).ToString();
                            MtxtCodigo.Value = obj.Codigo;
                            MtxtDescripcion.Value = obj.Nombre;
                            MddlPadre.SelectedValue = obj.CodigoPadreGrupo;
                            MtxtCodigo.Disabled = true;
                        }

                    }
                    else
                    {
                        CargaComboPadre(0);
                        myModalLabel.InnerText = "Crear " + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_GRUPO);
                    }
                }
            }
        }

        private void CargaComboPadre(int IDGrupo)
        {
            try
            {
                Utility.ComboNuevo(MddlPadre, GrupoController.GetPadres(new GrupoBean { IDGrupo = IDGrupo })
                    , "IDGrupo", "Nombre");
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :" + this);
                throw new Exception("ERROR: " + ex.Message);
            }
        }
                               

    }
}