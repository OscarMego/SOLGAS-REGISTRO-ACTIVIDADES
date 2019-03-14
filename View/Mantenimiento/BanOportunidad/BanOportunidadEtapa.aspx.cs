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

public partial class Mantenimiento_BanOportunidad_BanOportunidadEtapa : System.Web.UI.Page
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
                    myModalLabel.InnerText = "Cambiar Etapa";

                    codigo = dataJSON["codigo"].ToString();

                    OportunidadBean lOport = OportunidadController.GetOportunidad(
                        new OportunidadBean { IdOportunidad = codigo });

                    MtxtCliente.Value = lOport.Cliente;
                    MtxtCodigo.Value = lOport.Codigo;
                    MtxtEtapa.Value = lOport.Etapa;
                    MtxtIdEtapaActual.Value = lOport.IdEtapaActual;
                    MtxtIdEtapaSiguiente.Value = lOport.idEtapaSiguiente;
                    MtxtIdOportunidad.Value = lOport.Codigo;
                    MtxtResponsable.Value = lOport.ResponsableNombre;
                    hddIdUsuario.Value = HttpContext.Current.Session["lgn_id"].ToString();
                    MtxtFechaInicio.Value = lOport.FechaInicio;
                    MtxtFechaFin.Value = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
                    lblCambiarEtapa.InnerText = "Cambiar Etapa: " + lOport.EtapaSiguiente;
                }
                else
                {
                }
                hdTamFoto.Value = ConfigurationManager.AppSettings["TAM_MAX_FOTO"].Trim();

            }
        }
    }
    private void CargaCombos()
    {
        try
        {
            //var lista = OportunidadController.GetConfiguraOportunidad();
            //Utility.ComboNuevo(MddlConfOpor, lista, "Codigo", "Nombre");

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
                    Coordinadores = ""
                }
                );
            //Utility.ComboNuevo(MddlResponsable, lstComboBean, "Codigo", "Nombres");
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
        return OportunidadController.GetConfiguracionOportunidades(CodigoConf, IdOp, codigo, "spS_ManSelSubTipoActividad");
    }
    protected void btnSubirLogo_Click(object sender, EventArgs e)
    {
        //SubirLogo();

        if (fuLogo.FileName != "")
        {
            fuLogo.PostedFile.SaveAs(HttpContext.Current.Server.MapPath("~") + hdURL.Value + hdNombre.Value);
        }
        //string myScript = "../../default.aspx?acc=EXT";
        //myScript = "document.location.href = 'Usuario.aspx';";

        //Response.Clear();
        //Response.Write("<head><script type='text/javascript'> ");
        //Response.Write(myScript);
        //Response.Write(" </script></head><body></body>");
        //Response.End();

        //imgPreview.ImageUrl = "";
    }

    [WebMethod(EnableSession = true)]
    public static String pruebaFoto(Object file)
    {
        try
        {
            string _file = "";
            return _file;
        }
        catch (Exception e)
        {
            return e.Message;
        }
    }
}