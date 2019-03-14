using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.IO;
using System.ComponentModel;
using System.Reflection;

namespace Controller.functions
{
   public class Utils
    {
        /*****************************************************************************
    Retorna la fecha en el formato YYYYMMDD  
    Se espera que el formato del parámetro fecha tenga el formato dd/MM/yyyy
    *****************************************************************************/
        public static string getStringFechaYYMMDD(string fecha)
        {

            if (fecha != null && !"".Equals(fecha))
            {
                string[] split = fecha.Split('/');
                if (split.Length >= 3)
                {
                    //aMendiola 26/08/2010, completa con un cero el mes y día en caso tenga un dígito.
                    string dia = split[0];
                    string mes = split[1];
                    if (dia.Length == 1) dia = "0" + dia;
                    if (mes.Length == 1) mes = "0" + mes;

                    return (split[2] + mes + dia);
                }
            }

            return "";

        }

        //Devuelve YYYYMMDD hh:mm:ss
        public static string getStringFechaYYMMDDHHMM(string fecha)
        {
            if (fecha == null) return "";

            fecha = fecha.Trim();

            if (fecha.Length <= 10)
            {
                return getStringFechaYYMMDD(fecha);
            }
            else if (fecha.Length > 10)
            {
                String[] arrElementosFecha = fecha.Split(' ');
                string cadena = "";
                if (arrElementosFecha.Length > 0)
                {
                    cadena = getStringFechaYYMMDD(arrElementosFecha[0]); //yyyymmdd
                }
                if (arrElementosFecha.Length > 1)
                {
                    cadena += ' ' + arrElementosFecha[1];
                }
                return cadena.Trim();
            }

            return "";
        }

        public static string getFechaActual()
        {
            string dia = DateTime.Now.Day.ToString().PadLeft(2, '0');
            string mes = DateTime.Now.Month.ToString().PadLeft(2, '0');
            string anio = DateTime.Now.Year.ToString().PadLeft(4, '0');


            return dia + "/" + mes + "/" + anio;

        }

        public static string[] getFechaArray(string fecha)
        {
            string[] array = { "", "00:00" };

            if (fecha != null && !"".Equals(fecha))
            {
                string[] split = fecha.Split(' ');
                if (split.Length > 0)
                {
                    array[0] = split[0];
                }

                if (split.Length > 1)
                {
                    array[1] = split[1];
                }

            }

            return array;

        }

        //aMendiola 09/09/2010 [Format: dd/mm/yyyy hh:mm:ss]
        public static string getFechaActualCompleta()
        {
            string dia = DateTime.Now.Day.ToString().PadLeft(2, '0');
            string mes = DateTime.Now.Month.ToString().PadLeft(2, '0');
            string anio = DateTime.Now.Year.ToString().PadLeft(4, '0');

            string hora = DateTime.Now.Hour.ToString().PadLeft(2, '0');
            string minuto = DateTime.Now.Minute.ToString().PadLeft(2, '0');
            string segundo = DateTime.Now.Second.ToString().PadLeft(2, '0');

            return dia + "/" + mes + "/" + anio + " " + hora + ":" + minuto + ":" + segundo;
        }

        /*****************************************************************************
         Retorna la fecha en el formato dd/MM/yyyy
         *****************************************************************************/
        public static string getFecha(DateTime fecha)
        {

            string dia = fecha.Day.ToString().PadLeft(2, '0');
            string mes = fecha.Month.ToString().PadLeft(2, '0');
            string anio = fecha.Year.ToString().PadLeft(4, '0');


            return dia + "/" + mes + "/" + anio;

        }

