using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Configuration;
using System.ComponentModel;

namespace Model
{
    public class OportunidadModel
    {
        public static PaginateOportunidadBean GetAllPaginate(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaEstimadaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaEstimadaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaEstimadaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaEstimadaFin;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Cliente", SqlDbType.VarChar, 100);
            parameter.Value = item.Cliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Coordinador", SqlDbType.VarChar, 4000);
            parameter.Value = item.Coordinador;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Responsable", SqlDbType.VarChar, 4000);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Etapa", SqlDbType.VarChar, 4000);
            parameter.Value = item.Etapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Estado", SqlDbType.VarChar, 4000);
            parameter.Value = item.Estado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@UsuarioSession", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGROportunidadAllPaginate", alParameters);
            int total = 0;
            List<string> ecd = new List<string>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataColumn col in dt.Columns)
                {
                    string nombre = col.ColumnName;
                    if (nombre.Count() > 3)
                    {
                        string cod = nombre.Substring(0, 3);
                        if (cod.Equals(Constantes.ColDinamico))
                        {
                            ecd.Add(nombre);
                        };
                    }

                }

                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    List<ComboBean> lcd = new List<ComboBean>();
                    foreach (var lstrin in ecd.ToList())
                    {
                        var columna = lstrin.Substring(3, lstrin.Count() - 3);
                        lcd.Add(new ComboBean
                        {
                            Codigo = columna,
                            Nombre = row[lstrin].ToString(),
                        });
                    }

                    OportunidadBean obj = new OportunidadBean
                    {
                        Codigo = row["Codigo"].ToString(),
                        Responsable = row["Responsable"].ToString(),
                        FechaRegistro = row["FechaRegistro"].ToString(),
                        Cliente = row["Cliente"].ToString(),
                        Rubro = row["Rubro"].ToString(),
                        Etapa = row["Etapa"].ToString(),
                        columnasDinamicas = lcd,
                        eliminar = row["eliminar"].ToString(),
                        Cerrar = row["cerrar"].ToString(),
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return new PaginateOportunidadBean { lstResultados = lobj, totalrows = total }
           ;
        }
        public static List<ComboBean> GetGenerales(String codigo, String idPadre)
        {
            List<ComboBean> lobj = new List<ComboBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodigoTipo", SqlDbType.VarChar, 100);
            parameter.Value = codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idPadre", SqlDbType.VarChar, 100);
            parameter.Value = idPadre;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGeneralDetalle", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ComboBean obj = new ComboBean
                    {
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static PaginateOportunidadBean GetReporteAllPaginate(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            int total = 0;

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Canal", SqlDbType.VarChar, 4000);
            parameter.Value = item.Canal;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Zona", SqlDbType.VarChar, 4000);
            parameter.Value = item.Zona;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@TipoActividad", SqlDbType.VarChar, 4000);
            parameter.Value = item.TipoActividad;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@DetalleActividad", SqlDbType.VarChar, 4000);
            parameter.Value = item.DetalleActividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Usuario", SqlDbType.VarChar, 4000);
            parameter.Value = item.Usuario;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdUsuarioLogueado", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Cliente", SqlDbType.VarChar, 4000);
            parameter.Value = item.Cliente;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);

            if (item.TipoReporte == "DETALLADO")
            {
                DataTable dt = SqlConnector.getDataTable("spS_RepSelActividadDinamicoAllPaginate", alParameters);

                List<string> ecd = new List<string>();
                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataColumn col in dt.Columns)
                    {
                        string nombre = col.ColumnName;
                        if (nombre.Count() > 3)
                        {
                            string cod = nombre.Substring(0, 3);
                            if (cod.Equals(Constantes.ColDinamico))
                            {
                                ecd.Add(nombre);
                            };
                        }
                    }

                    foreach (DataRow row in dt.Rows)
                    {
                        total = int.Parse(row["total"].ToString());
                        List<ComboBean> lcd = new List<ComboBean>();
                        foreach (var lstrin in ecd.ToList())
                        {
                            var columna = lstrin.Substring(3, lstrin.Count() - 3);
                            lcd.Add(new ComboBean
                            {
                                Codigo = columna,
                                Nombre = row[lstrin].ToString(),
                            });
                        }

                        OportunidadBean obj = new OportunidadBean
                        {
                            Codigo = row["Codigo"].ToString(),
                            Fecha = row["Fecha"].ToString(),
                            Canal = row["Canal"].ToString(),
                            Zona = row["Zona"].ToString(),
                            TipoActividad = row["Tipo Actividad"].ToString(),
                            DetalleActividad = row["Sub Tipo Actividad"].ToString(),
                            Latitud = row["Latitud"].ToString(),
                            Longitud = row["Longitud"].ToString(),
                            Usuario = row["Usuario"].ToString(),
                            Ruc = row["RUC"].ToString(),
                            Cliente = row["Cliente"].ToString(),
                            Contacto = row["Contacto"].ToString(),
                            Telefono = row["Telefono"].ToString(),
                            Email = row["Email"].ToString(),
                            Cargo = row["Cargo"].ToString(),

                            columnasDinamicas = lcd,
                        };
                        lobj.Add(obj);
                    }
                }
            }
            else if (item.TipoReporte == "RESUMIDO")
            {

                parameter = new SqlParameter("@Campo", SqlDbType.VarChar, 4000);
                parameter.Value = item.Campo;
                alParameters.Add(parameter);

                DataTable dt = SqlConnector.getDataTable("spS_RepSelActividadResumidoAllPaginate", alParameters);

                List<string> ecd = new List<string>();
                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataColumn col in dt.Columns)
                    {
                        string nombre = col.ColumnName;
                        ecd.Add(nombre);
                    }

                    foreach (DataRow row in dt.Rows)
                    {
                        total = int.Parse(row["total"].ToString());
                        List<ComboBean> lcd = new List<ComboBean>();
                        foreach (var lstrin in ecd.ToList())
                        {
                            var columna = lstrin;
                            lcd.Add(new ComboBean
                            {
                                Codigo = columna,
                                Nombre = row[lstrin].ToString(),
                            });
                        }

                        OportunidadBean obj = new OportunidadBean
                        {
                            columnasDinamicas = lcd,
                        }
                        ;
                        lobj.Add(obj);
                    }
                }
            }

            return new PaginateOportunidadBean { lstResultados = lobj, totalrows = total };

        }
        public static PaginateOportunidadBean GetNotifiReporteAllPaginate(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Coordinador", SqlDbType.VarChar, 4000);
            parameter.Value = item.Coordinador;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Responsable", SqlDbType.VarChar, 4000);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@UsuarioSession", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_NotificaRepSelOportunidadAllPaginate", alParameters);
            int total = 0;
            List<string> ecd = new List<string>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataColumn col in dt.Columns)
                {
                    string nombre = col.ColumnName;
                    if (nombre.Count() > 3)
                    {
                        string cod = nombre.Substring(0, 3);
                        if (cod.Equals(Constantes.ColDinamico))
                        {
                            ecd.Add(nombre);
                        };
                    }

                }

                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    List<ComboBean> lcd = new List<ComboBean>();
                    foreach (var lstrin in ecd.ToList())
                    {
                        var columna = lstrin.Substring(3, lstrin.Count() - 3);
                        lcd.Add(new ComboBean
                        {
                            Codigo = columna,
                            Nombre = row[lstrin].ToString(),
                        });
                    }

                    OportunidadBean obj = new OportunidadBean
                    {
                        Codigo = row["Codigo"].ToString(),
                        Region = row["Region"].ToString(),
                        Canal = row["Canal"].ToString(),
                        Rubro = row["Rubro"].ToString(),
                        Cliente = row["Cliente"].ToString(),
                        Coordinador = row["Coordinador"].ToString(),
                        Responsable = row["Responsable"].ToString(),
                        Estado = row["Estado"].ToString(),
                        Etapa = row["Etapa"].ToString(),
                        FechaRegistro = row["FechaRegistro"].ToString(),
                        Retrazo = row["Retrazo"].ToString(),

                        columnasDinamicas = lcd,
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return new PaginateOportunidadBean { lstResultados = lobj, totalrows = total }
           ;
        }
        public static DataTable GetReporteAllPaginateExcel(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Canal", SqlDbType.VarChar, 4000);
            parameter.Value = item.Canal;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Zona", SqlDbType.VarChar, 4000);
            parameter.Value = item.Zona;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@TipoActividad", SqlDbType.VarChar, 4000);
            parameter.Value = item.TipoActividad;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@DetalleActividad", SqlDbType.VarChar, 4000);
            parameter.Value = item.DetalleActividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Usuario", SqlDbType.VarChar, 4000);
            parameter.Value = item.Usuario;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Cliente", SqlDbType.VarChar, 4000);
            parameter.Value = item.Cliente;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@IdUsuarioLogueado", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);
            DataTable dt = null;

            if (item.TipoReporte == "DETALLADO")
            {
                dt = SqlConnector.getDataTable("spS_RepSelActividadDinamicoAllPaginateExcel", alParameters);
            }
            else if (item.TipoReporte == "RESUMIDO")
            {
                parameter = new SqlParameter("@Campo", SqlDbType.VarChar, 4000);
                parameter.Value = item.Campo;
                alParameters.Add(parameter);

                dt = SqlConnector.getDataTable("spS_RepSelActividadResumidoAllPaginateExcel", alParameters);
            }

            return dt;
        }
        public static OportunidadBean GetOportunidad(OportunidadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdOportunidad", SqlDbType.BigInt);
            parameter.Value = item.IdOportunidad;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGROportunidad", alParameters);
            OportunidadBean obj = new OportunidadBean();
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new OportunidadBean
                    {
                        idEtapaSiguiente = row["idEtapaSiguiente"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Responsable = row["Responsable"].ToString(),
                        //ExisteCliente = row["ExisteCliente"].ToString(),
                        Cliente = row["Cliente"].ToString(),
                        Rubro = row["Rubro"].ToString(),
                        IdEtapaActual = row["IdEtapaActual"].ToString(),
                        IdConfiguracionOportunidad = row["IdSubTipoActividad"].ToString(),
                        CodCliente = row["idCliente"].ToString(),
                        Etapa = row["Etapa"].ToString(),
                        ResponsableNombre = row["ResponsableNombre"].ToString(),
                        FechaInicio = row["fechaInicio"].ToString(),
                        FechaFin = row["fechaFin"].ToString(),
                        EtapaSiguiente = row["EtapaSiguiente"].ToString()
                    };
                }
            }
            return obj;
        }


        public static List<ComboBean> GetFotoActividad(string idFoto)
        {
            List<ComboBean> lobj = new List<ComboBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdFoto", SqlDbType.VarChar, -1);
            parameter.Value = idFoto;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_GetFotoBase64", alParameters);

            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ComboBean obj = new ComboBean
                    {
                        Codigo = row["Imagen"].ToString(),
                        Nombre = row["Nombre"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<ComboBean> GetConfiguraOportunidad()
        {
            List<ComboBean> lobj = new List<ComboBean>();
            ArrayList alParameters = new ArrayList();

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRConfiguracionOportunidad", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ComboBean obj = new ComboBean
                    {
                        Codigo = row["IDSubTipoActividad"].ToString(),
                        Nombre = row["Descripcion"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<OportunidadBean> GetConfiguracionOportunidades(String idCodConf, String IdOp, String UsuSession, String storeprocedure)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idCodConf", SqlDbType.VarChar, 100);
            parameter.Value = idCodConf;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idoportunidad", SqlDbType.VarChar, 100);
            parameter.Value = IdOp;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idPerfilUsuario", SqlDbType.VarChar, 100);
            parameter.Value = UsuSession;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable(storeprocedure, alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    OportunidadBean obj = new OportunidadBean
                    {
                        IdConfiguracionoportunidadDetalle = int.Parse(row["IdSubTipoActividadDetalle"].ToString()),
                        Etiqueta = row["Etiqueta"].ToString(),
                        idTipoControl = row["CodigoTipoControl"].ToString(),
                        CodigoTipoControl = row["codigoControl"].ToString(),
                        CodigoGeneral = row["CodigoGeneral"].ToString(),
                        Modificable = row["Modificable"].ToString(),
                        Obligatorio = row["Obligatorio"].ToString(),
                        MaxCaracter = row["MaxCaracter"].ToString(),
                        IdConfiguracionOportunidad = row["IdSubTipoActividad"].ToString(),
                        ValorControl = row["ValorControl"].ToString(),
                        idPadre = row["idPadre"].ToString(),
                        EtapaSiguiente = row["siguienteEstapa"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<OportunidadBean> GetConfiguracionNewOportunidades(String idTipoActividad)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idTipoActividad", SqlDbType.VarChar, 100);
            parameter.Value = idTipoActividad;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelSubTipoActividadNewOportunidad", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    OportunidadBean obj = new OportunidadBean
                    {
                        IdConfiguracionoportunidadDetalle = int.Parse(row["IdSubTipoActividadDetalle"].ToString()),
                        Etiqueta = row["Etiqueta"].ToString(),
                        idTipoControl = row["CodigoTipoControl"].ToString(),
                        CodigoTipoControl = row["codigoControl"].ToString(),
                        CodigoGeneral = row["CodigoGeneral"].ToString(),
                        Modificable = row["Modificable"].ToString(),
                        Obligatorio = row["Obligatorio"].ToString(),
                        MaxCaracter = row["MaxCaracter"].ToString(),
                        IdConfiguracionOportunidad = row["IdSubTipoActividad"].ToString(),
                        ValorControl = row["ValorControl"].ToString(),
                        idPadre = row["idPadre"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<ComboBean> GetEtapas(String codigo)
        {
            List<ComboBean> lobj = new List<ComboBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodEtapa", SqlDbType.VarChar, 100);
            parameter.Value = codigo;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGREtapa", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ComboBean obj = new ComboBean
                    {
                        Codigo = row["IdEtapa"].ToString(),
                        Nombre = row["Descripcion"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<ComboBean> GetEstado()
        {
            List<ComboBean> lobj = new List<ComboBean>();
            ArrayList alParameters = new ArrayList();


            DataTable dt = SqlConnector.getDataTable("spS_ManSelGREstado", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ComboBean obj = new ComboBean
                    {
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Descripcion"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<ComboBean> GetGrupos(String codigo, String idPadre)
        {
            List<ComboBean> lobj = new List<ComboBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodigoGrupo", SqlDbType.VarChar, 100);
            parameter.Value = codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idPadre", SqlDbType.VarChar, 100);
            parameter.Value = idPadre;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGrupoDetalle", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ComboBean obj = new ComboBean
                    {
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<Combo> GetClientesZonCan(String cliente, String idZona, String idCanal)
        {
            List<Combo> lobj = new List<Combo>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@cliente", SqlDbType.VarChar, 100);
            parameter.Value = cliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idCanal", SqlDbType.BigInt);
            parameter.Value = idCanal;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idZona", SqlDbType.BigInt);
            parameter.Value = idZona;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRClienteZonCan", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    Combo obj = new Combo
                    {
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["descripcion"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<Combo> GetClientesOpor(String cliente)
        {
            List<Combo> lobj = new List<Combo>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@cliente", SqlDbType.VarChar, 100);
            parameter.Value = cliente;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRClienteOpor", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    Combo obj = new Combo
                    {
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["descripcion"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static Int32 Insert(OportunidadBean item, String idClienteInstalacion)
        {
            // Create a DataTable with the modified rows.  
            DataTable oDataTableLstCrtDin = new DataTable();
            oDataTableLstCrtDin = ConvertToDataTable(item.lstControlDinamico);

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdConfiguracionActividad", SqlDbType.BigInt);
            parameter.Value = item.ConfOpor;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idNegocio", SqlDbType.VarChar, 1);
            parameter.Value = item.idNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdUsuarioResponsable", SqlDbType.BigInt);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idCliente", SqlDbType.BigInt);
            parameter.Value = item.CodCliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@lstCrt", SqlDbType.Structured);
            parameter.Value = oDataTableLstCrtDin;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdContacto", SqlDbType.BigInt);
            parameter.Value = item.idContacto;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@observaciones", SqlDbType.VarChar, -1);
            parameter.Value = item.observaciones;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@fecha", SqlDbType.DateTime);
            parameter.Value = item.fecha;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@latitud", SqlDbType.Float);
            parameter.Value = item.latitud;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@longitud", SqlDbType.Float);
            parameter.Value = item.longitud;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idClienteInstalacion", SqlDbType.BigInt);
            parameter.Value = idClienteInstalacion;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGRActividad", alParameters));
        }


        public static Int32 InsertOportunidad(OportunidadBean item)
        {
            // Create a DataTable with the modified rows.  
            DataTable oDataTableLstCrtDin = new DataTable();
            oDataTableLstCrtDin = ConvertToDataTable(item.lstControlDinamico);

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdConfiguracionActividad", SqlDbType.BigInt);
            parameter.Value = item.ConfOpor;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idNegocio", SqlDbType.VarChar, 1);
            parameter.Value = item.idNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdUsuarioResponsable", SqlDbType.BigInt);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idCliente", SqlDbType.BigInt);
            parameter.Value = item.CodCliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@lstCrt", SqlDbType.Structured);
            parameter.Value = oDataTableLstCrtDin;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdContacto", SqlDbType.BigInt);
            parameter.Value = DBNull.Value;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@observaciones", SqlDbType.VarChar, -1);
            parameter.Value = DBNull.Value;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@fecha", SqlDbType.DateTime);
            parameter.Value = DBNull.Value;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@latitud", SqlDbType.Float);
            parameter.Value = DBNull.Value;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@longitud", SqlDbType.Float);
            parameter.Value = DBNull.Value;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGRActividadOportunidad", alParameters));
        }

        public static Int32 InsertFoto(String idOportunidad, String idFoto, Byte[] foto)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdActividad", SqlDbType.VarChar, 100);
            parameter.Value = idOportunidad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdFoto", SqlDbType.VarChar, 100);
            parameter.Value = idFoto;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@FOTO", SqlDbType.Image, foto.Length);
            parameter.Value = foto;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("SP_InsREGISTRA_FOTO", alParameters));
        }
        public static Int32 InsertEtapa(OportunidadBean item)
        {
            // Create a DataTable with the modified rows.  
            DataTable oDataTableLstCrtDin = new DataTable();
            oDataTableLstCrtDin = ConvertToDataTable(item.lstControlDinamico);

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdOportunidad", SqlDbType.BigInt);
            parameter.Value = item.id;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@lstCrt", SqlDbType.Structured);
            parameter.Value = oDataTableLstCrtDin;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdUsuario", SqlDbType.VarChar, 15);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@CambiaEtapa", SqlDbType.VarChar, 15);
            parameter.Value = item.CambiaEtapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@fecha", SqlDbType.DateTime);
            parameter.Value = item.fecha;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManUpdGROportunidadEtapaBand", alParameters));
        }
        public static void Update(OportunidadBean item)
        {
            // Create a DataTable with the modified rows.  
            DataTable oDataTableLstCrtDin = new DataTable();
            oDataTableLstCrtDin = ConvertToDataTable(item.lstControlDinamico);

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdOportunidad", SqlDbType.BigInt);
            parameter.Value = item.id;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdConfiguracionOportunidad", SqlDbType.BigInt);
            parameter.Value = item.ConfOpor;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@ExisteCliente", SqlDbType.VarChar, 1);
            parameter.Value = item.CliExist;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdUsuarioResponsable", SqlDbType.BigInt);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idCliente", SqlDbType.BigInt);
            parameter.Value = item.CodCliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Razon_Social", SqlDbType.VarChar, 50);
            parameter.Value = item.RazonSocial;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@RUC", SqlDbType.VarChar, 11);
            parameter.Value = item.Ruc;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@CodRubro", SqlDbType.VarChar, 15);
            parameter.Value = item.Rubro;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@CodRegion", SqlDbType.VarChar, 15);
            parameter.Value = item.Region;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@CodCanal", SqlDbType.VarChar, 15);
            parameter.Value = item.Canal;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@lstCrt", SqlDbType.Structured);
            parameter.Value = oDataTableLstCrtDin;
            alParameters.Add(parameter);

            SqlConnector.executeNonQuery("spS_ManUpdGROportunidadBand", alParameters);
        }
        public static void Active(String id, String flag)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdOportunidad", SqlDbType.BigInt);
            parameter.Value = id;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 1);
            parameter.Value = flag;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("SP_SelUpdOportunidadEliminarBand", alParameters);
        }
        public static void Cerrar(String id, String flag)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdOportunidad", SqlDbType.BigInt);
            parameter.Value = id;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 1);
            parameter.Value = flag;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("SP_SelUpdOportunidadCerrarBand", alParameters);
        }
        public static DataTable ConvertToDataTable<T>(IList<T> data)
        {
            PropertyDescriptorCollection properties =
               TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            foreach (PropertyDescriptor prop in properties)
                table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (T item in data)
            {
                DataRow row = table.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                table.Rows.Add(row);
            }
            return table;

        }
        public static List<OportunidadBean> GetConfiguracionEtapa(String idEtapa, String IdOp, String UsuSession)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idEtapa", SqlDbType.VarChar, 100);
            parameter.Value = idEtapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idoportunidad", SqlDbType.VarChar, 100);
            parameter.Value = IdOp;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idPerfilUsuario", SqlDbType.VarChar, 100);
            parameter.Value = UsuSession;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelEtapaOportunidad", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    OportunidadBean obj = new OportunidadBean
                    {
                        idEtapa = row["idEtapa"].ToString(),
                        Etiqueta = row["Etiqueta"].ToString(),
                        //RazonSocial = row["Razon_Social"].ToString(),
                        idTipoControl = row["CodigoTipoControl"].ToString(),
                        CodigoTipoControl = row["codigoControl"].ToString(),
                        CodigoGeneral = row["CodigoGeneral"].ToString(),
                        //CodCliente = row["idCliente"].ToString(),
                        Modificable = row["Modificable"].ToString(),
                        Obligatorio = row["Obligatorio"].ToString(),
                        MaxCaracter = row["MaxCaracter"].ToString(),
                        IdConfiguracionoportunidadDetalle = Int32.Parse(row["IdEtapaDetalle"].ToString()),
                        EtapaSiguiente = row["siguienteEstapa"].ToString(),
                        ValorControl = row["ValorControl"].ToString(),
                        txtcontrol = row["txtcontrol"].ToString(),
                        //IdFoto = row["IdFoto"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<OportunidadBean> GetConfiguracionEtapaHistorial(String idEtapa, String IdOp, String UsuSession)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idEtapa", SqlDbType.VarChar, 100);
            parameter.Value = idEtapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idoportunidad", SqlDbType.VarChar, 100);
            parameter.Value = IdOp;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idPerfilUsuario", SqlDbType.VarChar, 100);
            parameter.Value = UsuSession;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelEtapaOportunidadHistorial", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    OportunidadBean obj = new OportunidadBean
                    {
                        idEtapa = row["idEtapa"].ToString(),
                        Etiqueta = row["Etiqueta"].ToString(),
                        //RazonSocial = row["Razon_Social"].ToString(),
                        idTipoControl = row["CodigoTipoControl"].ToString(),
                        CodigoTipoControl = row["codigoControl"].ToString(),
                        CodigoGeneral = row["CodigoGeneral"].ToString(),
                        //CodCliente = row["idCliente"].ToString(),
                        Modificable = row["Modificable"].ToString(),
                        Obligatorio = row["Obligatorio"].ToString(),
                        MaxCaracter = row["MaxCaracter"].ToString(),
                        IdConfiguracionoportunidadDetalle = Int32.Parse(row["IdEtapaDetalle"].ToString()),
                        EtapaSiguiente = row["siguienteEstapa"].ToString(),
                        ValorControl = row["ValorControl"].ToString(),
                        txtcontrol = row["txtcontrol"].ToString(),
                        //IdFoto = row["IdFoto"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<OportunidadBean> GetConfiguracionEtapaLista(String IdOp)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idoportunidad", SqlDbType.VarChar, 100);
            parameter.Value = IdOp;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("SP_SelGrOportunidadEtapaBand", alParameters);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    OportunidadBean obj = new OportunidadBean
                    {
                        rows = int.Parse(row["row"].ToString()),
                        idEtapa = row["idEtapa"].ToString(),
                        IdOportunidad = row["IdOportunidad"].ToString(),

                        Etapa = row["Etapa"].ToString(),
                        FechaInicio = row["fechaInicio"].ToString(),
                        FechaFin = row["fechaFin"].ToString(),

                        Responsable = row["responsable"].ToString(),

                        TiempoEtapa = row["TiempoEtapa"].ToString(),
                        TiempoEtapaEjecutado = row["TiempoEtapaEjecutado"].ToString(),
                        Retrazo = row["Retrazo"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static DataTable GetUsuariosOportunidad(String idOportunidad)
        {
            List<Combo> lobj = new List<Combo>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idOportunidad", SqlDbType.VarChar, 100);
            parameter.Value = idOportunidad;
            alParameters.Add(parameter);

            return SqlConnector.getDataTable("spS_SelOportunidadCorreo", alParameters);

        }

        public static List<FotoBean> GetOportunidadEtapaFoto(String idOportunidad, String idEtapa)
        {
            List<FotoBean> lfoto = new List<FotoBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdOportunidad", SqlDbType.VarChar, 100);
            parameter.Value = idOportunidad;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@IdEtapa", SqlDbType.VarChar, 100);
            parameter.Value = idEtapa;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("SP_SelFotoOportunidadBand", alParameters);
            FotoBean obj = new FotoBean();
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new FotoBean
                    {
                        foto = (byte[])row["foto"],
                        titulo = row["NombreFoto"].ToString()

                    };
                    lfoto.Add(obj);
                }
            }
            return lfoto;
        }

        public static List<Combo> GetClientes(String cliente)
        {
            List<Combo> lobj = new List<Combo>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@cliente", SqlDbType.VarChar, 100);
            parameter.Value = cliente;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRCliente", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    Combo obj = new Combo
                    {
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["descripcion"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static PaginateOportunidadBean GetReporteAllPaginateOportunidades(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaEstimadaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaEstimadaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaEstimadaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaEstimadaFin;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@codOp", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Coordinador", SqlDbType.VarChar, 4000);
            parameter.Value = item.Coordinador;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Responsable", SqlDbType.VarChar, 4000);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Estado", SqlDbType.VarChar, 4000);
            parameter.Value = item.Estado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Etapa", SqlDbType.VarChar, 4000);
            parameter.Value = item.Etapa;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Rubro", SqlDbType.VarChar, 4000);
            parameter.Value = item.Rubro;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Cliente", SqlDbType.VarChar, 4000);
            parameter.Value = item.Cliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@UsuarioSession", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_RepSelOportunidadAllPaginate", alParameters);
            int total = 0;
            List<string> ecd = new List<string>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataColumn col in dt.Columns)
                {
                    string nombre = col.ColumnName;
                    if (nombre.Count() > 3)
                    {
                        string cod = nombre.Substring(0, 3);
                        if (cod.Equals(Constantes.ColDinamico))
                        {
                            ecd.Add(nombre);
                        };
                    }

                }

                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    List<ComboBean> lcd = new List<ComboBean>();
                    foreach (var lstrin in ecd.ToList())
                    {
                        var columna = lstrin.Substring(3, lstrin.Count() - 3);
                        lcd.Add(new ComboBean
                        {
                            Codigo = columna,
                            Nombre = row[lstrin].ToString(),
                        });
                    }

                    OportunidadBean obj = new OportunidadBean
                    {
                        Codigo = row["Codigo"].ToString(),
                        Region = row["Region"].ToString(),
                        Canal = row["Canal"].ToString(),
                        Rubro = row["Rubro"].ToString(),
                        Cliente = row["Cliente"].ToString(),
                        Coordinador = row["Coordinador"].ToString(),
                        Responsable = row["Responsable"].ToString(),
                        Estado = row["Estado"].ToString(),
                        Etapa = row["Etapa"].ToString(),
                        FechaRegistro = row["FechaRegistro"].ToString(),
                        Retrazo = row["Retrazo"].ToString(),

                        columnasDinamicas = lcd,
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return new PaginateOportunidadBean { lstResultados = lobj, totalrows = total }
           ;
        }

        public static DataTable GetReporteAllPaginateOportunidadesExcel(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@codOp", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Coordinador", SqlDbType.VarChar, 4000);
            parameter.Value = item.Coordinador;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Responsable", SqlDbType.VarChar, 4000);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Estado", SqlDbType.VarChar, 4000);
            parameter.Value = item.Estado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Etapa", SqlDbType.VarChar, 4000);
            parameter.Value = item.Etapa;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Rubro", SqlDbType.VarChar, 4000);
            parameter.Value = item.Rubro;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Cliente", SqlDbType.VarChar, 4000);
            parameter.Value = item.Cliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@UsuarioSession", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@ConfRep", SqlDbType.VarChar, 100);
            parameter.Value = item.ConfRep;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_RepSelOportunidadAllPaginateExcel", alParameters);

            return dt;
            ;
        }
    }
}
