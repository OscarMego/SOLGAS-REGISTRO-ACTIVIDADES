using System;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Collections.Generic;

namespace Model
{
    public class ClienteModel
    {
        public static Int32 Insert(ClienteBean item)
        {
            DataTable oDataTableLstCrtDin = new DataTable();
            oDataTableLstCrtDin = OportunidadModel.ConvertToDataTable(item.lstClienteInstalacion);

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Razon_Social", SqlDbType.VarChar, 50);
            parameter.Value = item.Razon_Social;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@RUC", SqlDbType.VarChar, 50);
            parameter.Value = item.RUC;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Direccion", SqlDbType.VarChar, 200);
            parameter.Value = item.Direccion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Referencia", SqlDbType.VarChar, 200);
            parameter.Value = item.Referencia;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdNegocio", SqlDbType.BigInt);
            parameter.Value = item.IdNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdRubro", SqlDbType.BigInt);
            parameter.Value = item.IdRubro;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdRegion", SqlDbType.BigInt);
            parameter.Value = item.IdRegion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdOrganizaVentas", SqlDbType.BigInt);
            parameter.Value = item.IdOrganizacionVenta;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCanal", SqlDbType.BigInt);
            parameter.Value = item.IdCanal;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdTipo", SqlDbType.BigInt);
            parameter.Value = item.IdTipo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@lstCrt", SqlDbType.Structured);
            parameter.Value = oDataTableLstCrtDin;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsCliente", alParameters));
        }
        public static void Update(ClienteBean item)
        {
            DataTable oDataTableLstCrtDin = new DataTable();
            oDataTableLstCrtDin = OportunidadModel.ConvertToDataTable(item.lstClienteInstalacion);
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CLI_PK", SqlDbType.Int);
            parameter.Value = item.CLI_PK;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Razon_Social", SqlDbType.VarChar, 50);
            parameter.Value = item.Razon_Social;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@RUC", SqlDbType.VarChar, 50);
            parameter.Value = item.RUC;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Direccion", SqlDbType.VarChar, 200);
            parameter.Value = item.Direccion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Referencia", SqlDbType.VarChar, 200);
            parameter.Value = item.Referencia;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdNegocio", SqlDbType.BigInt);
            parameter.Value = item.IdNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdRubro", SqlDbType.BigInt);
            parameter.Value = item.IdRubro;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdRegion", SqlDbType.BigInt);
            parameter.Value = item.IdRegion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdOrganizaVentas", SqlDbType.BigInt);
            parameter.Value = item.IdOrganizacionVenta;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCanal", SqlDbType.BigInt);
            parameter.Value = item.IdCanal;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdTipo", SqlDbType.BigInt);
            parameter.Value = item.IdTipo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@lstCrt", SqlDbType.Structured);
            parameter.Value = oDataTableLstCrtDin;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdCliente", alParameters);
        }
        public static DataTable Get(ClienteBean item)
        {

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CLI_PK", SqlDbType.BigInt);
            parameter.Value = item.CLI_PK;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRCliente2", alParameters);
            return dt;
        }

        public static void Activate(ClienteBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CLI_PK", SqlDbType.BigInt);
            parameter.Value = item.CLI_PK;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 1);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdClienteActivate", alParameters);
        }
        public static DataTable GetAllPaginate(ClienteBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Razon_Social", SqlDbType.VarChar, 50);
            parameter.Value = item.Razon_Social;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@RUC", SqlDbType.VarChar, 11);
            parameter.Value = item.RUC;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Direccion", SqlDbType.VarChar, 100);
            parameter.Value = item.Direccion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Referencia", SqlDbType.VarChar, 100);
            parameter.Value = item.Referencia;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdNegocio", SqlDbType.BigInt);
            parameter.Value = item.IdNegocio;
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
            DataTable dt = SqlConnector.getDataTable("spS_ManSelClienteAllPaginate", alParameters);
            return dt;
        }

        public static DataTable GetAll(ClienteBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Razon_Social", SqlDbType.VarChar, 50);
            parameter.Value = item.Razon_Social;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@RUC", SqlDbType.VarChar, 11);
            parameter.Value = item.RUC;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Direccion", SqlDbType.VarChar, 100);
            parameter.Value = item.Direccion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Referencia", SqlDbType.VarChar, 100);
            parameter.Value = item.Referencia;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdNegocio", SqlDbType.BigInt);
            parameter.Value = item.IdNegocio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 100);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelClienteAll", alParameters);
            return dt;
        }

        public static DataTable Validate(ClienteBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@CLI_PK", SqlDbType.BigInt);
            parameter.Value = item.CLI_PK;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Razon_Social", SqlDbType.VarChar, 100);
            parameter.Value = item.Razon_Social;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@RUC", SqlDbType.VarChar, 100);
            parameter.Value = item.RUC;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelClienteValida", alParameters);
            return dt;
        }
        public static ClienteBean getClienteOportunidad(string idOportunidad)
        {


            ClienteBean lobj = new ClienteBean();


            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;

            parameter = new SqlParameter("@idOportunidad", SqlDbType.BigInt);
            parameter.Value = idOportunidad;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("USP_GET_CLIENTE_OPORTUNIDAD", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    lobj.CLI_PK = Int32.Parse(row["CLI_PK"].ToString());
                    lobj.Razon_Social = row["Razon_Social"].ToString();
                }
            }
            return lobj;
        }
    }
}
