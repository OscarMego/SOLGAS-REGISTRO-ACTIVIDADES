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
    public class EtapaModel
    {
        public static Int32 Insert(EtapaBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodEtapa", SqlDbType.VarChar, 15);
            parameter.Value = item.CodEtapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Descripcion", SqlDbType.VarChar, 80);
            parameter.Value = item.Descripcion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@EtapaPredecesora", SqlDbType.VarChar, 15);
            parameter.Value = item.EtapaPredecesora;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@TiempoEtapa", SqlDbType.VarChar, 300);
            parameter.Value = item.TiempoEtapa;
            alParameters.Add(parameter);

            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGREtapa", alParameters));
        }

        public static Int32 InsertDetalle(List<EtapaBean> detalle)
        {
            List<EtapaDetalleBean> LstEtapaDetalle = new List<EtapaDetalleBean>();

            foreach (EtapaBean item in detalle)
            {
                EtapaDetalleBean EtapaDetalle = new EtapaDetalleBean();
                EtapaDetalle.IdEtapa = item.IdEtapa.ToString();
                EtapaDetalle.IdEtapaDetalle = item.IdEtapaDetalle;
                EtapaDetalle.Id = item.Id;
                EtapaDetalle.Etiqueta = item.Etiqueta;
                EtapaDetalle.TipoControl = item.TipoControl;
                EtapaDetalle.MaxCaracter = item.MaxCaracter;
                EtapaDetalle.Grupo = item.IdGeneral;
                EtapaDetalle.Obligatorio = item.FlgObligatorio;
                EtapaDetalle.Modificable = item.FlgModificable;
                EtapaDetalle.FlgHabilitado = item.FlgHabilitado;
                EtapaDetalle.Perfiles = item.PerfilesCont;

                LstEtapaDetalle.Add(EtapaDetalle);
            }

            string Cadena = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
            SqlConnection connection = new SqlConnection(Cadena);

            try
            {
                connection.Open();
                // Create a DataTable with the modified rows.  
                DataTable oDataTableListaEtapaDetalle = new DataTable();
                oDataTableListaEtapaDetalle = ConvertToDataTable(LstEtapaDetalle);

                // Configure the SqlCommand and SqlParameter.  
                SqlCommand insertCommand = new SqlCommand("spS_ManInsGREtapaDetalle", connection);

                insertCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter tvpParam = insertCommand.Parameters.AddWithValue("@lstEtapaDetalle", oDataTableListaEtapaDetalle);
                tvpParam.SqlDbType = SqlDbType.Structured;

                insertCommand.Parameters.Add("@codError", SqlDbType.Int).Direction = ParameterDirection.Output;
                // Execute the command.  
                insertCommand.ExecuteScalar();

                connection.Close();
                connection.Dispose();

                return 1;
            }
            catch (Exception e)
            {
                connection.Close();
                connection.Dispose();

                return -1;
            }

            //return poRutaFefo;

            //return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGREtapaDetalle", alParameters));
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

        public static void Update(EtapaBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdEtapa", SqlDbType.VarChar, 10);
            parameter.Value = item.IdEtapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@CodEtapa", SqlDbType.VarChar, 10);
            parameter.Value = item.CodEtapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Descripcion", SqlDbType.VarChar, 80);
            parameter.Value = item.Descripcion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@EtapaPredecesora", SqlDbType.VarChar, 10);
            parameter.Value = item.EtapaPredecesora;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@TiempoEtapa", SqlDbType.VarChar, 300);
            parameter.Value = item.TiempoEtapa;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGREtapa", alParameters);
        }
        public static EtapaBean Get(EtapaBean item)
        {
            EtapaBean obj = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodEtapa", SqlDbType.VarChar, 15);
            parameter.Value = item.CodEtapa;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGREtapa", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new EtapaBean
                    {
                        IdEtapa = int.Parse(row["IdEtapa"].ToString()),
                        CodEtapa = row["CodEtapa"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        IdEtapaPredecesora = row["IdEtapaPredecesora"].ToString(),
                        TiempoEtapa = row["TiempoEtapa"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString()
                    };
                }
            }
            return obj;
        }
        public static DataTable GetEtapaPerfilModifica(String idEtapaDetalle)
        {
            EtapaBean obj = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idEtapaDetalle", SqlDbType.VarChar, 15);
            parameter.Value = idEtapaDetalle;
            alParameters.Add(parameter);
            return SqlConnector.getDataTable("sps_ManSelEtapaPerfilModifica", alParameters);
        }

        public static EtapaBean GetDetalle(EtapaBean item)
        {
            EtapaBean obj = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodEtapa", SqlDbType.BigInt);
            parameter.Value = item.CodEtapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@CodEtapaDetalle", SqlDbType.BigInt);
            parameter.Value = item.CodEtapaDetalle;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGREtapaDetalle", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new EtapaBean
                    {
                        IdEtapaDetalle = int.Parse(row["IdEtapaDetalle"].ToString()),
                        Etiqueta = row["Etiqueta"].ToString(),
                        TipoControl = row["TipoControl"].ToString(),
                        MaxCaracter = row["MaxCaracter"].ToString(),
                        Grupo = row["Grupo"].ToString(),
                        FlgModificable = row["Modificable"].ToString(),
                        FlgObligatorio = row["Obligatorio"].ToString()
                    };
                }
            }
            return obj;
        }

        public static void Desactivate(EtapaBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodEtapa", SqlDbType.VarChar, 100);
            parameter.Value = item.CodEtapa;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGREtapaDesactivate", alParameters);
        }
        public static void Activate(EtapaBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodEtapa", SqlDbType.VarChar, 100);
            parameter.Value = item.CodEtapa;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGREtapaActivate", alParameters);
        }

        public static List<EtapaBean> ObtenerEtapaPredecesora(String Codigo, EtapaBean item)
        {
            List<EtapaBean> lobj = new List<EtapaBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            parameter.Value = Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ObtenerEtapaPredecesora", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    EtapaBean obj = new EtapaBean
                    {
                        CodEtapa = row["CodEtapa"].ToString(),
                        Descripcion = row["Descripcion"].ToString()
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<TipoControlBean> ObtenerTipoControl(TipoControlBean item)
        {
            List<TipoControlBean> lobj = new List<TipoControlBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;

            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ObtenerTipoControl", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    TipoControlBean obj = new TipoControlBean
                    {
                        Id = int.Parse(row["Id"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString()
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<GrupoBean> ObtenerGrupo(GrupoBean item)
        {
            List<GrupoBean> lobj = new List<GrupoBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;

            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ObtenerGrupo", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    GrupoBean obj = new GrupoBean
                    {
                        IDGrupo = Int32.Parse(row["IDGrupo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        CodigoPadreGrupo = row["CodigoPadreGrupo"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<EtapaBean> GetAll(EtapaBean item)
        {
            List<EtapaBean> lobj = new List<EtapaBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodEtapa", SqlDbType.VarChar, 10);
            parameter.Value = item.CodEtapa;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGREtapaAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    EtapaBean obj = new EtapaBean
                    {
                        IdEtapaDetalle = int.Parse(row["IdEtapaDetalle"].ToString()),
                        Id = int.Parse(row["item"].ToString()),
                        Id2 = int.Parse(row["item"].ToString()) - 1,
                        Etiqueta = row["Etiqueta"].ToString(),
                        TipoControl = row["TipoControl"].ToString(),
                        TipoControlDescrip = row["TipoControlDescrip"].ToString(),
                        MaxCaracter = row["MaxCaracter"].ToString(),
                        Grupo = row["Grupo"].ToString(),
                        FlgObligatorio = row["Obligatorio"].ToString(),
                        FlgModificable = row["Modificable"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        PerfilesCont = row["Perfiles"].ToString(),
                        PerfilesDescrip = row["PerfilesDesc"].ToString(),
                        IdGeneral = row["CodigoGeneral"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static PaginateEtapaBean GetAllPaginate(EtapaBean item)
        {
            List<EtapaBean> lobj = new List<EtapaBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Descripcion", SqlDbType.VarChar, 10);
            parameter.Value = item.Etapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGREtapaAllPaginate", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    EtapaBean obj = new EtapaBean
                    {
                        IdEtapa = int.Parse(row["IdEtapa"].ToString()),
                        CodEtapa = row["CodEtapa"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        EtapaPredecesora = row["EtapaPredecesora"].ToString(),
                        TiempoEtapa = row["TiempoEtapa"].ToString() + " días",
                        FlgHabilitado = row["FlgHabilitado"].ToString()
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return new PaginateEtapaBean { lstResultados = lobj, totalrows = total }
           ;
        }

        public static string Validate(EtapaBean item)
        {
            string mensaje = "";
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CodEtapa", SqlDbType.VarChar, 15);
            parameter.Value = item.CodEtapa;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGREtapaValida", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    mensaje += row["Mensaje"].ToString() + ", ";
                }
                mensaje = mensaje.Substring(0, mensaje.Length - 2);
                throw new Exception(mensaje);
            }
            return "";
        }

    }
}