        public static bool isValid(int day, int month, int year)
        {
            if (!(month >= 1 && month <= 12)
            || !(day >= 1 && day <= 31)
            || !(year >= 1000 && year <= 9999)
            || (day == 31 &&
            (month == 4 /*april*/ || month == 6 /*june*/ ||
            month == 9 /*sept*/ || month == 11 /*nov*/ )) ||
            (month == 2 /*feb*/ && day > 29))
            {
                return false;
            }
            if (month == 2 && day == 29)
            { // if a year is divisible by 4 it is a leap year UNLESS it is also
                // divisible by 100 AND is not divisible by 400
                if (year % 4 > 0
                || ((year % 100 == 0) && (year % 400 > 0)))
                {
                    return false;
                }
            }
            return true;
        }
        //dd/mm/yyyy
        public static bool validarFechaCompleta(string fecha)
        {
            bool flag = false;
            if (fecha != null && fecha.Length >= 8)
            {
                string[] arrElementosFecha = fecha.Split(' ');
                if (arrElementosFecha.Length > 0)
                {
                    flag = validaFecha(arrElementosFecha[0]);
                }
                if (flag && arrElementosFecha.Length > 1)
                {
                    flag = validarHoraMinuto(arrElementosFecha[1]);
                }
            }
            return flag;
        }

        private static bool validaFecha(string fecha)
        {
            int ele1 = 0; int ele2 = 0; int ele3 = 0;

            if (fecha != null && fecha.Length >= 8)
            {
                string[] afecha = fecha.Split('/');
                if (afecha.Length > 0 && validarNumeroEntero(afecha[0]))
                {
                    ele1 = int.Parse(afecha[0]);
                }

                if (afecha.Length > 1 && validarNumeroEntero(afecha[1]))
                {
                    ele2 = int.Parse(afecha[1]);
                }

                if (afecha.Length > 2 && validarNumeroEntero(afecha[2]))
                {
                    ele3 = int.Parse(afecha[2]);
                }
                if (ele1 > 0 && ele2 > 0 && ele3 > 0)
                {

                    return isValid(ele1, ele2, ele3);
                }
            }
            return false;
        }

        public static bool validarHoraMinuto(String horapara)
        {
            bool flag = true;
            try
            {
                string[] arrElementosFecha = horapara.Split(':');
                int hora = int.Parse(arrElementosFecha[0]);
                int minuto = int.Parse(arrElementosFecha[1]);


                if (hora >= 0 && hora < 24 && minuto >= 0 && minuto < 60)
                {
                    flag = true;
                }
                else
                {
                    flag = false;
                }
            }
            catch (Exception )
            {

                flag = false;
            }
            return flag;
        }


        public static Boolean validarNumeroEntero(String numero)
        {
            Boolean flag = true;
            try
            {
                Convert.ToInt32(numero);

            }
            catch (Exception )
            {

                flag = false;
            }
            return flag;
        }

        public static Boolean validarNumeroEntero64(String numero)
        {
            Boolean flag = true;
            try
            {
                Convert.ToInt64(numero);

            }
            catch (Exception )
            {

                flag = false;
            }
            return flag;
        }

        public static Boolean validarNumeroDecimal(String numero)
        {
            Boolean flag = true;

            if (!(numero != null && numero != ""))
            {
                return false;
            }

            try
            {
                Convert.ToDouble(numero);
            }
            catch (Exception )
            {
                flag = false;
            }
            return flag;
        }

        public static T DeserializeXml<T>(string xml)
        {
            XmlSerializer xmlSer = new XmlSerializer(typeof(T));
            StringReader stringReader = new StringReader(xml);
            return (T)xmlSer.Deserialize(stringReader);
        }



        public static String fnVerNuloStr(String poObjeto)
        {
            return poObjeto == null ? "" : poObjeto;
        }
        public static int fnVerNuloInt(object poObjeto)
        {
            return poObjeto != null && !"".Equals(poObjeto.ToString().Trim()) ? int.Parse(poObjeto.ToString().Trim()) : 0;
        }


        public static Boolean tieneCaracteresReservados(string st)
        {
            string CARACTERES_RESERVADOS = "\"|;&$#()[]{}\'";

            if (st.IndexOfAny(CARACTERES_RESERVADOS.ToCharArray()) != -1)
            {
                return true;
            }
            return false;
        }
    }
}
