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
    public class GeneralTipoModel
    {
        public static Int32 Insert(GeneralTipoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdTipo", SqlDbType.Int);
            parameter.Value = item.IdTipo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGRGeneral", alParameters));
        }
        public static void Update(GeneralTipoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGeneral", SqlDbType.BigInt);
            parameter.Value = item.IdGeneral;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdTipo", SqlDbType.Int);
            parameter.Value = item.IdTipo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRGeneral", alParameters);
        }
        public static GeneralTipoBean Get(GeneralTipoBean item)
        {
            GeneralTipoBean obj = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGeneral", SqlDbType.BigInt);
            parameter.Value = item.IdGeneral;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGeneral", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new GeneralTipoBean
                    {
                        IdGeneral = int.Parse(row["IdGeneral"].ToString()),
                        IdTipo = int.Parse(row["IdTipo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString()
                    };
                }
            }
            return obj;
        }
        public static void Disabled(GeneralTipoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGeneral", SqlDbType.BigInt);
            parameter.Value = item.IdGeneral;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRGeneralDisabled", alParameters);
        }
        public static void Activate(GeneralTipoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGeneral", SqlDbType.BigInt);
            parameter.Value = item.IdGeneral;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRGeneralActivate", alParameters);
        }
        public static List<GeneralTipoBean> GetAll(GeneralTipoBean item)
        {
            List<GeneralTipoBean> lobj = new List<GeneralTipoBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdTipo", SqlDbType.Int);
            parameter.Value = item.IdTipo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.Char, 1);
            parameter.Value = item.Flag;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGeneralAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    GeneralTipoBean obj = new GeneralTipoBean
                    {
                        IdGeneral = int.Parse(row["IdGeneral"].ToString()),
                        IdTipo = int.Parse(row["IdTipo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        Flag = row["Flag"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static PaginateGeneralTipoBean GetAllPaginate(GeneralTipoBean item)
        {
            List<GeneralTipoBean> lobj = new List<GeneralTipoBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdTipo", SqlDbType.Int);
            parameter.Value = item.IdTipo;
            alParameters.Add(parameter);
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
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGeneralAllPaginate", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    GeneralTipoBean obj = new GeneralTipoBean
                    {
                        item = int.Parse(row["item"].ToString()),
                        IdGeneral = int.Parse(row["IdGeneral"].ToString()),
                        IdTipo = int.Parse(row["IdTipo"].ToString()),
                        Tipo = row["Tipo"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        Flag = row["Flag"].ToString(),
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return new PaginateGeneralTipoBean { lstResultados = lobj, totalrows = total };
        }

        //public static List<GeneralTipoBean> getClienteZonas(String idCLiente)
        //{
        //    List<GeneralTipoBean> lobj = new List<GeneralTipoBean>();
        //    ArrayList alParameters = new ArrayList();
        //    SqlParameter parameter = new SqlParameter();
        //    parameter = new SqlParameter("@idCliente", SqlDbType.VarChar, 50);
        //    parameter.Value = idCLiente;
        //    alParameters.Add(parameter);
        //    DataTable dt = SqlConnector.getDataTable("spS_ManSelClienteZonas", alParameters);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            GeneralTipoBean obj = new GeneralTipoBean
        //            {
        //                IdGeneral = int.Parse(row["IdGeneral"].ToString()),
        //                Nombre = row["Nombre"].ToString(),
        //                Flag = row["sel"].ToString(),
        //            };
        //            lobj.Add(obj);
        //        }
        //    }
        //    return lobj;
        //}
    }
}
