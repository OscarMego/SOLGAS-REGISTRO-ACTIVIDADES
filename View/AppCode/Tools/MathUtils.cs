using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Tools
{
    /// <summary>
    /// Clase utilitaria para el trabajo de números
    /// </summary>
    public class MathUtils
    {

        #region Validación de números
        /// <summary>
        /// Función que valida si es un número Int
        /// </summary>
        /// <param name="number">Número a validar</param>
        /// <returns>Boolean con la validación</returns>
        public static Boolean isValidIntNumber(String number)
        {
            Boolean flag = true;
            try
            {
                Convert.ToInt32(number);
            }
            catch (Exception e)
            {
                flag = false;
                LogHelper.LogException(e, "Error :isValidIntNumber : ");
            }
            return flag;
        }

        /// <summary>
        /// Función que valida si es un número Int64
        /// </summary>
        /// <param name="number">Número a validar</param>
        /// <returns>Boolean con la validación</returns>
        public static Boolean isValidInt64Number(String number)
        {
            Boolean flag = true;
            try
            {
                Convert.ToInt64(number);
            }
            catch (Exception e)
            {
                LogHelper.LogException(e, "Error :isValidInt64Number : ");
                flag = false;
            }
            return flag;
        }

        /// <summary>
        /// Función que valida si es un número Double
        /// </summary>
        /// <param name="number">Número a validar</param>
        /// <returns>Boolean con la validación</returns>
        public static Boolean isValidDecimalNumber(String number)
        {
            Boolean flag = true;

            if (!(number != null && number != ""))
            {
                return false;
            }

            try
            {
                Convert.ToDouble(number);
            }
            catch (Exception e)
            {
                LogHelper.LogException(e, "Error :isValidDecimalNumber : ");
                flag = false;
            }
            return flag;
        }
        #endregion

        /// <summary>
        /// Función que convierte el ángulo en grados a Radianes
        /// </summary>
        /// <param name="angle">Ángulo en grados </param>
        /// <returns>Ángulo convertido a radianes</returns>
        private static double convertToRadian(double angle)
        {
            return Math.PI * angle / 180.0;
        }
    }
}
