<%@ WebHandler Language="C#" Class="fileUploader" %>
using System;
using System.Web;
using System.IO;
public class fileUploader : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            string str_image = "";
            var idOportunidad = context.Request["idOportunidad"].ToString();
                  var nombreFoto = context.Request["nombreFoto"].ToString();   
            foreach (string s in context.Request.Files)
            {
                HttpPostedFile file = context.Request.Files[s];              
                byte[] imageSize = new byte[file.ContentLength];
                file.InputStream.Read(imageSize, 0, (int)file.ContentLength);
                Controller.OportunidadController.InsertFoto(idOportunidad, nombreFoto, imageSize);
            }
            context.Response.Write(str_image);
        }
        catch (Exception ac) 
        { 

        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}