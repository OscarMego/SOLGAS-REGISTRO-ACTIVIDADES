using Model.bean;
using Model.functions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Model
{
    public class TipoActividadModel
    {
        public static Int32 Insert(TipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdNegocio", SqlDbType.BigInt);
            parameter.Value = item.idNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@meta", SqlDbType.VarChar, 100);
            parameter.Value = item.meta;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@oportunidad", SqlDbType.Char, 1);
            parameter.Value = item.oportunidad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@contacto", SqlDbType.Char, 1);
            parameter.Value = item.contacto;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGRTipoActividad", alParameters));
        }
        public static void Update(TipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Id", SqlDbType.BigInt);
            parameter.Value = item.id;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdNegocio", SqlDbType.BigInt);
            parameter.Value = item.idNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@meta", SqlDbType.VarChar, 100);
            parameter.Value = item.meta;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@oportunidad", SqlDbType.Char, 1);
            parameter.Value = item.oportunidad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@contacto", SqlDbType.Char, 1);
            parameter.Value = item.contacto;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRTipoActividad", alParameters);
        }
        public static TipoActividadBean Get(TipoActividadBean item)
        {
            TipoActividadBean obj = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Id", SqlDbType.Int);
            parameter.Value = item.id;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRTipoActividad", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new TipoActividadBean
                    {
                        id = int.Parse(row["id"].ToString()),
                        codigo = row["codigo"].ToString(),
                        nombre = row["nombre"].ToString(),
                        idNegocio = int.Parse(row["IdNegocio"].ToString()),
                        meta = row["meta"].ToString(),
                        oportunidad = row["flagOportunidad"].ToString(),
                        contacto = row["flagContacto"].ToString()
                    };
                }
            }
            return obj;
        }
        public static void Disabled(TipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Id", SqlDbType.BigInt);
            parameter.Value = item.id;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdTipoActividadDisabled", alParameters);
        }
        public static void Activate(TipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Id", SqlDbType.BigInt);
            parameter.Value = item.id;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRTipoActividadActivate", alParameters);
        }


        public static List<TipoActividadBean> GetReporteDashboard(string idUsuario)
        {
            List<TipoActividadBean> lobj = new List<TipoActividadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdUsuario", SqlDbType.VarChar, 10);
            parameter.Value = idUsuario;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("SP_RepGraficoDashboardActividad", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    TipoActividadBean obj = new TipoActividadBean
                    {
                        codigo = row["Codigo"].ToString(),
                        nombre = row["Nombre"].ToString(),
                        total =  row["Total"].ToString(),
                        meta = row["Meta"].ToString()
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<TipoActividadBean> GetAll(TipoActividadBean item)
        {
            List<TipoActividadBean> lobj = new List<TipoActividadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Id", SqlDbType.Int);
            parameter.Value = item.id;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Negocio", SqlDbType.BigInt);
            parameter.Value = item.idNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.Char, 1);
            parameter.Value = item.Flag;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRTipoActividadAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    TipoActividadBean obj = new TipoActividadBean
                    {
                        id = int.Parse(row["id"].ToString()),
                        codigo = row["codigo"].ToString(),
                        nombre = row["nombre"].ToString(),
                        idNegocio = int.Parse(row["idNegocio"].ToString()),
                        Flag = row["FlagTA"].ToString(),
                        oportunidad = row["FlagOportunidad"].ToString(),
                        contacto = row["FlagContacto"].ToString()
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static PaginateTipoActividadBean GetAllPaginate(TipoActividadBean item)
        {
            List<TipoActividadBean> lobj = new List<TipoActividadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.Char, 1);
            parameter.Value = item.Flag;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Negocio", SqlDbType.Int);
            parameter.Value = item.idNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRTipoActividadAllPaginate", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    TipoActividadBean obj = new TipoActividadBean
                    {
                        item = int.Parse(row["item"].ToString()),
                        id = int.Parse(row["id"].ToString()),
                        codigo = row["codigo"].ToString(),
                        nombre = row["nombre"].ToString(),
                        canal = row["Negocio"].ToString()

                    };
                    lobj.Add(obj);
                }
            }
            return new PaginateTipoActividadBean { lstResultados = lobj, totalrows = total };
        }
    }
}
