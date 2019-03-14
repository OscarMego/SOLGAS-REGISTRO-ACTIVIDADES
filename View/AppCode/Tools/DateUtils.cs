using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Collections.Generic;

namespace Tools
{
    /// <summary>
    /// Clase utilitaria para el trabajo de fecha
    /// </summary>
    public class DateUtils
    {
        /// <summary>
        /// Función que devuelve el número del día de la semana
        /// </summary>
        /// <returns>Número del día de la semana</returns>
        public static int getDayOfTheWeek()
        {
            int day = (int)DateTime.Now.DayOfWeek;
            if (day == 0) day = 7;
            return day;
        }

        /// <summary>
        /// Retorna la fecha en el formato YYMMDD HHMM.
        /// Se espera que el formato del parámetro fecha tenga el formato dd/MM/yyyy hh:mm
        /// </summary>
        /// <param name="stringDate">Fecha en formato dd/MM/yyyy hh:mm</param>
        /// <returns>Fecha en formato YYMMDD HHMM</returns>
        public static string getStringDateYYMMDDHHMM(string stringDate)
        {
            if (stringDate == null) return "";

            stringDate = stringDate.Trim();

            if (stringDate.Length <= 10)
            {
                return getStringDateYYMMDD(stringDate);
            }
            else if (stringDate.Length > 10)
            {
                String[] arrDateParts = stringDate.Split(' ');
                string stringValue = "";
                if (arrDateParts.Length > 0)
                {
                    stringValue = getStringDateYYMMDD(arrDateParts[0]);
                }
                if (arrDateParts.Length > 1)
                {
                    stringValue += ' ' + arrDateParts[1];
                }
                return stringValue.Trim();
            }

            return "";
        }

        /// <summary>
        /// Retorna la fecha en el formato YYYYMMDD.
        /// Se espera que el formato del parámetro fecha tenga el formato dd/MM/yyyy
        /// aMendiola 26/08/2010 - completa con un cero el mes y día en caso tenga un dígito.
        /// </summary>
        /// <param name="stringDate">Fecha en formato dd/MM/yyyy</param>
        /// <returns>Fecha en formato YYMMDD</returns>
        public static string getStringDateYYMMDD(string stringDate)
        {
            if (stringDate != null && !"".Equals(stringDate))
            {
                string[] split = stringDate.Split('/');
                if (split.Length >= 3)
                {
                    string day = split[0];
                    string month = split[1];
                    if (day.Length == 1) day = "0" + day;
                    if (month.Length == 1) month = "0" + month;

                    return (split[2] + month + day);
                }
            }

            return "";
        }

        /// <summary>
        /// Función que divide la parte de fecha y de hora 
        /// en el primer y segundo elemento, respectivamente. 
        /// No es necesario un determinado formato de fecha y hora, 
        /// solo que haya un espacio entre los dos.
        /// </summary>
        /// <param name="stringDate">Fecha con la hora y fecha 
        /// dividdo por espacio</param>
        /// <returns>Arreglo[0] fecha y arreglo[1] hora</returns>
        public static string[] getStringArrayDate(string stringDate)
        {
            string[] stringArrayDate = { "", "00:00" };

            if (stringDate != null && !stringDate.Equals(""))
            {
                string[] split = stringDate.Split(' ');
                if (split.Length > 0)
                {
                    stringArrayDate[0] = split[0];
                }

                if (split.Length > 1)
                {
                    stringArrayDate[1] = split[1];
                }
            }

            return stringArrayDate;
        }

        /// <summary>
        /// Función que proporciona la fecha actual en formato dd/MM/yyyy
        /// </summary>
        /// <returns>Fecha actual en formato dd/MM/yyyy</returns>
        public static string getCurrentDate()
        {
            string day = DateTime.Now.Day.ToString().PadLeft(2, '0');
            string month = DateTime.Now.Month.ToString().PadLeft(2, '0');
            string year = DateTime.Now.Year.ToString().PadLeft(4, '0');


            return day + "/" + month + "/" + year;
        }

        /// <summary>
        /// aMendiola 09/09/2010 - Función que proporciona la fecha 
        /// actual en formato dd/mm/yyyy hh:mm:ss
        /// </summary>
        /// <returns>Fecha actual en formato dd/mm/yyyy hh:mm:ss</returns>
        public static string getCurrentCompleteDate()
        {
            string day = DateTime.Now.Day.ToString().PadLeft(2, '0');
            string month = DateTime.Now.Month.ToString().PadLeft(2, '0');
            string year = DateTime.Now.Year.ToString().PadLeft(4, '0');

            string hour = DateTime.Now.Hour.ToString().PadLeft(2, '0');
            string minute = DateTime.Now.Minute.ToString().PadLeft(2, '0');
            string second = DateTime.Now.Second.ToString().PadLeft(2, '0');

            return day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + second;
        }

