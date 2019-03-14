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
    /// Clase utilitaria para el trabajo de n�meros
    /// </summary>
    public class MathUtils
    {

        #region Validaci�n de n�meros
        /// <summary>
        /// Funci�n que valida si es un n�mero Int
        /// </summary>
        /// <param name="number">N�mero a validar</param>
        /// <returns>Boolean con la validaci�n</returns>
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
        /// Funci�n que valida si es un n�mero Int64
        /// </summary>
        /// <param name="number">N�mero a validar</param>
        /// <returns>Boolean con la validaci�n</returns>
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
        /// Funci�n que valida si es un n�mero Double
        /// </summary>
        /// <param name="number">N�mero a validar</param>
        /// <returns>Boolean con la validaci�n</returns>
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
        /// Funci�n que convierte el �ngulo en grados a Radianes
        /// </summary>
        /// <param name="angle">�ngulo en grados </param>
        /// <returns>�ngulo convertido a radianes</returns>
        private static double convertToRadian(double angle)
        {
            return Math.PI * angle / 180.0;
        }
    }
}
