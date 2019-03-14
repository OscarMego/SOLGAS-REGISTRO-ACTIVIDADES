using Model.bean;
using Model.functions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Model
{
    public class LogOportunidadModel
    {
        public static Int32 Insert(LogOportunidadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdOportunidad", SqlDbType.BigInt);
            parameter.Value = item.IdOportunidad;
            alParameters.Add(parameter);

            alParameters = new ArrayList();
            parameter = new SqlParameter("@IdConfiguracionOportuniadaDetalle", SqlDbType.BigInt);
            parameter.Value = item.IdConfiguracionOportuniadaDetalle;
            alParameters.Add(parameter);

            alParameters = new ArrayList();
            parameter = new SqlParameter("@valorNuevo", SqlDbType.VarChar, -1);
            parameter.Value = item.valorNuevo;
            alParameters.Add(parameter);

            alParameters = new ArrayList();
            parameter = new SqlParameter("@valorAnterior", SqlDbType.VarChar, -1);
            parameter.Value = item.valorAnterior;
            alParameters.Add(parameter);

            alParameters = new ArrayList();
            parameter = new SqlParameter("@IdUsuario", SqlDbType.BigInt);
            parameter.Value = item.IdUsuario;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsLogOportunidad", alParameters));
        }

        public static List<LogOportunidadBean> GetAll(string idOportunidad)
        {
            List<LogOportunidadBean> lstLogOportunidad = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdOportunidad", SqlDbType.BigInt);
            parameter.Value = idOportunidad;
            alParameters.Add(parameter);


            DataTable dt = SqlConnector.getDataTable("spS_SelLogOportunidad", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                lstLogOportunidad = new List<LogOportunidadBean>();
                foreach (DataRow row in dt.Rows)
                {
                    LogOportunidadBean obj = new LogOportunidadBean
                    {
                        IdLogOportunidad = int.Parse(row["IdLogOportunidad"].ToString()),
                        IdOportunidad = int.Parse(row["IdActividad"].ToString()),
                        IdConfiguracionOportuniadaDetalle = int.Parse(row["IdSubTipoActividadDetalle"].ToString()),
                        valorNuevo = row["valorNuevo"].ToString(),
                        valorAnterior = row["valorAnterior"].ToString(),
                        IdUsuario = int.Parse(row["IdUsuario"].ToString()),
                        fechaModificacion = DateTime.Parse(row["fechaModificacion"].ToString()),
                        nombreCampo = row["Etiqueta"].ToString(),
                        nombreUsuario = row["Nombres"].ToString(),
                    };
                    lstLogOportunidad.Add(obj);
                }
            }
            return lstLogOportunidad;
        }
    }
}