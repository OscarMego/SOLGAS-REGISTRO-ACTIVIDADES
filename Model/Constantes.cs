using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace Model
{
    public class Constantes
    {
        public static string ColDinamico = "DIN";
        public static string ColColor = "COLOR";
        public class  EnumTablas
        {
            public const string Configuracion = "01";
            public const string Almacen = "02";
            public const string Puerta = "03";
            public const string Grupo = "04";
        }
        public class EnumTipoControl
        {

            public const String CONTROL_TYPE_ALFANUMERICO = "ALFANUMÉRICO";
            public const String CONTROL_TYPE_COMBOBOX = "COMBOBOX";
            public const String CONTROL_TYPE_NUMERICO = "NUMÉRICO";
            public const String CONTROL_TYPE_FECHA = "FECHA";
            public const String CONTROL_TYPE_DECIMAL = "DECIMAL";
            public const String CONTROL_TYPE_FOTO = "FOTO";
            public const String CONTROL_TYPE_TEXTAREA = "TEXTAREA";
        }
        public class EnumGenerales
        {
            public const string Rubro = "1";
            public const string Region = "2";
            public const string OrganizacionVenta = "3";
            public const string Canal = "4";
        }
        public class EnumConfiguracion
        {
            public const string Espera = "1";
            public const string Atencion = "2";
            public const string Zona = "3";
        }
        public class EnumHabilitado
        {
            public const string Habilitado = "T";
            public const string Deshabilitado = "F";
        }

        public const String CHECKSUM = "1024";
        public const String THEME_SESSION = "THEME_SESSION";

        public enum EnumProveedorMapas {
            [Description("googlev3")]
            PROVEEDOR_GOOGLE = 1,
            [Description("openlayers")]
            PROVEEDOR_OPENSTREETMAPS = 2,
            [Description("openlayers")]
            PROVEEDOR_MAPBOX = 3,
            [Description("microsoft7")]
            PROVEEDOR_BING = 4,
            [Description("nokia")]
            PROVEEDOR_HERE = 5
        };

        public enum EnumProveedorReverseGeocoding
        {
            PROVEEDOR_ENTEL = 0,
            PROVEEDOR_GOOGLE = 1,
            PROVEEDOR_MAPBOX = 2
        };

        public class CodigoValoresConfiguracion
        {
            public const String FUN_CARGA_GEOCERCA_KML_CON_FECHA = "FGAF";
            public const String FUN_HORARIOS_POR_GRUPO_USUARIOS = "FHPG";

            public const String CFG_TIEMPO_ENVIO_GPS = "TGPS";
            public const String CFG_TIEMPO_ENVIO_PULSO = "TPUL";
            public const String CFG_HORA_SINCRONIZACION = "HSIN";
            public const String CFG_DISTANCIA_MINIMA = "RDIS";
            public const String CFG_TIEMPO_NO_REFERENCIAL = "RREF";
            public const String CFG_HORA_INICIO_CAPTURA = "HINI";
            public const String CFG_HORA_FIN_CAPTURA = "HFIN";
            public const String CFG_MODO_AHORRO = "MAHO";
            public const String CFG_USAR_SENSOR_ACTIVIDAD = "ACTV";
            public const String CFG_USAR_GOOGLE_GEOCODING = "MGEO";
            public const String CFG_FORZAR_ENCENDIDO_DATOS = "FENC";
            public const String CFG_FORZAR_ENCENDIDO_WIFI = "FEND";
            public const String CFG_DIAS_FUNCIONAMIENTO = "HDIA";
            public const String CFG_NSERVICES_EMBEBIDO = "NEMB";
            public const String CFG_NOTIFICAR_GPS_DESACTIVADO = "NOTI";
            public const String CFG_PRECISION_MINIMA_MAPA = "PREC";            
            public const String CFG_ENVIO_CORREO_GEOCERCA = "CORR";
            public const String CFG_PROVEEDOR_MAPS_SELECCIONADO = "MAPS";
            public const String CFG_PROVEEDOR_REVERSE_GEOCODING_SELECCIONADO = "GEOC";
            public const String CFG_VELOCIDAD_MAXIMA_PARA_DESCARTAR_POSICION = "VMAX";
            public const String CFG_MAPA_COMBO_USUARIO_DEPENDIENTE_DE_GRUPO = "CGRU";

            public const String FUN_REGISTRAR_PROXIMIDAD_PUNTO_INTERES = "FPRX";
            public const String FUN_REGISTRAR_MOVIMIENTO_GEOCERCA = "FCGO";
            public const String FUN_GENERAL = "FGEN";
            public const String MOD_GENERAL = "MGEN";
        }
    }
}
