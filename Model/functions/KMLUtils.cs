using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.functions
{
    public class KMLUtils
    {
        public static String estandarizarCoordenadasDeKML(String puntos) { 
            String[] coordenadasDeKML = puntos.Split('@');
            StringBuilder sb = new StringBuilder();
            for(int i=0;i<coordenadasDeKML.Count();i++){
                String[] longitud_latitud = coordenadasDeKML[i].Split('|');
                sb.Append(longitud_latitud[1]).Append("|").Append(longitud_latitud[0]).Append("@");
            }
            return sb.ToString().Substring(0,sb.ToString().Length-1);
        }

        public static String subObtenerDatosRectangulo(String psPuntos)
        {
            String lsPuntosRectangulo = String.Empty;

            try
            {
                double ldMinlat = 0, ldMinlon = 0, ldMaxlat = 0, ldMaxlon = 0;
                foreach (string it in psPuntos.Split('@'))
                {
                    string[] coord = it.Split('|');
                    double ldLatitud = Convert.ToDouble(coord[0]), ldLongitud = Convert.ToDouble(coord[1]);
                    if (ldMaxlat == 0 || ldMaxlon == 0)
                    {
                        ldMinlat = ldMaxlat = ldLatitud;
                        ldMinlon = ldMaxlon = ldLongitud;
                    }
                    else
                    {
                        if (ldLatitud < ldMinlat) ldMinlat = ldLatitud;
                        if (ldLatitud > ldMaxlat) ldMaxlat = ldLatitud;
                        if (ldLongitud < ldMinlon) ldMinlon = ldLongitud;
                        if (ldLongitud > ldMaxlon) ldMaxlon = ldLongitud;
                    }
                }

                lsPuntosRectangulo = ldMinlat.ToString() + '|' + ldMinlon.ToString() + '|' +
                      ldMaxlat.ToString() + '|' + ldMaxlon.ToString();
            }
            catch
            {
                lsPuntosRectangulo = String.Empty;
            }

            return lsPuntosRectangulo;

        }
    }
}
