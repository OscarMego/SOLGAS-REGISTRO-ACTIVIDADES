<%@ WebHandler Language="C#" Class="recuperarVersion" %>

using System;
using System.Web;
using System.Configuration;
using System.IO;
using System.Xml;

public class recuperarVersion : IHttpHandler
{
    private static String COPYRIGHT = Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_APP_NAME) +
                                        "<br />" +
                                        "<br />" +
                                        Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_AREA_NAME) + " / " +
                                        Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_PIE_P, Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_OPERADOR + Controller.GeneralController.obtenerTemaActual(true))) +
                                        Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.WEB_PIE2_BR) +
                                        "<br/>Servicio al Cliente : Lima : 0-800-1-8844 Provincias : 0-800-1-1110<br/>" +
                                        "Ver tarifas en OSIPTEL.";
    
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Write(mostrarVersiones());
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    #region VERSION
    private static string vacio(string valor)
    {
        if (valor == null || valor.Equals(""))
        {
            return "&nbsp;";
        }
        else
            return valor;
    }
    public static string mostrarVersiones()
    {
        string ubicacion_padre = "";
        string nombre = "";
        try
        {
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
            XmlElement rootElem = xmlDoc.DocumentElement; //Gets the root element, in your xml its "Root"
            if (rootElem != null)
            {
                string salida = "<div class='modal-dialog modal-lg'><div class='modal-content'><div class='modal-header'><h2 class='modal-title' id='myModalLabel'>Versión</h2>" +
                    "<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div>" +
                    "<div class='modal-body'><div class='container-modal'><div class='row'>"+
                            "<div class='about'><p>" + COPYRIGHT + "</p><div class=derecha>suite:" + rootElem.Attributes["suite"].Value + "</br><div class='tb-pc-modal' ><table class='table' summary='Resumen de versiones'><caption>fecha:" + rootElem.Attributes["fecha"].Value + " por " + rootElem.Attributes["responsable"].Value + "</caption><thead><tr><th scope='col'>Objeto</th><th scope='col'>version</th><th scope='col'>version base</th><th scope='col'>framework</th><th scope='col'>estado</th></tr></thead><tbody>";
                for (int i = 0; i < rootElem.ChildNodes.Count; i++)
                {
                    string name = rootElem.ChildNodes[i].Attributes["name"].Value.ToString();
                    string version = rootElem.ChildNodes[i].ChildNodes[0].Attributes["value"].Value.ToString();
                    string versionBase = rootElem.ChildNodes[i].ChildNodes[1].Attributes["value"].Value.ToString();
                    string framework = rootElem.ChildNodes[i].ChildNodes[2].Attributes["value"].Value.ToString();
                    string estado = rootElem.ChildNodes[i].ChildNodes[3].Attributes["value"].Value.ToString();
                    
                    salida = salida + "<tr"+(i%2==0?"":" class='alt'")+">";
                    salida = salida + "<th scope='row'>" + vacio(name) + "</td>";
                    salida = salida + "<td>" + vacio(version) + "</td>";
                    salida = salida + "<td>" + vacio(versionBase) + "</td>";
                    salida = salida + "<td>" + vacio(framework) + "</td>";
                    salida = salida + "<td>" + vacio(estado) + "</td>";
                    salida = salida + "</tr>";
                }

                return salida + "</tbody></table></div></div></div><div class='modal-footer'><div class='container-modal'><button type='button' class='btn btn-default' data-dismiss='modal'>Cancelar</button>" +
                    "</div></div></div></div>";
            }
            else
            {
                throw new Exception("no tiene contenido xml válido");
            }
        }
        catch (Exception e)
        {
            return "<div class='modal-dialog modal-lg'>" +
            "<div class='modal-content'>" +
                "<div class='modal-header'>" +
                  "  <button type='button' class='close' data-dismiss='modal' aria-label='Close'>" +
                   "     <span aria-hidden='true'>&times;</span>" +
                    "</button>" +
                "</div>" +
                "<div class='modal-body'>" +
                  "  <div class='container-modal'>" +
                   "         <div class='row'>Problemas al cargar versiones, ubicacion_padre='" + ubicacion_padre + "': " + e.Message +
                   "</div></div></div><div class='modal-footer'>" +
                    "<div class='container-modal'>" +
                     "   <button type='button' class='btn btn-default' data-dismiss='modal'>Cancelar</button>" +
                    "</div></div></div></div>";
        }
    }
    #endregion


}