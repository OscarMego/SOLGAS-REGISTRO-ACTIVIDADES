using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.functions
{
    /// <summary>
    /// Summary description for Tarea
    /// </summary>
    public class Tarea
    {
        public static String JSEncode(String valor)
        {
            if (valor == null) { return ""; }
            String s1 = valor.Replace("\\", "\\\\");
            String s2 = s1.Replace("\n", "\\n");
            String s3 = s2.Replace("\r", "\\r");
            String s4 = s3.Replace("'", "\\'");
            return s4.Replace("\"", "\\\"");
        }

        public static String borraBarraComa(String valor)
        {
            if (valor == null) { return ""; }
            String s1 = valor.Replace("|", " ");
            String s2 = s1.Replace("$$", " ");
            return s2.Replace(";", " ");
        }

        public static String getTelefono(String ptn, int tamanio)
        {
            //511994001406
            if (ptn.Length >= tamanio)
                return ptn.Substring(ptn.Length - tamanio, tamanio);
            else return ptn;
        }
    }

}
