using Model.functions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.Linq;
using System.Text;

namespace Model
{
    public class TrackingModel
    {
        public static DataTable ReporteTracking(String fecha, String coordinador, String jefeventa,
           String supervisor, String grupo, String vendedor, String tipo)
        {
            DataSet ds;
            ArrayList alParameters = new ArrayList();
            OracleParameter parameter;
            parameter = new OracleParameter("fecha_in", OracleType.VarChar, 100);
            parameter.Value = fecha;
            alParameters.Add(parameter);
            parameter = new OracleParameter("coordinador_in", OracleType.VarChar, 100);
            parameter.Value = coordinador;
            alParameters.Add(parameter);
            parameter = new OracleParameter("jefeventa_in", OracleType.VarChar, 100);
            parameter.Value = jefeventa;
            alParameters.Add(parameter);
            parameter = new OracleParameter("supervisor_in", OracleType.VarChar, 100);
            parameter.Value = supervisor;
            alParameters.Add(parameter);
            parameter = new OracleParameter("grupo_in", OracleType.VarChar, 4000);
            parameter.Value = grupo;
            alParameters.Add(parameter);
            parameter = new OracleParameter("vendedor_in", OracleType.VarChar, 4000);
            parameter.Value = vendedor;
            alParameters.Add(parameter);
            parameter = new OracleParameter("tipo_in", OracleType.VarChar, 4000);
            parameter.Value = tipo;
            alParameters.Add(parameter);

            parameter = new OracleParameter("nexcursor", OracleType.Cursor);
            parameter.Direction = ParameterDirection.ReturnValue;
            alParameters.Add(parameter);

            //DataTable dt = SqlConnector.getDataTable("spS_ManSelGRUsuario", alParameters);
            ds = OracleDAC.getDataset(OracleDAC.getPaquete() + ".sps_RepTracking", alParameters);

            if (ds != null)
            {
                return ds.Tables[0];
            }
            return null;
        }
    }
}
