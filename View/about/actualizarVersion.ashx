<%@ WebHandler Language="C#" Class="actualizarVersion" %>

using System;
using System.Web;
using System.Configuration;
using System.IO;
using System.Xml;
using System.Data.SqlClient;
using System.Data;

public class actualizarVersion : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {        
        // recuperar de xml de archivo
        context.Response.ContentType = "text/plain";
        try
        {
            string ubicacion_padre = "";
            string nombre = "";
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
            StringWriter sw = new StringWriter();
            XmlTextWriter xw = new XmlTextWriter(sw);
            xmlDoc.WriteTo(xw);
            string versiones = sw.ToString();            
            
            //XmlElement rootElem = xmlDoc.DocumentElement; //Gets the root element, in your xml its "Root"
            StreamReader reader = new StreamReader(context.Request.InputStream);
            string xmlFuentes = HttpUtility.UrlDecode(reader.ReadToEnd());

            SqlParameter parameter,parameter2;
            parameter = new SqlParameter("@versiones",versiones);
            parameter2 = new SqlParameter("@versiones_fuentes", xmlFuentes);
            ConnectionStringSettings connectionSettings = ConfigurationManager.ConnectionStrings["SQLServerConnection"];
            SqlConnection conn = new SqlConnection(connectionSettings.ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand("spQ_ManInsRelease", conn);
            cmd.Parameters.Add(parameter);
            cmd.Parameters.Add(parameter2);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader sqlReader = cmd.ExecuteReader();

            string resultado="";
            if (sqlReader.HasRows)
            {
                while (sqlReader.Read())
                {
                        resultado = "<r c='"+sqlReader.GetString(0)+"' m='"+sqlReader.GetString(1)+"' />";
                        break;
                }
                context.Response.Write(resultado);
            }
            else
            {
                context.Response.Write("<r c='0' m='Revise configuración no se realizaron cambios'/>");                            
            }
            reader.Close();            
            
            conn.Close();
            
             
        }catch (Exception e) {
            context.Response.Write(e.Message);            
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}