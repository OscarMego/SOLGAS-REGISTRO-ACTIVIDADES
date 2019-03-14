using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model.bean;
using System.Data;
using Model;

namespace Controller
{
   public class GeocercaController
    {
       public static List<GeocercaBean> subListarGeocercas(Boolean pbHabilitado)
       {
           DataTable ldtGeocerca = GeocercaModel.subListarGeocercas(pbHabilitado);
           List<GeocercaBean> loLstGeocercaBean = new List<GeocercaBean>();

           if (ldtGeocerca != null && ldtGeocerca.Rows.Count > 0)
           {
               foreach (DataRow row in ldtGeocerca.Rows)
               {
                   GeocercaBean loBeanGeocerca = new GeocercaBean();
                   loBeanGeocerca.id = row["IdOpcion"].ToString();
                   loBeanGeocerca.nombre = row["Descripcion"].ToString();
                   loLstGeocercaBean.Add(loBeanGeocerca);

               }




           }
           return loLstGeocercaBean;
       }


       public static GeocercaBean subObtenerGeocercaPorId(Int32 piIdGeocerca)
       {
           DataTable ldtGeocerca = GeocercaModel.subObtenerGeocercaPorId(piIdGeocerca);
           GeocercaBean loBeanGeocerca = new GeocercaBean();
           List<GeocercaPuntosBean> lista = new List<GeocercaPuntosBean>();

           if (ldtGeocerca != null && ldtGeocerca.Rows.Count > 0)
           {
               loBeanGeocerca.id = ldtGeocerca.Rows[0]["IdGeocerca"].ToString();
               loBeanGeocerca.nombre = ldtGeocerca.Rows[0]["Descripcion"].ToString();
               loBeanGeocerca.Puntos = ldtGeocerca.Rows[0]["Punto"].ToString();
               loBeanGeocerca.LstGeocercaPuntosBean = subObtenerListaDePuntos(ldtGeocerca.Rows[0]["Punto"].ToString());
           }
           return loBeanGeocerca;
       }

       public static List<GeocercaPuntosBean> subObtenerListaDePuntos(String psPuntos)
       {
           List<GeocercaPuntosBean> loLstGeocercaPuntosBean = new List<GeocercaPuntosBean>();
           GeocercaPuntosBean loGeocercaPutnosBean;
           foreach (string lsPuntosCoordenada in psPuntos.Split('@'))
           {
               string[] lasCoordendas = lsPuntosCoordenada.Split('|');

               if (lasCoordendas.Length == 2)
               {
                   loGeocercaPutnosBean = new GeocercaPuntosBean();
                   loGeocercaPutnosBean.latitud = lasCoordendas[0];
                   loGeocercaPutnosBean.longitud = lasCoordendas[1];
                   loLstGeocercaPuntosBean.Add(loGeocercaPutnosBean);
               }
              
           }

           return loLstGeocercaPuntosBean;
       }


       public static string subCrearGeocerca(GeocercaBean poGeocercaBean, String flgHabilitado)
       {
           try
           {
               List<GeocercaPuntosBean> loLstGeocercaPuntosBean = new List<GeocercaPuntosBean>();
               String lsPuntos = String.Empty;
               loLstGeocercaPuntosBean = poGeocercaBean.LstGeocercaPuntosBean;

               for (int i = 0; i < loLstGeocercaPuntosBean.Count; i++)
               {
                   String lsCoordenadas = loLstGeocercaPuntosBean[i].latitud + "|" + loLstGeocercaPuntosBean[i].longitud;
                   String lsSeparador = (i + 1 == loLstGeocercaPuntosBean.Count) ? String.Empty : "@";
                   lsPuntos += lsCoordenadas + lsSeparador;
               }

               poGeocercaBean.Puntos = lsPuntos;
               poGeocercaBean.FlagHabilitado = flgHabilitado;
               poGeocercaBean.Rectangulo = subObtenerDatosRectangulo(lsPuntos);
               String lsCoddigo = GeocercaModel.subCrearGeocerca(poGeocercaBean).ToString();

               return lsCoddigo;

           }
           catch (Exception )
           {
               throw new Exception("El nombre ingresado ya existe.");
           }
           
           
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


       public static void subBorrarGeocerca(Int32 psIdGeocerca, String flgHabilitado)
       { GeocercaModel.subBorrarGeocerca(psIdGeocerca, flgHabilitado); }


       public static string registrarGeocercaAPartirDeXML(string xml)
       {
          return GeocercaModel.registrarGeocercaBDAPartirDeXML(xml);
       }

    }
}
