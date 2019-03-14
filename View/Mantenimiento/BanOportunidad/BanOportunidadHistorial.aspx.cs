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

public partial class Mantenimiento_BanOportunidad_BanOportunidadHistorial : System.Web.UI.Page
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
                    myModalLabel.InnerText = "Historial de Oportunidad";

                    codigo = dataJSON["codigo"].ToString();

                    OportunidadBean lOport = OportunidadController.GetOportunidad(
                        new OportunidadBean { IdOportunidad = codigo });

                    MtxtCliente.Value = lOport.Cliente;
                    MtxtCodigo.Value = lOport.Codigo;
                    MtxtIdOportunidad.Value = lOport.Codigo;

                    List<OportunidadBean> letapa = OportunidadController.GetConfiguracionEtapaLista(codigo);
                    litGrillaHistorial.Text = DibujaTabla(letapa);

                    //List<FotoBean> lFoto = OportunidadController.GetOportunidadEtapaFoto(codigo);
                    //HttpContext.Current.Session["FotosLista"] = lFoto;
                    
                }
                else
                {
                }

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

    public String DibujaTabla(List<OportunidadBean>lst)
    {
        String GenTabla = "";
        GenTabla = "<table class='grilla table' id='Table1' style='width: 100%;'>" +
                       "<thead>" +
                        "   <tr>" +
                         "      <th scope='col'>Id</th>" +
                          "     <th scope='col'>Etapa</th>" +
                          "     <th scope='col'>Fecha Inicio</th>" +
                          "     <th scope='col'>Fecha Fin</th>" +
                          "     <th scope='col'>Responsable</th>";
        GenTabla += "     <th scope='col'></th>";
        GenTabla += "</tr>";
        GenTabla += "</thead>";
        GenTabla += "<tbody>";
        int row = 0;
        foreach (var eRepor in lst)
        {
            GenTabla += "<tr " + (row++ % 2 == 0 ? "" : "class='file'") + ">" +
                        "<td align='center'  >" + eRepor.rows + "</td>" +
                        "<td align='center'  >" + eRepor.Etapa + "</td>" +
                        "<td align='center'  >" + eRepor.FechaInicio + "</td>" +
                        "<td align='center'  >" + eRepor.FechaFin + "</td>" +
                        "<td align='center'  >" + eRepor.Responsable + "</td>";
            //Cerrar Oportunidad
            GenTabla += "<td align='center' ><button type='button' class='btn nuevo infoItemReg movil' title='Informacion Etapa' ";
            GenTabla += "cod= '{\"idEtapa\":\"" + eRepor.idEtapa + "\", \"IdOp\" :\"" + eRepor.IdOportunidad + "\", \"index\" :\"" + row + "\"}'>";
            GenTabla += "<i class='fas fa-info-circle'></i>";
            GenTabla += "</button></td>";

            GenTabla += "</tr>";
            
        }

        GenTabla += "</tbody>" + "</table>";
        return GenTabla;
    }
    [WebMethod]
    public static String verFoto(String idEtapa, String IdOp)
    {
        List<FotoBean> lFoto = OportunidadController.GetOportunidadEtapaFoto(IdOp, idEtapa);
        HttpContext.Current.Session["FotosLista"] = lFoto;
        if (lFoto.Count>0)
        {
            return "OK";
        }
        return "";
        //foto.Src = "../../foto/imagen.aspx?item=0";
    }
}