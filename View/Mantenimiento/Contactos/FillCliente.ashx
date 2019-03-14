<%@ WebHandler Language="C#" Class="FillCliente" %>

using System;
using System.Web;
using Controller;
using Newtonsoft.Json;
using Model.bean;
using Model;
using System.Collections.Generic;

public class FillCliente : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
       String match = context.Request.Params["query"];
        String output = "";
        List<Combo> result = new List<Combo>();
        result = OportunidadController.GetClientes(match, null, null);
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