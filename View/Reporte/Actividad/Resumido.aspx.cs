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



public partial class Reporte_Actividad_Resumido : PageController
{
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
            CargaCombos();
            if (!IsPostBack)
            {
                //divcoo.Disabled = true;
                txtFechaInicio.Text = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
                txtFechaFin.Text = DateTime.Now.ToString("dd/MM/yyyy");
                hdnShowRows.Value = "10";//Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_TOTAL_PAGE);
            }
        }
    }

    private void CargaCombos()
    {
        try
        {
            //Utility.ComboBuscar(ddlEstado, OportunidadController.GetEstado(), "Codigo", "Nombre");

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultiCampo()
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<Combo> lstCampos = new List<Combo>();

            lstCampos.Add(new Combo { Codigo = "[Fecha]", Nombre = "Fecha" });
            lstCampos.Add(new Combo { Codigo = "[Canal]", Nombre = "Canal" });
            lstCampos.Add(new Combo { Codigo = "[Zona]", Nombre = "Zona" });
            lstCampos.Add(new Combo { Codigo = "[Tipo Actividad]", Nombre = "Tipo Actividad" });
            lstCampos.Add(new Combo { Codigo = "[Sub Tipo Actividad]", Nombre = "Sub Tipo Actividad" });
            lstCampos.Add(new Combo { Codigo = "[Usuario]", Nombre = "Usuario" });
            lstCampos.Add(new Combo { Codigo = "[Cliente]", Nombre = "Cliente" });

            List<ListItem> lstComboBean = lstCampos.
               Select(x => new ListItem()
               {
                   Text = x.Nombre,
                   Value = x.Codigo.ToString(),
                   Selected = true,
               }).ToList();

            return lstComboBean;

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Actividad_Canal: ");
            return new List<ListItem>();
        }
    }

    #region WebService
    //[WebMethod]
    //public static String Insert(string id, string ConfOpor, string CliExist, string RazonSocial, string Ruc, String Rubro, String Region, String Canal, String Responsable, String CodCliente, String controldinamico)
    //{
    //    try
    //    {
    //        var lcontrol = controldinamico.Split('|');
    //        List<controlDinamico> lControlDin = new List<controlDinamico>();
    //        foreach (var control in lcontrol)
    //        {
    //            if (control != "")
    //            {
    //                var econtrol = control.Split(';');
    //                controlDinamico eControlDin = new controlDinamico
    //                {
    //                    id = econtrol[0],
    //                    valor = econtrol[1]
    //                };
    //                lControlDin.Add(eControlDin);
    //            }
    //        }
    //        var usuSession = HttpContext.Current.Session["lgn_id"].ToString();
    //        var item = new OportunidadBean
    //        {
    //            id = id,
    //            ConfOpor = ConfOpor,
    //            CliExist = CliExist,
    //            RazonSocial = RazonSocial,
    //            Ruc = Ruc,//FormsAuthentication.HashPasswordForStoringInConfigFile(clave, "sha1"),
    //            Rubro = Rubro,
    //            Region = Region,
    //            Canal = Canal,
    //            Responsable = Responsable,
    //            CodCliente = CodCliente,
    //            lstControlDinamico = lControlDin,
    //            UsuSession = usuSession,
    //        };
    //        OportunidadController.Insert(item);
    //        return "OK";
    //    }
    //    catch (Exception ex)
    //    {
    //        LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
    //        throw new Exception("ERROR: " + ex.Message);
    //    }
    //}

    [WebMethod]
    public static String Update(string id, string ConfOpor, string CliExist, string RazonSocial, string Ruc, String Rubro, String Region, String Canal, String Responsable, String CodCliente, String controldinamico)
    {
        try
        {
            var lcontrol = controldinamico.Split('|');
            List<controlDinamico> lControlDin = new List<controlDinamico>();
            foreach (var control in lcontrol)
            {
                if (control != "")
                {
                    var econtrol = control.Split(';');
                    controlDinamico eControlDin = new controlDinamico
                    {
                        id = econtrol[0],
                        valor = econtrol[1]
                    };
                    lControlDin.Add(eControlDin);
                }
            }
            var item = new OportunidadBean
            {
                id = id,
                ConfOpor = ConfOpor,
                CliExist = CliExist,
                RazonSocial = RazonSocial,
                Ruc = Ruc,//FormsAuthentication.HashPasswordForStoringInConfigFile(clave, "sha1"),
                Rubro = Rubro,
                Region = Region,
                Canal = Canal,
                Responsable = Responsable,
                CodCliente = CodCliente,
                lstControlDinamico = lControlDin,
            };
            OportunidadController.Update(item);
            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
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
                    OportunidadController.Active(item, "F");
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Desactivate : ");
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
                    OportunidadController.Active(item, "T");
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static void Cerrar(String codigos)
    {
        try
        {
            foreach (var item in codigos.Split('|'))
            {
                if (!item.Equals(""))
                {
                    OportunidadController.Cerrar(item, "T");
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Usuario_Activate : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultCanal()
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = NegocioController.GetAll(new NegocioBean { Nombre = "" }).
                Select(x => new ListItem()
                {
                    Text = x.Nombre,
                    Value = x.IdNegocio.ToString(),
                    Selected = true,
                }).ToList();

            return lstComboBean;

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Actividad_Canal: ");
            return new List<ListItem>();
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultZona()
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = ZonaController.GetAll(new ZonaBean { Flag = "T" }).
                Select(x => new ListItem()
                {
                    Text = x.Nombre,
                    Value = x.IdZona.ToString(),
                    Selected = true,
                }).ToList();

            return lstComboBean;

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Actividad_Zona: ");
            return new List<ListItem>();
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultTipoActividad()
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = TipoActividadController.GetAll(new TipoActividadBean { Flag = "T" }).
                Select(x => new ListItem()
                {
                    Text = x.nombre,
                    Value = x.id.ToString(),
                    Selected = true,
                }).ToList();

            return lstComboBean;

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Actividad_TipoActividad: ");
            return new List<ListItem>();
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultDetalleActividad()
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = SubTipoActividadController.GetAll("0").
                Select(x => new ListItem()
                {
                    Text = x.Descripcion,
                    Value = x.IDSubTipoActividad.ToString(),
                    Selected = true,
                }).ToList();

            return lstComboBean;

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Actividad_DetalleTipoActividad: ");
            return new List<ListItem>();
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultUsuario()
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = UsuarioController.GetAllPorTipo(new UsuarioBean { Codigo = codigo, FlgHabilitado = "T" }).
                Select(x => new ListItem()
                {
                    Text = x.LoginUsuario + " - " + x.Nombres,
                    Value = x.IdUsuario.ToString(),
                    Selected = true,
                }).ToList();

            return lstComboBean;

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Actividad_Usuario: ");
            return new List<ListItem>();
        }
    }

    [WebMethod]
    public static List<ListItem> ComboMultCliente()
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = ClienteController.GetAll(new ClienteBean { FlgHabilitado = "T" }).
                Select(x => new ListItem()
                {
                    Text = x.Razon_Social,
                    Value = x.CLI_PK.ToString(),
                    Selected = true,
                }).ToList();

            return lstComboBean;

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Actividad_Cliente: ");
            return new List<ListItem>();
        }
    }

    [WebMethod]
    public static List<ListItem> ComboGeneralDinamico(String Grupo, String defaultVal)
    {
        List<ListItem> lstComboBean = OportunidadController.GetGrupos(Grupo).Select(x => new ListItem()
        {
            Text = x.Nombre,
            Value = x.Codigo.ToString(),
            Selected = (x.Codigo.ToString() == defaultVal ? true : false),
        }).ToList();
        return lstComboBean;
    }

    [WebMethod]
    public static List<OportunidadBean> ObtenerConfiguracionEtapa(String idEtapa, String IdOp)
    {
        var codigo = HttpContext.Current.Session["lgn_perfil"].ToString();
        return OportunidadController.GetConfiguracionEtapa(idEtapa, IdOp, codigo);
    }

    [WebMethod]
    public static String InsertEtapa(string id, String CambiaEtapa, String controldinamico)
    {
        try
        {
            var lcontrol = controldinamico.Split('|');
            List<controlDinamico> lControlDin = new List<controlDinamico>();
            foreach (var control in lcontrol)
            {
                if (control != "")
                {
                    var econtrol = control.Split(';');
                    controlDinamico eControlDin = new controlDinamico
                    {
                        id = econtrol[0],
                        valor = econtrol[1]
                    };
                    lControlDin.Add(eControlDin);
                }
            }
            var usuSession = HttpContext.Current.Session["lgn_id"].ToString();
            var item = new OportunidadBean
            {
                id = id,
                lstControlDinamico = lControlDin,
                UsuSession = usuSession,
                CambiaEtapa = CambiaEtapa,
            };
            OportunidadController.InsertEtapa(item);
            return "OK";
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    [WebMethod]
    public static List<ListItem> GetFotoActividad(string idFoto)
    {
        try
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = OportunidadController.GetFotoActividad(idFoto).
                Select(x => new ListItem()
                {
                    Text = x.Codigo,
                    Value = x.Nombre
                }).ToList();

            return lstComboBean;

        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :Actividad_GetFoto: ");
            return new List<ListItem>();
        }
    }
    #endregion
}
