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

public partial class Mantenimiento_BanOportunidad_BanOportunidadNew : System.Web.UI.Page
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
            CargaCombos();
            if (!IsPostBack)
            {
                string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);
                String codigo = "0";
                if (dataJSON != null)
                {
                    myModalLabel.InnerText = "Editar Oportunidad";
                    codigo = dataJSON["codigo"].ToString();

                    OportunidadBean lOport = OportunidadController.GetOportunidad(
                        new OportunidadBean { IdOportunidad = codigo });

                    MddlConfOpor.SelectedValue = lOport.IdConfiguracionOportunidad;
                    MddlResponsable.SelectedValue = lOport.Responsable;
                    MtxtCliente.Value = lOport.Cliente;
                    MtxtCliente.Attributes["idval"] = lOport.CodCliente;
                    MtxtIdOportunidad.Value = lOport.Codigo;
                }
                else
                {
                    myModalLabel.InnerText = "Crear Oportunidad";
                }
                
            }
        }
    }
    private void CargaCombos()
    {
        try
        {
            var lista = OportunidadController.GetConfiguraOportunidad();
            Utility.ComboNuevo(MddlConfOpor, lista, "Codigo", "Nombre");

            //Utility.ComboNuevo(MddlCanal, OportunidadController.GetGenerales(Constantes.EnumGenerales.Canal), "Codigo", "Nombre");
            //Utility.ComboNuevo(MddlRegion, OportunidadController.GetGenerales(Constantes.EnumGenerales.Region), "Codigo", "Nombre");
            //Utility.ComboNuevo(MddlRubro, OportunidadController.GetGenerales(Constantes.EnumGenerales.Rubro), "Codigo", "Nombre");


            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<UsuarioBean> lstComboBean = UsuarioController.GetOportunidadUsuarioAll(
                new UsuarioBean
                {
                    Codigo = codigo,
                    FlgHabilitado = "T",
                    IdPerfil = 4,
                    Coordinadores = "-1",
                }
                );
            Utility.ComboNuevo(MddlResponsable, lstComboBean, "IdUsuario", "Nombres");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static List<OportunidadBean> ObtenerConfiguracion(String CodigoConf, String IdOp)
    {
        var codigo = HttpContext.Current.Session["lgn_perfil"].ToString();
        if (IdOp == "")
        {
        return OportunidadController.GetConfiguracionOportunidades(CodigoConf, IdOp, codigo, "spS_ManSelSubTipoActividad");
        }else
        {
            return OportunidadController.GetConfiguracionOportunidades(CodigoConf, IdOp, codigo, "spS_ManSelSubTipoActividadOportunidad");
        }
    }
}