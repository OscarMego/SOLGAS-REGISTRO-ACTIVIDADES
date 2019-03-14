using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Configuration;
using System.Reflection;
using System.ComponentModel;

namespace Model.bean
{
    public class ManagerConfiguracion
    {
        private static Hashtable hashConfig = new Hashtable();
        private static String version = "0.0.0";

        public static String Version
        {
            set { version = value; }
            get { return version; }
        }

        public static Hashtable HashConfig
        {
            set { hashConfig = value; }
            get { return hashConfig; }
        }

        public static String getNServicesEmbebido()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_NSERVICES_EMBEBIDO) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_NSERVICES_EMBEBIDO]).Valor : "F");
        }

        public static String getHoraSincronizacion()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_HORA_SINCRONIZACION) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_HORA_SINCRONIZACION]).Valor : "12:00");
        }

        public static String getTiempoEnvioGps()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_TIEMPO_ENVIO_GPS) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_TIEMPO_ENVIO_GPS]).Valor : "7");
        }

        public static String getHoraInicioCaptura()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_HORA_INICIO_CAPTURA) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_HORA_INICIO_CAPTURA]).Valor : "00:00");
        }

        public static String getHoraFinCaptura()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_HORA_FIN_CAPTURA) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_HORA_FIN_CAPTURA]).Valor : "23:50");
        }

        public static String getUsarGoogleGeocoding()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_USAR_GOOGLE_GEOCODING) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_USAR_GOOGLE_GEOCODING]).Valor : "F");
        }

        public static String getEnvioCorreoGeocerca()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.FUN_REGISTRAR_MOVIMIENTO_GEOCERCA) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.FUN_REGISTRAR_MOVIMIENTO_GEOCERCA]).Valor : "F");
        }

        public static String getCalcularProximidadPuntoInteres()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.FUN_REGISTRAR_PROXIMIDAD_PUNTO_INTERES) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.FUN_REGISTRAR_PROXIMIDAD_PUNTO_INTERES]).Valor : "F");
        }

        public static String getProveedorMapasActivo()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_PROVEEDOR_MAPS_SELECCIONADO) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_PROVEEDOR_MAPS_SELECCIONADO]).Valor : "1");
        }

        public static String getProveedorReverseGeocodingActivo()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_PROVEEDOR_REVERSE_GEOCODING_SELECCIONADO) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_PROVEEDOR_REVERSE_GEOCODING_SELECCIONADO]).Valor : "1");
        }

        public static String getCargaGeocercasKMLConFecha()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.FUN_CARGA_GEOCERCA_KML_CON_FECHA) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.FUN_CARGA_GEOCERCA_KML_CON_FECHA]).Valor : "F");
        }
        public static String getHorariosEnvioGPSPorGrupoUsuario()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.FUN_HORARIOS_POR_GRUPO_USUARIOS) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.FUN_HORARIOS_POR_GRUPO_USUARIOS]).Valor : "F");
        }

        public static String getDiasFuncionamiento()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_DIAS_FUNCIONAMIENTO) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_DIAS_FUNCIONAMIENTO]).Valor : "1111111");
        }

        public static String getComboUsuarioAsociadoAGrupo()
        {
            return (hashConfig.ContainsKey(Constantes.CodigoValoresConfiguracion.CFG_MAPA_COMBO_USUARIO_DEPENDIENTE_DE_GRUPO) ? ((ConfiguracionBean)hashConfig[Constantes.CodigoValoresConfiguracion.CFG_MAPA_COMBO_USUARIO_DEPENDIENTE_DE_GRUPO]).Valor : "F");
        }

        public static Constantes.EnumProveedorMapas fnProveedorMapasActivoEnum()
        {
            int valorProveedorMaps = Convert.ToInt16(getProveedorMapasActivo());
            Constantes.EnumProveedorMapas retorno;
            try
            {
                retorno = (Constantes.EnumProveedorMapas)valorProveedorMaps;
            }
            catch (Exception ex)
            {
                retorno = Constantes.EnumProveedorMapas.PROVEEDOR_GOOGLE;
            }
            return retorno;
        }

        public static string fnProveedorMapasActivoString()
        {
            return GetEnumDescription(fnProveedorMapasActivoEnum());
        }

        public static string fnRegistrarMapstraction()
        {
            Constantes.EnumProveedorMapas proveedorMaps = fnProveedorMapasActivoEnum();

            StringBuilder sbScript = new StringBuilder();
            switch (proveedorMaps)
            {
                case Constantes.EnumProveedorMapas.PROVEEDOR_GOOGLE:
                    sbScript.Append(fnRegistrarProveedorGoogle());
                    break;
                case Constantes.EnumProveedorMapas.PROVEEDOR_BING:
                    sbScript.Append(fnRegistrarProveedorBing());
                    break;
                case Constantes.EnumProveedorMapas.PROVEEDOR_OPENSTREETMAPS:
                    sbScript.Append(fnRegistrarProveedorOpenLayers());
                    break;
                case Constantes.EnumProveedorMapas.PROVEEDOR_MAPBOX:
                    sbScript.Append(fnRegistrarProveedorOpenLayers());
                    sbScript.Append(fnRegistrarCapaOpenLayersMapBox());
                    break;
                case Constantes.EnumProveedorMapas.PROVEEDOR_HERE:
                    sbScript.Append(fnRegistrarProveedorHere());
                    break;
            }

            sbScript.Append(fnRegistrarProveedorMapstraction(proveedorMaps));
            return sbScript.ToString();
        }

        private static string fnRegistrarProveedorMapstraction(Constantes.EnumProveedorMapas proveedorMaps)
        {
            StringBuilder csText = new StringBuilder();
            csText.Append("<script src=\"../../js/mxn.js?(");
            csText.Append(GetEnumDescription(proveedorMaps));
            csText.Append(")\" type=\"text/javascript\"></script>");
            return csText.ToString();
        }

        private static string fnRegistrarProveedorGoogle()
        {
            StringBuilder csText = new StringBuilder();
            csText.Append("<script type='text/javascript' ");
            csText.Append("src='");
            csText.Append(fnUrlGoogleMaps(true, true));
            csText.Append("'>");
            csText.Append("</script>");
            return csText.ToString();
        }

        public static string fnUrlGoogleMaps(Boolean drawing, Boolean places)
        {
            StringBuilder csText = new StringBuilder();
            csText.Append(ConfigurationManager.AppSettings["URL_GMAPS"]);

            if (null != ConfigurationManager.AppSettings["GMAPS_API_CLIENT"] && !ConfigurationManager.AppSettings["GMAPS_API_CLIENT"].Equals(""))
                csText.Append("&client=").Append(ConfigurationManager.AppSettings["GMAPS_API_CLIENT"]);

            if (null != ConfigurationManager.AppSettings["GMAPS_API_KEY"] && !ConfigurationManager.AppSettings["GMAPS_API_KEY"].Equals(""))
                csText.Append("&key=").Append(ConfigurationManager.AppSettings["GMAPS_API_KEY"]);

            //el channel tiene que estar asociado a un api key
            if (ConfigurationManager.AppSettings["GMAPS_API_KEY"] != null && !ConfigurationManager.AppSettings["GMAPS_API_KEY"].Equals(""))
            {
                csText.Append("&channel=");
                csText.Append(ConfigurationManager.AppSettings["GMAPS_CHANNEL_ID"]);
            }
            csText.Append("&sensor=false");
            if (drawing || places)
            {
                int i = 0;
                csText.Append("&libraries=");
                if (drawing)
                {
                    csText.Append("drawing");
                    i++;
                }
                if (i > 0)
                {
                    csText.Append(",");
                }
                if (places)
                {
                    csText.Append("places");
                }
            }
            return csText.ToString();
        }

        private static string fnRegistrarProveedorBing()
        {
            StringBuilder csText = new StringBuilder();
            csText.Append("<script type=\"text/javascript\" ");
            csText.Append("src=\"").Append(ConfigurationManager.AppSettings["URL_BINGMAPS"]);
            csText.Append("\" >");
            csText.Append("</script>");
            csText.Append("<script>");
            csText.Append("var microsoft_key = \"");
            csText.Append(ConfigurationManager.AppSettings["BINGMAPS_API_KEY"]);
            csText.Append("\";");
            csText.Append("</script>");
            return csText.ToString();
        }

        private static string fnRegistrarProveedorOpenLayers()
        {
            StringBuilder csText = new StringBuilder();
            csText.Append("<script type=\"text/javascript\" ");
            csText.Append("src=\"../../js/openlayers/OpenLayers.js\" >");
            csText.Append("</script>");

            return csText.ToString();
        }

        private static string fnRegistrarCapaOpenLayersMapBox()
        {
            StringBuilder csText = new StringBuilder();
            csText.Append("<script>");
            csText.Append("var mapboxLayer = new OpenLayers.Layer.XYZ(\"MapBox\",");
            csText.Append("[\"");
            csText.Append(ConfigurationManager.AppSettings["TILE_MAPBOX"]);
            csText.Append("\"], {");
            csText.Append("sphericalMercator: true, wrapDateLine: true, attribution: ");
            csText.Append("\"<div style='background-color: rgba(255,255,255,.5); color: #404040; margin-right: 0.25em'><a href='https://www.mapbox.com/about/maps/' target='_blank'>&copy; Mapbox &copy; OpenStreetMap</a></div>\"");
            csText.Append("});");
            csText.Append("</script>");
            return csText.ToString();
        }

        private static string fnRegistrarProveedorHere()
        {
            StringBuilder csText = new StringBuilder();
            csText.Append("<script type=\"text/javascript\" ");
            csText.Append("src=\"").Append(ConfigurationManager.AppSettings["URL_HEREMAPS"]);
            csText.Append("\" >");
            csText.Append("</script>");
            csText.Append("<script>");
            csText.Append("nokia.Settings.set (\"appId\", \"");
            csText.Append(ConfigurationManager.AppSettings["HEREMAPS_API_ID"]);
            csText.Append("\");");
            csText.Append("nokia.Settings.set (\"authenticationToken\", \"");
            csText.Append(ConfigurationManager.AppSettings["HEREMAPS_API_CODE"]);
            csText.Append("\");");
            csText.Append("</script>");
            return csText.ToString();
        }

        private static string GetEnumDescription(Enum value)
        {
            FieldInfo fi = value.GetType().GetField(value.ToString());

            DescriptionAttribute[] attributes =
                (DescriptionAttribute[])fi.GetCustomAttributes(typeof(DescriptionAttribute), false);

            if (attributes != null && attributes.Length > 0)
                return attributes[0].Description;
            else
                return value.ToString();
        }
    }
}
