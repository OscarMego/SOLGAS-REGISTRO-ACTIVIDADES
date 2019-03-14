using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Collections.Generic;
using System.Collections;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Checksums;
using System.Text.RegularExpressions;
using System.IO.Compression;
using System.Text;
using System.Reflection;
using System.ComponentModel;

namespace Tools
{
    /// <summary>
    /// Clase utilitaria para el trabajo de cadenas de texto y compresión/decompresión de arreglos de byte
    /// </summary>
    public class StringUtils
    {

        #region Conversiones
        /// <summary>
        /// Función que cambia la primera letra de la palabra a mayúscula.
        /// Si la palabra es nula o vacía, devuelve vacío.
        /// </summary>
        /// <param name="word">Palabra a modificar a primera letra.</param>
        /// <returns>Palabra con la primera letra en mayúscula</returns>
        public static string changeFirstLetterToUppercase(string word)
        {
            if (string.IsNullOrEmpty(word))
            {
                return string.Empty;
            }
            // Return char and concat substring.
            return char.ToUpper(word[0]) + word.Substring(1).ToLower();
        }

        /// <summary>
        /// Función que reemplaza los caracteres ' y \ por _ dentro de la cadena
        /// </summary>
        /// <param name="stringParameter">Cadena a cambiar en caso tenga ' o \</param>
        /// <returns>Cadena sin caracteres ' o \</returns>
        public static String replaceForUnderline(String stringParameter)
        {
            String response;

            response = stringParameter.Replace("'", "_");
            response = response.Replace("\"", "_");

            return response;
        }

        /// <summary>
        /// Transformación para el encode de javascript.
        /// </summary>
        /// <param name="value">valor a transformar.</param>
        /// <returns>Valor transformado a javascript.</returns>
        public static String JSEncode(String value)
        {
            if (value == null) { return ""; }
            String s1 = value.Replace("\\", "\\\\");
            String s2 = s1.Replace("\n", "\\n");
            String s3 = s2.Replace("\r", "\\r");
            String s4 = s3.Replace("'", "\\'");

            return s4.Replace("\"", "\\\"");
        }

        /// <summary>
        /// Convierte el parameterString de null a vacio si es nulo. 
        /// Caso contrario, devuelve el misma parameterString.
        /// </summary>
        /// <param name="parameterString">Cadena de texto</param>
        /// <returns>"" si el parametro es nulo, 
        /// sino el mismo valor del parametro</returns>
        public static String convertNullStringToBlank(String parameterString)
        {
            return parameterString != null ? parameterString : "";
        }

        /// <summary>
        /// Función que convierte el String ingresado a char
        /// </summary>
        /// <param name="stringParameter">string a convertir</param>
        /// <returns>String convertido a char. 
        /// En caso el String sea nulo, el char tendrá de valor '0'</returns>
        public static char convertStringToChar(String stringParameter)
        {
            char result = '0';
            if (stringParameter != null)
            {
                if (stringParameter.Length > 0)
                    result = stringParameter.ToCharArray()[0];
            }

            return result;
        }

        /// <summary>
        /// Función que convierte el String ingresado a int
        /// </summary>
        /// <param name="stringParameter">string a convertir</param>
        /// <returns>String convertido a int. 
        /// En caso el String sea nulo, el int tendrá de valor 0</returns>
        public static int convertStringToInt(String stringParameter)
        {
            int result = 0;
            if (stringParameter != null)
            {
                if (MathUtils.isValidIntNumber(stringParameter))
                {
                    result = Convert.ToInt32(stringParameter);
                }
            }

            return result;
        }

        /// <summary>
        /// Función que convierte el String ingresado a Int64
        /// </summary>
        /// <param name="stringParameter">string a convertir</param>
        /// <returns>String convertido a Int64. 
        /// En caso el String sea nulo, el Int64 tendrá de valor 0</returns>
        public static Int64 convertStringToInt64(String stringParameter)
        {
            Int64 result = 0;
            if (stringParameter != null)
            {
                if (MathUtils.isValidInt64Number(stringParameter))
                {
                    result = Convert.ToInt64(stringParameter);
                }
            }

            return result;
        }

        public static String convertBinaryToString(Byte[] binaryParameter)
        {
            string s = "";
            for (Int64 i = 0; i < binaryParameter.Length; i++)
            {
                s += (char)binaryParameter[i];
            }
            return s;
        }
        #endregion

        #region Compresión de byteArray
        /// <summary>
        /// Función de compresión. 
        /// El algoritmo varía dependiendo de la plataforma proveniente.
        /// </summary>
        /// <param name="data">Arreglo de bytes a comprimir</param>
        /// <param name="platform">Plataforma proveniente: 2G (iDEN) o 3G</param>
        /// <returns>Arreglo de bytes comprimido en formato *.zip</returns>
        public static byte[] compress(byte[] data, String platform)
        {
            MemoryStream stream = new MemoryStream();
            byte[] buffer;

            if (platform.Equals("2G"))
            {
                ZipOutputStream oZipStream = new ZipOutputStream(stream);

                ZipEntry entry = new ZipEntry("datos.bin");
                entry.Size = data.Length;
                oZipStream.PutNextEntry(entry);
                oZipStream.Write(data, 0, data.Length);
                oZipStream.CloseEntry();
                oZipStream.Finish();
                oZipStream.Close();
            }
            else if (platform.Equals("3G"))
            {
                using (GZipStream gz = new GZipStream(stream, CompressionMode.Compress, false))
                {
                    gz.Write(data, 0, data.Length);
                }
            }
            buffer = stream.ToArray();
            return buffer;
        }

        /// <summary>
        /// Función de descompresión. 
        /// El algoritmo varía dependiendo de la plataforma proveniente.
        /// HMONTERO 24/09/2012 - El algoritmo de 3G está de PRUEBA.
        /// JROEDER - Arreglo de algoritmo final.
        /// </summary>
        /// <param name="data">Arreglo de bytes a comprimir</param>
        /// <param name="platform">Plataforma proveniente: 2G (iDEN) o 3G</param>
        /// <returns>Arreglo de bytes descomprimido.</returns>
        public static byte[] decompress(byte[] data, string platform)
        {
            MemoryStream mem = new MemoryStream(data);
            MemoryStream memOut = new MemoryStream();

            if (platform.Equals("2G"))
            {
                ZipInputStream zin = new ZipInputStream(mem);
                ZipEntry zen = zin.GetNextEntry();
                int bufferSize = 4096;
                byte[] buf = new byte[bufferSize];
                int count = 0;

                while (true)
                {
                    count = zin.Read(buf, 0, bufferSize);
                    if (count != 0)
                    {
                        memOut.Write(buf, 0, count);
                    }

                    if (count != bufferSize)
                    {
                        // have reached the end
                        break;
                    }
                }
            }
            else if (platform.Equals("3G"))
            {
                GZipStream instream = new GZipStream(mem, CompressionMode.Decompress);

                int bufferSize = 4096;
                byte[] buf = new byte[bufferSize];
                int count = 0;

                while (true)
                {
                    count = instream.Read(buf, 0, bufferSize);
                    if (count != 0)
                    {
                        memOut.Write(buf, 0, count);
                    }

                    if (count != bufferSize)
                    {
                        // have reached the end
                        break;
                    }
                }
            }

            return memOut.ToArray();
        }
        #endregion
    }
}
