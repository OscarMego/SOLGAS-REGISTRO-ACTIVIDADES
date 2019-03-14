using Model.functions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace Model.bean
{
    public class IdiomaCultura
    {

        public const String WEB_GRUPO = "WEB_GRUPO";
        public const String MAN_WEB_GRUPO = "MAN_WEB_GRUPO";
        public const String WEB_EXCESO_TIEMPO = "WEB_EXCESO_TIEMPO";
        public const String MAN_WEB_OPORTUNIDADES_ETAPA = "MAN_WEB_OPORTUNIDADES_ETAPA";
        public const String OPC_OPORTUNIDADES_ETAPA = "OPC_OPORTUNIDADES_ETAPA";

        public const String MAN_WEB_ETAPA_ESTADO = "MAN_WEB_ETAPA_ESTADO";
        public const String OPC_ETAPA_ESTADO = "OPC_ETAPA_ESTADO";

        public const String MAN_WEB_EXCESO_TIEMPO = "MAN_WEB_EXCESO_TIEMPO";
        public const String WEB_DASH_EXCESO_TIEMPO = "WEB_DASH_EXCESO_TIEMPO";

        public const String MAN_WEB_CONFOPORTUNIDADES = "MAN_WEB_CONFOPORTUNIDADES";
        public const String OPC_CONFOPORTUNIDADES = "OPC_CONFOPORTUNIDADES";
        public const String WEB_CONFOPORTUNIDADES = "WEB_CONFOPORTUNIDADES";
        public const String MAN_WEB_BANOPORTUNIDADES = "MAN_WEB_BANOPORTUNIDADES";


        public const String REP_WEB_BAND_ACTIVIDAD_RESUMIDA = "REP_WEB_BAND_ACTIVIDAD_RESUMIDA";

        public const String REP_WEB_BAND_OPORTUNIDAD = "REP_WEB_BAND_OPORTUNIDAD";
        public const String REP_BAND_OPORTUNIDAD = "REP_BAND_OPORTUNIDAD";
        public const String OPC_REP_OPORTUNIDAD = "OPC_REP_OPORTUNIDAD";

        public const String WEB_REP_TIEMPOSMUERTOS = "WEB_REP_TIEMPOSMUERTOS";
        public const String WEB_REP_INICIOVENTAS = "WEB_REP_INICIOVENTAS";
        public const String WEB_TRACKING_NOPEDIDO = "WEB_TRACKING_NOPEDIDO";
        public const String WEB_REP_NOVENTAS = "WEB_REP_NOVENTAS";
        public const String WEB_TRACKING_PEDIDO = "WEB_TRACKING_PEDIDO";
        public const String WEB_REP_DETALLEVENTAS = "WEB_REP_DETALLEVENTAS";
        public const String WEB_REP_VENTAS = "WEB_REP_VENTAS";
        public const String MAN_WEB_GENERAL = "MAN_WEB_GENERAL";
        public const String WEB_GENERAL = "WEB_GENERAL";
        public const String MAN_WEB_BANMONUNIDAD = "MAN_WEB_BANMONUNIDAD";
        public const String MAN_WEB_BANRUTINADT = "MAN_WEB_BANRUTINADT";
        public const String MAN_WEB_BANMONZON = "MAN_WEB_BANMONZON";

        public const String MAN_WEB_CONFIG = "MAN_WEB_CONFIG";
        public const String MAN_WEB_USUARIO = "MAN_WEB_USUARIO";
        public const String MAN_WEB_TIPOACTIVIDAD = "MAN_WEB_TIPOACTIVIDAD";
        public const String MAN_WEB_ZONA = "MAN_WEB_ZONA";
        public const String MAN_WEB_CONTACTO = "MAN_WEB_CONTACTO";

        public const String MAN_WEB_GENERAL_TIPO = "MAN_WEB_GENERAL_TIPO"; 

        public const String MAN_WEB_ETAPA = "MAN_WEB_ETAPA";
        public const String MAN_WEB_GRUA = "MAN_WEB_GRUA";
        public const String WEB_ETAPA = "WEB_ETAPA";
        public const String WEB_GRUA = "WEB_GRUA";
        public const String MAN_WEB_BAND_OPORTUNIDAD = "MAN_WEB_BAND_OPORTUNIDAD";
        public const String WEB_BAND_OPORTUNIDAD = "WEB_BAND_OPORTUNIDAD";
        public const String MAN_WEB_NOTIF = "MAN_WEB_NOTIF";
        public const String WEB_NOTIF = "WEB_NOTIF";
        public const String WEB_EQMOVIL = "WEB_EQMOVIL";
        public const String WEB_ZONCAR = "WEB_ZONCAR";
        public const String WEB_OPERADOR = "WEB_OPERADOR";
        public const String WEB_ESLOGAN_01 = "WEB_ESLOGAN_01";
        public const String WEB_ESLOGAN_02 = "WEB_ESLOGAN_02";

        public const String WEB_APP_NAME = "WEB_APP_NAME";
        public const String WEB_AREA_NAME = "WEB_AREA_NAME";
        public const String WEB_PIE_BR = "WEB_PIE_BR";
        public const String WEB_PIE2_BR = "WEB_PIE2_BR";
        public const String WEB_PIE_P = "WEB_PIE_P";
        public const String CULTURE = "CULTURE";
        public static string WEB_USUARIO = "WEB_USUARIO";
        public static string WEB_ZONA = "WEB_ZONA";
        public static string WEB_CONTACTO = "WEB_CONTACTO";
        public static string WEB_TIPOACTIVIDAD = "WEB_TIPOACTIVIDAD";

        public const String MAN_WEB_EQMOVIL = "MAN_WEB_EQMOVIL";
        public const String MAN_WEB_ZONCAR = "MAN_WEB_ZONCAR";
        public const String WEB_SERPROGRAM = "WEB_SERPROGRAM";
        public const String MAN_WEB_SERPROGRAM = "MAN_WEB_SERPROGRAM";
        public const String WEB_INCIDENCIA = "WEB_INCIDENCIA";
        public const String MAN_WEB_INCIDENCIA = "MAN_WEB_INCIDENCIA";
        public const String MAN_WEB_CLIENTE = "MAN_WEB_CLIENTE";
        public const String WEB_CLIENTE = "WEB_CLIENTE";
        public const String MAN_WEB_TSERVICIO = "MAN_WEB_TSERVICIO";
        public const String WEB_TOTAL_PAGE = "WEB_TOTAL_PAGE";
        public const String WEB_TSERVICIO = "WEB_TSERVICIO";

        public const String ETI_USU_SNG = "ETI_USU_SNG";
        public const String ETI_GRP_SNG = "ETI_GRP_SNG";
        public const String ETI_EST_SNG = "ETI_EST_SNG";
        public const String ETI_PNT_SNG = "ETI_PNT_SNG";
        public const String ETI_SRV_SNG = "ETI_SRV_SNG";
        public const String ETI_GEO_SNG = "ETI_GEO_SNG";
        public const String ETI_GEO_PLU = "ETI_GEO_PLU";
        public const String ETI_CAP_SNG = "ETI_CAP_SNG";
        public const String ETI_PLA_SNG = "ETI_PLA_SNG";
        public const String ETI_MAP_SNG = "ETI_MAP_SNG";
        public const String ETI_SUP_SNG = "ETI_SUP_SNG";
        public const String ETI_SUP_PLU = "ETI_SUP_PLU";
        public const String ETI_PRF_SNG = "ETI_PRF_SNG";
        public const String ETI_PRF_PLU = "ETI_PRF_PLU";
        public const String ETI_MSJ_SNG = "ETI_MSJ_SNG";
        public const String ETI_MSJ_PLU = "ETI_MSJ_PLU";
        public const String ETI_ACC_MSJ_SNG = "ETI_ACC_MSJ_SNG";
        public const String ETI_REP_MAP = "ETI_REP_MAP";
        public const String ETI_MNT_CNF = "ETI_MNT_CNF";
        public const String ETI_ACC_CAR = "ETI_ACC_CAR";
        public const String ETI_REP_RVI = "ETI_REP_RVI";
        public const String ETI_DET_RVI = "ETI_DET_RVI";

        private static Dictionary<string, string> datos = new Dictionary<string, string>();

        public static Dictionary<string, string> Datos
        {
            get { return datos; }
            set { datos = value; }
        }


        public static String getMensajeEncodeHTML(String key, String code)
        {
            return getMensajeEncodeHTML(key).Replace("{0}", code);
        }

        public static String getMensaje(String key, String code)
        {
            return getMensaje(key).Replace("{0}", code);
        }

        public static String getMensaje(String key)
        {
            if (datos.ContainsKey(key))
            {
                return datos[key];
            }
            return " ";
        }

        public static String getMensajeEncodeHTML(String key)
        {
            if (datos.ContainsKey(key))
            {
                return HttpUtility.HtmlEncode(datos[key]);
            }
            return " ";
        }
        public static String getMensajeEncodeJS(String key)
        {
            if (datos.ContainsKey(key))
            {
                return Tarea.JSEncode(datos[key]);
            }
            return "";
        }
    }
}
