using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Security.Cryptography;

namespace Model
{
    public class ConfiguracionModel
    {
        public static String fnSelChecksumIntegridad()
        {
            return SqlConnector.executeScalar("spS_AuxSelIntegridad", new ArrayList()).ToString();
        }

        public static String fnSelServicioActualHash()
        {
            return SqlConnector.executeScalar("spS_AuxSelSeguridad", new ArrayList()).ToString();
        }

        public static DataTable fnDatosConfiguracion()
        {
            return SqlConnector.getDataTable("spS_ManSelConfiguracion", new ArrayList());
        }

        public static Int32 fnActualizarConfiguracion(String psCodConfig, String psCodigo, String psValor)
        {
            ArrayList loAlParametros = new ArrayList();
            
            SqlParameter loSqlParametro = new SqlParameter("@CodConfig", SqlDbType.Char, 3);
            loSqlParametro.Value = psCodConfig;
            loAlParametros.Add(loSqlParametro);

            loSqlParametro = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            loSqlParametro.Value = psCodigo;
            loAlParametros.Add(loSqlParametro);

            loSqlParametro = new SqlParameter("@Valor", SqlDbType.VarChar, 10);
            loSqlParametro.Value = psValor;
            loAlParametros.Add(loSqlParametro);

            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManUpdConfiguracion", loAlParametros));
        }

        public static int getConfigurationValue(string codConfiguration)
        {
            ArrayList loAlParametros = new ArrayList();

            SqlParameter loSqlParametro = new SqlParameter("@CodConfig", SqlDbType.Char, 4);
            loSqlParametro.Value = codConfiguration;
            loAlParametros.Add(loSqlParametro);

            return Convert.ToInt32(SqlConnector.executeScalar("spS_SelConfiguracionByCodigo", loAlParametros));
        }

        #region Configuracion
        public static Hashtable fnConfiguracionHash(String hashServicio)
        {
            ArrayList lvArrayParameter = new ArrayList();
            ConfiguracionBean loConfig;
            Hashtable loHash = new Hashtable();
            try
            {
                DataSet dst = SqlConnector.getDataset("spS_ManSelConfiguracionCompleta", lvArrayParameter);
                MD5 md5 = System.Security.Cryptography.MD5.Create();
                foreach (DataRow row in dst.Tables[0].Rows)
                {
                    String servicio = row["codServicio"].ToString();
                    byte[] hash = md5.ComputeHash(System.Text.Encoding.ASCII.GetBytes(servicio));
                    servicio = BitConverter.ToString(hash).Replace("-", "");             
                    if (hashServicio.Substring(2).ToUpper().Equals(servicio))
                    {
                        loConfig = new ConfiguracionBean();
                        loConfig.Codigo = row["Codigo"].ToString().ToUpper().Trim();
                        loConfig.Descripcion = row["Descripcion"].ToString();
                        loConfig.Tipo = row["CodConfig"].ToString().ToUpper().Trim();
                        loConfig.TipoPadre = row["CodConfigPadre"].ToString().ToUpper().Trim();
                        loConfig.Valor = row["Valor"].ToString().Trim();
                        loConfig.FlagHabilitado = row["FlagHabilitado"].ToString().Trim();
                        loConfig.Orden = Convert.ToInt16(row["Orden"]);
                        loHash.Add(loConfig.Codigo, loConfig);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return loHash;
        }
        #endregion

    }
}
