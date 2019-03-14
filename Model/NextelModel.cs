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
    public class NextelModel
    {
        public static DataTable fnObtenerNextel(String psIdSupervisor)
        {
            try
            {
                ArrayList loAlParametros = new ArrayList();
                SqlParameter loSqlParametro = new SqlParameter("@IdSupervisor", System.Data.SqlDbType.BigInt);
                loSqlParametro.Value = psIdSupervisor;
                loAlParametros.Add(loSqlParametro);
                return SqlConnector.getDataTable("spS_ManSelNextel", loAlParametros);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
