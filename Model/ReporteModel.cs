using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using Model.functions;
using System.Data.SqlClient;
using Model.bean;
using System.Data.OracleClient;

namespace Model
{
    public class ReporteModel
    {
        public static DataTable ReporteGraficoEstadoPorEtapa(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Responsable", SqlDbType.VarChar, 4000);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Estado", SqlDbType.VarChar, 4000);
            parameter.Value = item.Estado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Etapa", SqlDbType.VarChar, 4000);
            parameter.Value = item.Etapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@UsuarioSession", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@tipoTotal", SqlDbType.Char, 1);
            parameter.Value = item.tipoTotal;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("sps_RepGraficEstadoPorEtapa", alParameters);

            return dt;
        }
        public static DataTable ReporteGraficoOportEtapas(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Responsable", SqlDbType.VarChar, 4000);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Estado", SqlDbType.VarChar, 4000);
            parameter.Value = item.Estado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Etapa", SqlDbType.VarChar, 4000);
            parameter.Value = item.Etapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@UsuarioSession", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@tipoTotal", SqlDbType.Char, 1);
            parameter.Value = item.tipoTotal;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("sps_RepGraficOportunidadPorEtapa", alParameters);

            return dt;
        }
        public static DataTable ReporteGraficoExcesoTiempo(OportunidadBean item)
        {
            List<OportunidadBean> lobj = new List<OportunidadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaInicio;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = item.FechaFin;
            alParameters.Add(parameter);
            //parameter = new SqlParameter("@Coordinador", SqlDbType.VarChar, 4000);
            //parameter.Value = item.Coordinador;
            //alParameters.Add(parameter);
            parameter = new SqlParameter("@Responsable", SqlDbType.VarChar, 4000);
            parameter.Value = item.Responsable;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Estado", SqlDbType.VarChar, 4000);
            parameter.Value = item.Estado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Etapa", SqlDbType.VarChar, 4000);
            parameter.Value = item.Etapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@UsuarioSession", SqlDbType.VarChar, 4000);
            parameter.Value = item.UsuSession;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@tipoTotal", SqlDbType.Char, 1);
            parameter.Value = item.tipoTotal;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("sps_RepGraficExcesoTiempoEtapa", alParameters);

            return dt;
        }
    }
}
