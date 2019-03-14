using System;
using System.Collections.Generic;
using System.Text;
using Model.bean;
using Model;
using System.Data;
using System.Web;
using System.Configuration;
using System.Xml;
using System.IO;
using System.Net;

namespace Controller
{
    public class GeneralController
    {

        public enum EnumTipoMensaje
        {
            TEXTO = 0,
            MAPA = 1,
        }

        public static void subEnviarMensaje(String psIdMensaje, String psAsunto, String psNextel, EnumTipoMensaje poTipo)
        {
            try
            {
                //se agrega un 0 al inicio para diferenciar un mensaje de un chat
                String parametros = "0|" + psIdMensaje + "|" + ((Int32)poTipo) + "|" + psAsunto;

                StringBuilder loSB = new StringBuilder();
                loSB.Append(ConfigurationManager.AppSettings["urlPush3G"].ToString()).Append("?");
                loSB.Append("nextel=").Append(psNextel).Append("&");
                loSB.Append("cliente=").Append(ConfigurationManager.AppSettings["keyCliente3G"].ToString()).Append("&");
                loSB.Append("mensaje=").Append(parametros);
                byte[] byteData = UTF8Encoding.UTF8.GetBytes(loSB.ToString());
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(loSB.ToString());
                request.Method = "POST";
                request.ContentLength = byteData.Length;
                using (Stream postStream = request.GetRequestStream())
                {
                    postStream.Write(byteData, 0, byteData.Length);
                }
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    StreamReader reader = new StreamReader(response.GetResponseStream());
                    string[] rpta = reader.ReadToEnd().Split('|');

                    if (!rpta[0].Equals("1"))
                    {
                        throw new Exception(rpta[1]);
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static bool fnValidarIntegridad()
        {
            return true;//(ConfiguracionModel.fnSelChecksumIntegridad().Equals(Constantes.CHECKSUM));
        }

        public static String fnSelServicioActualHash()
        {
            return ConfiguracionModel.fnSelServicioActualHash();
        }

        public static void subInicializarConfiguracion()
        {
            //String hashServicio = fnSelServicioActualHash();
            //ManagerConfiguracion.HashConfig = ConfiguracionModel.fnConfiguracionHash(hashServicio);
            IdiomaCultura.Datos = getCultureIdioma();
            ManagerConfiguracion.Version = fnVersionSuite();
        }

        public static String obtenerTemaActual()
        {
            return obtenerTemaActual(false);
        }

        public static String obtenerTemaActual(bool fromSession)
        {
            try
            {
                if (fromSession
                && HttpContext.Current != null
                && HttpContext.Current.Session != null
                && HttpContext.Current.Session[Constantes.THEME_SESSION] != null)
                {
                    return HttpContext.Current.Session[Constantes.THEME_SESSION].ToString();
                }
                return GeneralModel.obtenerTemaActual();
            }
            catch (Exception )
            {
                return System.Configuration.ConfigurationManager.AppSettings["codigocolorcss"].ToString();
            }
        }

        public static Dictionary<string, string> getCultureIdioma()
        {
            Dictionary<string, string> datos = new Dictionary<string, string>();
            String codPais = "";
            DataTable dt = GeneralModel.getCultureIdioma();
            foreach (DataRow dr in dt.Rows)
            {
                codPais = dr["CodPais"].ToString();
                datos.Add(dr["CodEtiqueta"].ToString(), dr["Descripcion"].ToString());
            }
            datos.Add(IdiomaCultura.CULTURE, codPais);

            return datos;
        }


        public static DataTable getErroresCarga(String file)
        {


            string SP = "";
            switch (file.ToUpper())
            {
                case "USUARIOS":
                    SP = "USPC_ERROR_USUARIO";
                    break;
                case "ZONAS":
                    SP = "USPC_ERROR_ZONA";
                    break;
                case "GENERALES":
                    SP = "USPC_ERROR_GENERAL";
                    break;
                case "CLIENTES":
                    SP = "USPC_ERROR_CLIENTE";
                    break;
                case "CONTACTOS":
                    SP = "USPC_ERROR_CONTACTOS";
                    break;
            }

            return CargaModel.getErrores(SP);

        }

        private static String fnVersionSuite()
        {
            string ubicacion_padre = "";
            string nombre = "";
            try
            {
                string sFilename = HttpContext.Current.Server.MapPath("~");
                ubicacion_padre = ConfigurationManager.AppSettings["ubicacion_version"];
                string[] niveles = ubicacion_padre.Split('/');
                if (niveles.Length == 0)
                {
                    throw new Exception("parámetro sin datos");
                }
                else
                {
                    nombre = niveles[niveles.Length - 1];
                    for (int i = 0; i < niveles.Length - 1; i++)
                    {
                        if (niveles[i].Equals(".."))
                        {
                            sFilename = Path.GetDirectoryName(sFilename);
                        }
                    }

                }
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(sFilename + "/" + nombre);
                XmlElement rootElem = xmlDoc.DocumentElement;
                if (rootElem != null)
                {
                    return rootElem.Attributes["suite"].Value;
                }
                else
                {
                    return "0.0.0";
                }
            }
            catch (Exception )
            {
                return "0.0.0";
            }
        }
    }
}
