<%@ WebHandler Language="C#" Class="colors" %>

using System;
using System.Web;
using System.Reflection;

public class colors : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/css";

        string codigo_color = Controller.GeneralController.obtenerTemaActual(true);
        
        string color = "azul";
        
        string line = "";

        if (codigo_color == "1")
        {
            color = "naranja";
        }
        else if (codigo_color == "0")
        {
            color = "azul";
        }

        
        string path = System.AppDomain.CurrentDomain.BaseDirectory;
        
        System.IO.StreamReader file = new System.IO.StreamReader(path + @"css/cz_main.css");
        System.IO.StreamReader csscolor = new System.IO.StreamReader(path + @"css/colors/" + color + ".css");

        while ((line = file.ReadLine()) != null)
        {
            context.Response.Write(line);
        }

        file.Close();


        while ((line = csscolor.ReadLine()) != null)
        {
            context.Response.Write(line);
        }

        csscolor.Close();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}