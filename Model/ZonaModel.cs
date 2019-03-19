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
    public class ZonaModel
    {
        public static Int32 Insert(ZonaBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 80);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGRZona", alParameters));
        }
        public static void Update(ZonaBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdZona", SqlDbType.BigInt);
            parameter.Value = item.IdZona;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRZona", alParameters);
        }
        public static ZonaBean Get(ZonaBean item)
        {
            ZonaBean obj = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdZona", SqlDbType.BigInt);
            parameter.Value = item.IdZona;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRZona", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new ZonaBean
                    {
                        IdZona = int.Parse(row["IdZona"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString()
                    };
                }
            }
            return obj;
        }
        public static void Disabled(ZonaBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdZona", SqlDbType.BigInt);
            parameter.Value = item.IdZona;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRZonaDisabled", alParameters);
        }
        public static void Activate(ZonaBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdZona", SqlDbType.BigInt);
            parameter.Value = item.IdZona;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRZonaActivate", alParameters);
        }
        public static List<ZonaBean> GetAll(ZonaBean item)
        {
            List<ZonaBean> lobj = new List<ZonaBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.Char, 1);
            parameter.Value = item.Flag;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRZonaAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ZonaBean obj = new ZonaBean
                    {
                        IdZona = int.Parse(row["IdZona"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        Flag = row["Flag"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<ZonaBean> GetFiltroActividad(string idUsuario)
        {
            List<ZonaBean> lobj = new List<ZonaBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FiltroUsuario", SqlDbType.VarChar, 10);
            parameter.Value = idUsuario;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("upS_SelFiltroActividadAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ZonaBean obj = new ZonaBean
                    {
                        IdZona = int.Parse(row["IdZona"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        Flag = row["Flag"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static PaginateZonaBean GetAllPaginate(ZonaBean item)
        {
            List<ZonaBean> lobj = new List<ZonaBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.Char, 1);
            parameter.Value = item.Flag;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRZonaAllPaginate", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    ZonaBean obj = new ZonaBean
                    {
                        item = int.Parse(row["item"].ToString()),
                        IdZona = int.Parse(row["IdZona"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        Flag = row["Flag"].ToString(),
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return new PaginateZonaBean { lstResultados = lobj, totalrows = total };
        }

        public static List<ZonaBean> getClienteZonas(String idCLiente)
        {
            List<ZonaBean> lobj = new List<ZonaBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter = new SqlParameter();
            parameter = new SqlParameter("@idCliente", SqlDbType.VarChar, 50);
            parameter.Value = idCLiente;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelClienteZonas", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ZonaBean obj = new ZonaBean
                    {
                        IdZona = int.Parse(row["IdZona"].ToString()),
                        Nombre = row["Nombre"].ToString(),
                        Flag = row["sel"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

    }
}
