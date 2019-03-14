using business.functions;
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

public partial class Mantenimiento_SubTipoActividad_SubTipoActividad : PageController
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
            CargaCombos();
                if (!IsPostBack)
                {
                    hdnShowRows.Value = "10";//Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_TOTAL_PAGE);
                }
            }
        }

    private void CargaCombos()
    {
        try
        {
            var tipoactividad = TipoActividadController.GetAll(new TipoActividadBean());
            Utility.ComboBuscar(ddlTipoActividad, tipoactividad, "id", "nombre");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    #region Webservice
    [WebMethod]
        public static String Insert(string Codigo, string Descripcion, int TipoActividad, int IdSubTipoActividadPredecesora, int MetaDiaria)
        {
            try
            {
                if (HttpContext.Current.Session["DetalleSubTipoActividad"] == null)
                {
                    throw new Exception("Agregue controles.");
                }

                List<SubTipoActividadDetBean> obj = (List<SubTipoActividadDetBean>)HttpContext.Current.Session["DetalleSubTipoActividad"];
                if (obj != null)
                {
                    if (obj.Count <= 0)
                    {
                        throw new Exception("Agregue controles.");
                    }
                }
                List<SubTipoActividadDet2Bean> lcod = new List<SubTipoActividadDet2Bean>();
                foreach (var cod in obj)
                {
                    var cod2 = new SubTipoActividadDet2Bean
                    {
                        Fila = cod.Index,
                        IDSubTipoActividad = cod.IDSubTipoActividad,
                        IdSubTipoActividadDetalle = cod.IdSubTipoActividadDetalle,
                        Etiqueta = cod.Etiqueta,
                        IdTipoControl = cod.IdTipoControl,
                        CodigoGeneral = cod.CodigoGeneral,
                        Modificable = cod.Modificable,
                        Obligatorio = cod.Obligatorio,
                        MaxCaracter = cod.MaxCaracter,
                        FlgPadre = cod.FlgPadre,
                        IdSubTipoActividadDetPadre = cod.IdSubTipoActividadDetPadre,
                        FlgHabilitado = cod.FlgHabilitado,
                        Perfiles = cod.Perfiles
                    };
                    lcod.Add(cod2);
                }
                var item = new SubTipoActividadBean
                {
                    Codigo = Codigo,
                    Descripcion = Descripcion,
                    idtipoactividad = TipoActividad,
                    IdSubTipoActividadPredecesora = IdSubTipoActividadPredecesora,
                    TiempoEtapa = MetaDiaria,
                    lstControlDinamico2 = lcod,
                };                
                int id =SubTipoActividadController.Insert(item);                
                return id.ToString();
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error: Etapa_Insert : ");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static String Update(string Id, string Codigo, string Descripcion, int TipoActividad, int IdSubTipoActividadPredecesora, int MetaDiaria)
        {
            try
            {
                if (HttpContext.Current.Session["DetallesEtapa"] == null)
                {
                    throw new Exception("Agregue controles.");
                }
                List<SubTipoActividadDetBean> obj = (List<SubTipoActividadDetBean>)HttpContext.Current.Session["DetallesEtapa"];
                if (obj != null)
                {
                    if (obj.Count <= 0)
                    {
                        throw new Exception("Agregue controles.");
                    }
                }
                List<SubTipoActividadDet2Bean> lcod = new List<SubTipoActividadDet2Bean>();
                foreach (var cod in obj)
                {
                    var cod2 = new SubTipoActividadDet2Bean
                    {
                        Fila = cod.Index,
                        IDSubTipoActividad = cod.IDSubTipoActividad,
                        IdSubTipoActividadDetalle = cod.IdSubTipoActividadDetalle,
                        Etiqueta = cod.Etiqueta,
                        IdTipoControl = cod.IdTipoControl,
                        CodigoGeneral = cod.CodigoGeneral,
                        Modificable = cod.Modificable,
                        Obligatorio = cod.Obligatorio,
                        MaxCaracter = cod.MaxCaracter,
                        FlgPadre = cod.FlgPadre,
                        IdSubTipoActividadDetPadre = cod.IdSubTipoActividadDetPadre,
                        FlgHabilitado = cod.FlgHabilitado,
                        Perfiles = cod.Perfiles
                    };
                    lcod.Add(cod2);
                }
                var item = new SubTipoActividadBean
                {
                    IDSubTipoActividad = Id,
                    Codigo = Codigo,
                    Descripcion = Descripcion,
                    idtipoactividad = TipoActividad,
                    IdSubTipoActividadPredecesora = IdSubTipoActividadPredecesora,
                    TiempoEtapa = MetaDiaria,
                    lstControlDinamico2 = lcod,
                };

                SubTipoActividadController.Update(item);

                return "OK";
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error: Etapa_Update : ");
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
                        SubTipoActividadController.Activate(new SubTipoActividadBean { IDSubTipoActividad = item , FlgHabilitado="F"});
                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :ConfOp_Desactivate : ");
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
                        SubTipoActividadController.Activate(new SubTipoActividadBean { IDSubTipoActividad = item, FlgHabilitado = "T" });
                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :Etapa_Activate : ");
                throw new Exception("ERROR: " + ex.Message);
            }
        }
        #endregion
    }