using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
namespace Model
{
    public class GrupoModel
    {
        public static Int32 Insert(GrupoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 50);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdNivel", SqlDbType.BigInt);
            parameter.Value = item.IdNivel;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@CodigoPadreGrupo", SqlDbType.VarChar, 50);
            parameter.Value = item.CodigoPadreGrupo;
            alParameters.Add(parameter);

            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGrupo", alParameters));
        }
        public static void Update(GrupoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDGrupo", SqlDbType.BigInt);
            parameter.Value = item.IDGrupo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 50);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdNivel", SqlDbType.BigInt);
            parameter.Value = item.IdNivel;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@CodigoPadreGrupo", SqlDbType.VarChar, 50);
            parameter.Value = item.CodigoPadreGrupo;
            alParameters.Add(parameter);

            SqlConnector.executeNonQuery("spS_ManUpdGrupo", alParameters);
        }
        public static DataTable Get(GrupoBean item)
        {

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDGrupo", SqlDbType.BigInt);
            parameter.Value = item.IDGrupo;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGrupo", alParameters);
            return dt;
        }

        public static void Activate(GrupoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDGrupo", SqlDbType.BigInt);
            parameter.Value = item.IDGrupo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 1);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGrupoActivate", alParameters);
        }
        public static DataTable GetAllPaginate(GrupoBean item)
        {

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 50);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 100);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGrupoAllPaginate", alParameters);

            return dt;
            ;
        }
        public static DataTable Validate(GrupoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDGrupo", SqlDbType.BigInt);
            parameter.Value = item.IDGrupo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 100);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGrupoValida", alParameters);
            return dt;
        }
        public static DataTable GetPadres(GrupoBean item)
        {

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDGrupo", SqlDbType.BigInt);
            parameter.Value = item.IDGrupo;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGrupoPadres", alParameters);
            return dt;
        }
    }
}