        /// <summary>
        /// Función que proporciona la fecha y hora actual (con milisegundos) en formato ddMMyyyyhhmmssmm
        /// </summary>
        /// <returns>Fecha y hora actual en formato ddMMyyyyhhmmssmm</returns>
        public static string getCurrentCompleteDateDigitsDDMMYYYYHHMMSSss()
        {
            string day = DateTime.Now.Day.ToString().PadLeft(2, '0');
            string month = DateTime.Now.Month.ToString().PadLeft(2, '0');
            string year = DateTime.Now.Year.ToString().PadLeft(4, '0');

            string hour = DateTime.Now.Hour.ToString().PadLeft(2, '0');
            string minute = DateTime.Now.Minute.ToString().PadLeft(2, '0');
            string second = DateTime.Now.Second.ToString().PadLeft(2, '0');
            string milisecond = DateTime.Now.Millisecond.ToString().PadLeft(2, '0');

            return day + month + year + hour + minute + second + milisecond;
        }

        #region Validación de fecha
        /// <summary>
        /// Valida si la fecha es correcta
        /// </summary>
        /// <param name="day">Número de día</param>
        /// <param name="month">Número de mes</param>
        /// <param name="year">Número de año</param>
        /// <returns>Bool para validar la fecha</returns>
        public static bool isValidDate(int day, int month, int year)
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

        /// <summary>
        /// Función que valida la fecha.
        /// </summary>
        /// <param name="stringDate">Fecha en formato dd/MM/yyyy</param>
        /// <returns>Bool para validar la fecha</returns>
        public static bool isValidDate(string stringDate)
        {
            int ele1 = 0; int ele2 = 0; int ele3 = 0;

            if (stringDate != null && stringDate.Length >= 8)
            {
                string[] stringArrDate = stringDate.Split('/');
                if (stringArrDate.Length > 0 && MathUtils.isValidIntNumber(stringArrDate[0]))
                {
                    ele1 = int.Parse(stringArrDate[0]);
                }

                if (stringArrDate.Length > 1 && MathUtils.isValidIntNumber(stringArrDate[1]))
                {
                    ele2 = int.Parse(stringArrDate[1]);
                }

                if (stringArrDate.Length > 2 && MathUtils.isValidIntNumber(stringArrDate[2]))
                {
                    ele3 = int.Parse(stringArrDate[2]);
                }
                if (ele1 > 0 && ele2 > 0 && ele3 > 0)
                {

                    return isValidDate(ele1, ele2, ele3);
                }
            }
            return false;
        }

        /// <summary>
        /// Función que valida los valorse y formato de la hora y minutos
        /// </summary>
        /// <param name="stringHourMinute">Hora y minutos a validar</param>
        /// <returns>Bool para validar la hora y minutos</returns>
        public static bool isValidHourMinute(String stringHourMinute)
        {
            bool flag = true;
            try
            {
                string[] arrDateParts = stringHourMinute.Split(':');
                int hour = int.Parse(arrDateParts[0]);
                int minute = int.Parse(arrDateParts[1]);

                if (hour >= 0 && hour < 24 && minute >= 0 && minute < 60)
                {
                    flag = true;
                }
                else
                {
                    flag = false;
                }
            }
            catch (Exception e)
            {
                LogHelper.LogException(e, "Error :isValidHourMinute : ");
                flag = false;
            }
            return flag;
        }

        /// <summary>
        /// Función que valida la fecha y hora completa
        /// </summary>
        /// <param name="stringDate">Fecha y hora</param>
        /// <returns>Bool para validar la fecha</returns>
        public static bool isValidCompleteDate(string stringDate)
        {
            bool flag = false;
            if (stringDate != null && stringDate.Length >= 8)
            {
                string[] arrDateParts = stringDate.Split(' ');
                if (arrDateParts.Length > 0)
                {
                    flag = isValidDate(arrDateParts[0]);
                }
                if (flag && arrDateParts.Length > 1)
                {
                    flag = isValidHourMinute(arrDateParts[1]);
                }
            }
            return flag;
        }
        #endregion
    }
}
