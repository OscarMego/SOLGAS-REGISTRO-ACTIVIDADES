using Controller;
using business.functions;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;
using Model;
using System.Text;
using static Model.Constantes;

namespace View.Movil.B2C
{
    public partial class B2C : PageController
    {
        protected override void initialize()
        {
            if (!IsPostBack)
            {
                CargaCombos();
                hddIdUsuario.Value = HttpContext.Current.Session["lgn_id"].ToString();
            }
        }

        private void CargaCombos()
        {
            try
            {
                var tipoactividad = TipoActividadController.GetAll(new TipoActividadBean { idNegocio = 2 });
                Utility.ComboSeleccionar(cboTipoActividad, tipoactividad, "id", "nombre");

            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :" + this);
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static List<ListItem> ComboSubTipo(string idTipo, string oportunidad)
        {
            if (idTipo != String.Empty)
            {
                try
                {
                    List<ListItem> lstComboBean = SubTipoActividadController.GetAllByType(idTipo, HttpContext.Current.Session["lgn_id"].ToString()).Select(x => new ListItem()
                    {
                        Text = x.Descripcion.ToString(),
                        Value = x.IDSubTipoActividad.ToString(),
                        Selected = false,
                    }).ToList();

                    if (oportunidad.Equals("T"))
                    {
                        ListItem subtipo = new ListItem
                        {
                            Text = "Nueva Oportunidad",
                            Value = "-1",
                            Selected = false,
                        };
                        lstComboBean.Insert(0, subtipo);
                    }

                    return lstComboBean;
                }
                catch (Exception ex)
                {
                    LogHelper.LogException(ex, "Error :" + ex);
                    throw new Exception("ERROR: " + ex.Message);
                }
            }
            return null;
        }

        [WebMethod]
        public static List<OportunidadBean> ObtenerConfiguracion(String CodigoConf, String IdOp, String tipoActividad)
        {
            try
            {
                var codigo = HttpContext.Current.Session["lgn_perfil"].ToString();
                if (CodigoConf == "-1")
                {
                    return OportunidadController.GetConfiguracionNewOportunidades(tipoActividad);
                }
                else
                {
                    return OportunidadController.GetConfiguracionOportunidades(CodigoConf, IdOp, codigo, "spS_ManSelSubTipoActividad");
                }
            }
            catch (Exception e)
            {
                Console.Write(e.ToString());
            }
            return null;
        }


        [WebMethod]
        public static List<ListItem> ComboMultCoordinador()
        {
            try
            {

                var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();
                List<ListItem> lstComboBean = UsuarioController.GetOportunidadUsuarioAll(
                    new UsuarioBean
                    {
                        Codigo = codigo,
                        FlgHabilitado = "T",
                        IdPerfil = 5,
                        Coordinadores = "-1"
                    }
                    ).Select(x => new ListItem()
                    {
                        Text = x.Nombres.ToString(),
                        Value = x.IdUsuario.ToString(),
                        Selected = true,
                    }).ToList();
                return lstComboBean;
            }
            catch (Exception)
            {
                return null;
            }
        }

        [WebMethod]
        public static List<ListItem> ComboMultResponsable(String coordinadores)
        {
            var codigo = HttpContext.Current.Session["lgn_codigo"].ToString();

            List<ListItem> lstComboBean = UsuarioController.GetOportunidadUsuarioAll(
                new UsuarioBean
                {
                    Codigo = codigo,
                    FlgHabilitado = "T",
                    IdPerfil = 4,
                    Coordinadores = coordinadores
                }
                ).Select(x => new ListItem()
                {
                    Text = x.Nombres.ToString(),
                    Value = x.IdUsuario.ToString(),
                    Selected = true,
                }).ToList();
            return lstComboBean;
        }

        [WebMethod]
        public static List<ListItem> ComboMultEtapa()
        {
            List<ListItem> lstComboBean = OportunidadController.GetEtapas("").Select(x => new ListItem()
            {
                Text = x.Nombre,
                Value = x.Codigo.ToString(),
                Selected = true,
            }).ToList();
            return lstComboBean;
        }

        [WebMethod]
        public static List<ListItem> ComboMultEstado()
        {
            List<ListItem> lstComboBean = OportunidadController.GetEstado().Select(x => new ListItem()
            {
                Text = x.Nombre,
                Value = x.Codigo.ToString(),
                Selected = (x.Codigo.ToString() == "1" ? true : false),
            }).ToList();
            return lstComboBean;
        }

        [WebMethod]
        public static List<ListItem> ComboGeneralDinamico(String Grupo, String defaultVal, String idPadre = null)
        {
            List<ListItem> lstComboBean = OportunidadController.GetGrupos(Grupo, idPadre).Select(x => new ListItem()
            {
                Text = x.Nombre,
                Value = x.Codigo.ToString(),
                Selected = (x.Codigo.ToString() == defaultVal ? true : false),
            }).ToList();
            return lstComboBean;
        }

        [WebMethod]
        public static List<OportunidadBean> ObtenerConfiguracionEtapa(String CodigoConf, String IdOp)
        {
            var codigo = HttpContext.Current.Session["lgn_perfil"].ToString();
            return OportunidadController.GetConfiguracionEtapa(CodigoConf, IdOp, codigo);
        }
        [WebMethod]
        public static String InsertOportunidad(string id, string ConfOpor, String CodCliente, String controldinamico)
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
                    ConfOpor = ConfOpor,
                    Responsable = usuSession,
                    CodCliente = CodCliente,
                    UsuSession = usuSession,
                    lstControlDinamico = lControlDin,
                };
                var idop = OportunidadController.InsertOportunidad(item);
                return idop.ToString();
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static String UpdateOportunidad(string id, string ConfOpor, string RazonSocial, string Ruc, String Rubro, String Region, String Canal, String Responsable, String CodCliente, String controldinamico)
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
                    ConfOpor = ConfOpor,
                    CliExist = "T",
                    RazonSocial = RazonSocial,
                    Ruc = Ruc,//FormsAuthentication.HashPasswordForStoringInConfigFile(clave, "sha1"),
                    Rubro = Rubro,
                    Region = Region,
                    Canal = Canal,
                    Responsable = usuSession,
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
        public static String InsertFormulario(string id, string ConfOpor, String CodCliente, String controldinamico, String idContacto, String observaciones, String fecha, String latitud, String longitud, String codInstalacion)
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
                    ConfOpor = ConfOpor,
                    idContacto = idContacto,
                    observaciones = observaciones,
                    idNegocio = "1",
                    Responsable = usuSession,
                    CodCliente = CodCliente,
                    lstControlDinamico = lControlDin,
                    fecha = DateTime.ParseExact(fecha, "dd/MM/yyyy",
                                       System.Globalization.CultureInfo.InvariantCulture),
                    latitud = latitud,
                    longitud = longitud
                };
                var idop = OportunidadController.Insert(item, codInstalacion);
                return idop.ToString();
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
                throw new Exception("ERROR: " + ex.Message);
            }
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
                    fecha = DateTime.Now
                };

                int idOp = OportunidadController.InsertEtapa(item);
                return idOp.ToString();
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :Oportunidad_Insert : ");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static ContactoBean InsertContact(String NombreC, String TelefonoC, String EmailC, String CargoC, String idclienteC, String codInstalacion)
        {
            try
            {
                //String idZona = HttpContext.Current.Session["lgn_idzona"].ToString();
                ContactoBean item = new ContactoBean

                {
                    Nombre = NombreC,
                    Telefono = TelefonoC,
                    Email = EmailC,
                    Cargo = CargoC,
                    IdCliente = Int64.Parse(idclienteC),
                    codInstalacion = codInstalacion
                };
                ContactoController.Insert(item);

                return item;
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error: Insert");
                throw new Exception("ERROR: " + ex.Message);
            }
        }
        [WebMethod]
        public static List<ContactoBean> getContacts(String CodCliente, String codInstalacion)
        {
            try
            {
                List<ContactoBean> item = ContactoController.GetAll(new ContactoBean

                {
                    IdCliente = int.Parse(CodCliente),
                    codInstalacion = codInstalacion

                });
                return item;
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error: Insert");
                throw new Exception("ERROR: " + ex.Message);
            }
        }


        [WebMethod]
        public static List<ClienteInstalacionBean> getInstalacion(String CodCliente)
        {
            try
            {
                var usuSession = HttpContext.Current.Session["lgn_id"].ToString();
                List<ClienteInstalacionBean> item = ClienteController.getAllInstalacion(CodCliente, usuSession);
                return item;
            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error: Insert");
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        [WebMethod]
        public static TipoActividadBean ObtenerEstadoOportunidad(string Id)
        {
            try
            {
                var item = new TipoActividadBean
                {
                    id = Int32.Parse(Id)
                };
                TipoActividadBean obj = TipoActividadController.GetAll(item)[0];
                return obj;
            }
            catch (Exception e)
            {
                return null;
            }

        }
    }
}
