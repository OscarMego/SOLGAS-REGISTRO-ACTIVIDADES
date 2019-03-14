using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Data.OracleClient;

namespace Model
{
    public class GeneralDetalleModel
    {
        public static Int32 Insert(GrupoDetalleBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGrupo", SqlDbType.BigInt);
            parameter.Value = item.IdGrupo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 50);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCodigoDetallePadre", SqlDbType.VarChar, 50);
            parameter.Value = item.IdCodigoDetallePadre;
            alParameters.Add(parameter);

            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGrupoDetalle", alParameters));
        }
        public static void Update(GrupoDetalleBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGrupoDetalle", SqlDbType.BigInt);
            parameter.Value = item.IdGrupoDetalle;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 50);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCodigoDetallePadre", SqlDbType.VarChar, 50);
            parameter.Value = item.IdCodigoDetallePadre;
            alParameters.Add(parameter);

            SqlConnector.executeNonQuery("spS_ManUpdGrupoDetalle", alParameters);
        }
        public static DataTable Get(GrupoDetalleBean item)
        {

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGrupoDetalle", SqlDbType.BigInt);
            parameter.Value = item.IdGrupoDetalle;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGrupoDetalle2", alParameters);
            return dt;
        }

        public static void Activate(GrupoDetalleBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGrupoDetalle", SqlDbType.BigInt);
            parameter.Value = item.IdGrupoDetalle;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 1);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGrupoDetalleActivate", alParameters);
        }
        public static DataTable GetAllPaginate(GrupoDetalleBean item)
        {

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGrupo", SqlDbType.VarChar, 50);
            parameter.Value = item.IdGrupo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 100);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 1);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGrupoDetalleAllPaginate", alParameters);

            return dt;
            ;
        }
        public static DataTable Validate(GrupoDetalleBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGrupoDetalle", SqlDbType.BigInt);
            parameter.Value = item.IdGrupoDetalle;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdGrupo", SqlDbType.BigInt);
            parameter.Value = item.IdGrupo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 100);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGrupoDetalleValida", alParameters);
            return dt;
        }
        public static DataTable GetAllPadre(GrupoDetalleBean item)
        {

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdGrupo", SqlDbType.VarChar, 50);
            parameter.Value = item.IdGrupo;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@IdGrupoDetalle", SqlDbType.VarChar, 50);
            parameter.Value = item.IdGrupoDetalle;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRGrupoDetallePadre", alParameters);

            return dt;
            ;
        }

        //public static DataTable GetGroup(String idGrupo,String codigoPadre)
        //{
        //    ArrayList alParameters = new ArrayList();
        //    SqlParameter parameter;
        //    parameter = new SqlParameter("@IdGrupo", SqlDbType.BigInt);
        //    parameter.Value = idGrupo;
        //    alParameters.Add(parameter);
        //    parameter = new SqlParameter("@codPadre", SqlDbType.VarChar, 50);
        //    parameter.Value = codigoPadre;
        //    alParameters.Add(parameter);
        //    return  SqlConnector.getDataTable("spS_SelGroup", alParameters);            
        //}
    }
}
