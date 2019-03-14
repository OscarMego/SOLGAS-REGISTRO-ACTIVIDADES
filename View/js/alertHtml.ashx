<%@ WebHandler Language="C#" Class="alertHtml" %>

using System;
using System.Web;
using System.Text;
using Model.bean;
public class alertHtml : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/javascript";
        
        
        StringBuilder sb = new StringBuilder();
        
        sb.Append("function alertHtml(tipo, error, titulo) {\n");
        sb.Append("var strHtml = '';\n");
        sb.Append("if (tipo == \"delConfirm\") {\n");
        sb.Append("strHtml = '<div class=\"modal-header\">';\n");
        sb.Append("strHtml = strHtml + '<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>';\n");

        sb.Append("strHtml = strHtml + '<h3 id=\"H2\">Alerta</h3></div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-body\">';\n");
        sb.Append("strHtml = strHtml + '<img src=\"../../images/alert/ico_alert.png\" style=\"float: left;height: 32px;\"/> <p style=\"float: left;line-height: 32px;margin-left: 10px!important;\">'+titulo+'</p></div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-footer\">';\n");
        sb.Append("strHtml = strHtml + '<button class=\"form-button cz-form-content-input-button\" data-dismiss=\"modal\" aria-hidden=\"true\" style=\"margin-right: 10px;\">No</button>'\n");
        sb.Append("strHtml = strHtml + '<button class=\"btnDelSi form-button cz-form-content-input-button\" data-dismiss=\"modal\" aria-hidden=\"true\">Si</button></div>';\n");
        sb.Append("}");
        sb.Append("else if (tipo == \"delConfirmFalta\") {\n");
        sb.Append("strHtml = '<div class=\"modal-header\">';\n");
        sb.Append("strHtml = strHtml + '<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>';\n");
        sb.Append("strHtml = strHtml + '<h3 id=\"H1\">Alerta</h3></div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-body\">';\n");
        sb.Append("strHtml = strHtml + '<img src=\"../../images/alert/ico_alert.png\" style=\"float: left;height: 32px;\"/> <p style=\"float: left;line-height: 32px;margin-left: 10px!important;\">Seleccione un item.</p></div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-footer\">';");
        sb.Append("strHtml = strHtml + '<button class=\"form-button cz-form-content-input-button\" data-dismiss=\"modal\" aria-hidden=\"true\">CERRAR</button></div>';\n");
        sb.Append("}\n");
        sb.Append("else if (tipo == \"error\") {\n");
        sb.Append("strHtml = '<div class=\"modal-header\">';\n");
        sb.Append("strHtml = strHtml + '<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>';\n");
        sb.Append("strHtml = strHtml + '<h3 id=\"H1\">Error</h3></div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-body\">';\n");
        sb.Append("strHtml = strHtml + error+'</div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-footer\">';\n");
        sb.Append("strHtml = strHtml + '<button class=\"form-button cz-form-content-input-button\" data-dismiss=\"modal\" aria-hidden=\"true\">CERRAR</button></div>';\n");
        sb.Append("}\n");

        sb.Append("else if (tipo == \"errorCarga\") {\n");
        sb.Append("strHtml = '<div class=\"modal-header\">';\n");
        sb.Append("strHtml = strHtml + '<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>';\n");
        sb.Append("strHtml = strHtml + '<h3 id=\"H1\">'+titulo+'</h3></div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-body\">';\n");
        sb.Append("strHtml = strHtml + error + '</div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-footer\">';\n");
        sb.Append("strHtml = strHtml + '<button class=\"form-button cz-form-content-input-button\" data-dismiss=\"modal\" aria-hidden=\"true\">CERRAR</button></div>';\n");
        sb.Append("}\n");



        sb.Append("else if (tipo == \"alertValidacion\") {\n");
        sb.Append("strHtml = '<div class=\"modal-header\">';\n");
        sb.Append("strHtml = strHtml + '<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>';\n");
        sb.Append("strHtml = strHtml + '<h3 id=\"H1\">Alerta</h3></div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-body\">';\n");
        sb.Append("strHtml = strHtml + '<img src=\"../../images/alert/ico_alert.png\" style=\"float: left;height: 32px;\"/> <p style=\"float: left;margin-top: 6px!important;margin-left: 7px!important;\">' + error + '</div>';\n");
        sb.Append("strHtml = strHtml + '<div class=\"modal-footer\">';\n");
        sb.Append("strHtml = strHtml + '<button class=\"form-button cz-form-content-input-button\" data-dismiss=\"modal\" aria-hidden=\"true\">CERRAR</button></div>';\n");
        sb.Append("}\n");
        sb.Append("return strHtml; }\n");


        context.Response.Write(sb.ToString());
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}