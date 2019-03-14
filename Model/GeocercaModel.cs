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
   public class GeocercaModel
    {
        public static DataTable subListarGeocercas(Boolean pbHabilitado)
        {
            try
            {
                ArrayList loAlParametros = new ArrayList();
                SqlParameter loSqlParametro = new SqlParameter("@FlagHabilitado", System.Data.SqlDbType.Char, 1);
                loSqlParametro.Value = pbHabilitado ? Enumerados.FlagHabilitado.T.ToString() : Enumerados.FlagHabilitado.F.ToString();
                loAlParametros.Add(loSqlParametro);
                return SqlConnector.getDataTable("spS_ManSelGeocerca", loAlParametros);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        public static Int32 subCrearGeocerca(GeocercaBean poGeocercaBean)
        {
            try
            {
                ArrayList loAlParametros = new ArrayList();

                SqlParameter loSqlParametro = new SqlParameter("@IdGeocerca", System.Data.SqlDbType.BigInt);
                if (poGeocercaBean.id.Equals(String.Empty))
                {
                    loSqlParametro.Value = DBNull.Value;
                }
                else{
                    loSqlParametro.Value = poGeocercaBean.id;
                }
                loAlParametros.Add(loSqlParametro);
                    
                loSqlParametro = new SqlParameter("@Descripcion", SqlDbType.NVarChar, 200);
                loSqlParametro.Value = poGeocercaBean.Descripcion;
                loAlParametros.Add(loSqlParametro);

                loSqlParametro = new SqlParameter("@Puntos", System.Data.SqlDbType.Text);
                loSqlParametro.Value = poGeocercaBean.Puntos;
                loAlParametros.Add(loSqlParametro);

                loSqlParametro = new SqlParameter("@FlagHabilitado", SqlDbType.Char, 1);
                loSqlParametro.Value = poGeocercaBean.FlagHabilitado;
                loAlParametros.Add(loSqlParametro);

                loSqlParametro = new SqlParameter("@Rectangulo", SqlDbType.VarChar, 100);
                loSqlParametro.Value = poGeocercaBean.Rectangulo;
                loAlParametros.Add(loSqlParametro);


                return Convert.ToInt32(SqlConnector.executeScalar("spS_ManUpdGeocerca", loAlParametros));
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public static DataTable subObtenerGeocercaPorId(Int32 psIdGeocerca)
        {
            try
            {

                ArrayList loAlParametros = new ArrayList();
                SqlParameter parameter = new SqlParameter("@IdGeocerca", SqlDbType.BigInt);
                parameter.Value = psIdGeocerca;
                loAlParametros.Add(parameter);

                return SqlConnector.getDataTable("spS_RepSelGeocercaId", loAlParametros);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public static void subBorrarGeocerca(Int32 piIdGeocerca, String flgHabilitado)
        {
            try
            {
                ArrayList alParameters = new ArrayList();
                SqlParameter parameter = new SqlParameter("@IdGeocerca", SqlDbType.BigInt);
                parameter.Value = piIdGeocerca;
                alParameters.Add(parameter);
                parameter = new SqlParameter("@FlgHabilitado", SqlDbType.Char, 1);
                parameter.Value = flgHabilitado;
                alParameters.Add(parameter);

                SqlConnector.getDataTable("spS_ManDelGeocerca", alParameters);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static string registrarGeocercaBDAPartirDeXML(string xml) {
            ArrayList alParametros = new ArrayList();
            ArrayList arrayList = new ArrayList();
            SqlParameter sqlParameter = new SqlParameter("@PAR_DATA", (object)xml);
            alParametros.Add((object)sqlParameter);
            try
            {
                DataRow dataRow = SqlConnector.getDataset("spS_CarGenGeocerca_XML", alParametros).Tables[0].Rows[0];
                int result1 = 0;
                int.TryParse(dataRow["ACTUALIZADOS"].ToString(), out result1);
                int result2 = 0;
                int.TryParse(dataRow["INSERTADOS"].ToString(), out result2);

                String codigoGeocerca = dataRow["codigo"].ToString();
                String puntos = KMLUtils.estandarizarCoordenadasDeKML(dataRow["Puntos"].ToString());
                String rectangulo = KMLUtils.subObtenerDatosRectangulo(puntos);
                alParametros = new ArrayList();
                sqlParameter = new SqlParameter("@CodGeocerca",codigoGeocerca);
                alParametros.Add(sqlParameter);
                sqlParameter = new SqlParameter("@Puntos",puntos);
                alParametros.Add(sqlParameter);
                sqlParameter = new SqlParameter("@Rectangulo", rectangulo);
                alParametros.Add(sqlParameter);
                SqlConnector.executeNonQuery("sps_CarUpdatePuntoGeocerca", alParametros);

                return result2.ToString()+"|" + result1.ToString();
            }
            catch (SqlException ex)
            {
                throw ex;
            }      
        }
    }
}
