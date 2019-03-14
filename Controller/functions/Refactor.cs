using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;


public class Refactor
{
    private Object objeto;
    private Type type;
    public Refactor(Object objeto1)
    {
        objeto = objeto1;
        type = objeto1.GetType();
    }

    public string getValue(string atributo)
    {
        if (type.GetProperty(atributo) != null)
        {

            object obj = (type.GetProperty(atributo).GetValue(objeto, null));
            return HttpUtility.HtmlEncode(obj.ToString());
        }
        else
        {
            return null;
        }

    }

    public string getValueJS(string atributo)
    {
        object obj = (type.GetProperty(atributo).GetValue(objeto, null));
        return JSEncode(obj.ToString());
    }


    public static String JSEncode(String valor)
    {
        if (valor == null) { return ""; }
        String s1 = valor.Replace("\\", "\\\\");
        String s2 = s1.Replace("\n", "\\n");
        String s3 = s2.Replace("\r", "\\r");
        String s4 = s3.Replace("'", "\\'");
        return s4.Replace("\"", "\\\"");
    }
}
