<%@ WebHandler Language="C#" Class="FillCliente" %>

using System;
using System.Web;
using Controller;
using Newtonsoft.Json;
using Model.bean;
using Model;
using System.Collections.Generic;

public class FillCliente : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        String match = context.Request.Params["query"];
        String output = "";
        List<Combo> result = new List<Combo>();
        result = OportunidadController.GetClientes(match);
        //lCli.ForEach(x=>result.Add(new Combo{Nombre=x.nombre,Codigo=x.codigo.ToString()}));
        output = Newtonsoft.Json.JsonConvert.SerializeObject(result, Newtonsoft.Json.Formatting.Indented); 
        context.Response.Write(output);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}