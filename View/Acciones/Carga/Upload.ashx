<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;

public class Upload : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        HttpRequest request = context.Request;
        String fileLocation = HttpContext.Current.Server.MapPath("~") + System.Configuration.ConfigurationManager.AppSettings["rutaTMP"].ToString();
        FastZip fs = new FastZip();

        //Random rnd = new Random();
        //int azar = rnd.Next(1, 10000);

        if (IsIE9(request))
        {
            byte[] buffer = new byte[request.ContentLength];
            using (BinaryReader br = new BinaryReader(request.Files["qqfile"].InputStream))
                br.Read(buffer, 0, buffer.Length);

            string filename = Path.GetFileName(request.Files["qqfile"].FileName);
            //File.WriteAllBytes(request.PhysicalApplicationPath + filename, buffer);

            File.WriteAllBytes(fileLocation + filename, buffer);


            //Extract Zip File
            if (filename.Contains(".zip"))
            {
                fs.ExtractZip(fileLocation + filename, fileLocation, null);
                //String[] namesFiles = Directory.GetFiles(this.TMPLocation, "*.txt");
            }

            context.Response.Write("{success:true}");
            context.Response.End();

        }
        else
        {
            byte[] buffer = new byte[request.ContentLength];
            using (BinaryReader br = new BinaryReader(request.InputStream))
                br.Read(buffer, 0, buffer.Length);


            //File.WriteAllBytes(request.PhysicalApplicationPath + request["qqfile"], buffer);
            File.WriteAllBytes(fileLocation + request["qqfile"], buffer);


            //Extract Zip File
            if (request["qqfile"].Contains(".zip"))
            {
                fs.ExtractZip(fileLocation + request["qqfile"], fileLocation, null);
                //String[] namesFiles = Directory.GetFiles(this.TMPLocation, "*.txt");
            }
            context.Response.Write("{success:true}");
            context.Response.End();

        }

        context.Response.Write("{error:\"Upload failed! Unexpected request.\"}");
        context.Response.End();

    }


    private bool IsIE9(HttpRequest request)
    {
        return request["qqfile"] == null;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}