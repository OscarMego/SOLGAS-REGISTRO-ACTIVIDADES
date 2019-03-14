using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Data.OracleClient;
using System.Configuration;

namespace Model
{
    public class MenuModel
    {
        public static DataTable fnObtenerDatosMenu(Int32 piIdPerfil)
        {
            ArrayList alParametros = new ArrayList();
            SqlParameter parameter = new SqlParameter("@IdPerfil", SqlDbType.Int);
            parameter.Value = piIdPerfil;
            alParametros.Add(parameter);
            return SqlConnector.getDataTable("spS_TraSelMenu", alParametros);
        }
        public static DataTable fnObtenerDatosMenuOracle(Int32 piIdPerfil)
        {
            DataSet ds;
            ArrayList alParameters = new ArrayList();
            OracleParameter parameter;
            parameter = new OracleParameter("IdPerfil_IN", OracleType.VarChar,100);
            parameter.Value = piIdPerfil;
            alParameters.Add(parameter);

            parameter = new OracleParameter("nexcursor", OracleType.Cursor);
            parameter.Direction = ParameterDirection.ReturnValue;
            alParameters.Add(parameter);

            var dato = OracleDAC.getPaquete() + ".spS_TraSelMenu";
            ds = OracleDAC.getDataset(dato, alParameters);
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    return ds.Tables[0];
                }
            }
            return null;
        }

        //public static DataTable fnObtenerDatosManuales(Int32 piIdSupervisor)
        //{
        //    ArrayList alParametros = new ArrayList();
        //    SqlParameter parameter = new SqlParameter("@IdSupervisor", SqlDbType.Int);
        //    parameter.Value = piIdSupervisor;
        //    alParametros.Add(parameter);
        //    return SqlConnector.getDataTable("spS_AuxSelDocumentacion", alParametros);
        //}

    }
}
