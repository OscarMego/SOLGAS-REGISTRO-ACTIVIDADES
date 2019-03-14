using business.functions;
using Controller;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

namespace View.Movil.B2B
{
    public partial class ContactoNew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["lgn_id"] == null)
            {
                Session.Clear();
                String lsScript = "parent.document.location.href = '../../default.aspx?acc=SES';";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
            }
            else
            {
                Session["lstPerfiles"] = PerfilController.GetAll(new PerfilBean { FlgHabilitado = "T" });

                if (!IsPostBack)
                {
                    string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                    Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                    if (dataJSON != null)
                    {
                        String Codigo = dataJSON["codigo"].ToString();


                        GrupoBean obj = GrupoController.Get(new GrupoBean { IDGrupo = int.Parse(dataJSON["codigo"].ToString()) });


                        if (obj != null)
                        {
                            //CargaComboPadre(obj.IDGeneralTipo);
                            //hdIdTipo.Value = (obj.IDGeneralTipo).ToString();
                            //MtxtCodigo.Value = obj.Codigo;
                            //MtxtDescripcion.Value = obj.Nombre;
                            //MddlPadre.SelectedValue = obj.CodigoPadreGeneral;
                            //MtxtCodigo.Disabled = true;
                        }

                    }
                    else
                    {


                    }
                }
            }
        }

    }
}