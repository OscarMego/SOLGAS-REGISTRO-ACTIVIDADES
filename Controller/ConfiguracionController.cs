using System;
using System.Collections.Generic;
using System.Text;
using Model.bean;
using Model;
using System.Data;
using business.functions;
using System.Linq;
using System.Web.Script.Serialization;
using System.Security.Cryptography;

namespace Controller
{
    public class ConfiguracionController
    {
        public static List<ConfiguracionBean> subObtenerDatosConfiguracion()
        {
            List<ConfiguracionBean> loLstConfiguracionBean = new List<ConfiguracionBean>();
            try
            {
               foreach (ConfiguracionBean bean in ManagerConfiguracion.HashConfig.Values)
               {
                   loLstConfiguracionBean.Add(bean);
               }
               return loLstConfiguracionBean.OrderBy(o => o.Orden).ToList();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public static Int32 subInsertarDatosConfiguracion(String psCodConfig, String psCodigo, String psValor)
        {
            try
            {
               return ConfiguracionModel.fnActualizarConfiguracion(psCodConfig, psCodigo, psValor);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static int getTiempoEnvio()
        {
            return Convert.ToInt32(getConfigurationPorCodigo("TGPS"));
        }
        public static String getConfigurationPorCodigo(String codigo) {
            DataTable dt = ConfiguracionModel.fnDatosConfiguracion();
            String valor = "";
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["CodConfiguracion"].ToString().Equals(codigo))
                {
                    valor= dr["Valor"].ToString();
                }
            }
            return valor;
        }

    }
}
