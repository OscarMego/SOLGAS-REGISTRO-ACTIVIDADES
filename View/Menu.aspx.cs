using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Model.bean;
using Controller;
using System.Configuration;
using System.Xml;

public partial class Menu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                Int32 liIdPerfil = 0;
                //Int32 liIdSupervisor = 0;
                if (Session["lgn_id"] != null)
                {
                    liIdPerfil = Convert.ToInt32(Session["lgn_perfil"].ToString());
                    //liIdSupervisor = Convert.ToInt32(Session["lgn_id"].ToString());
                }
                else
                {
                    string myScript = "parent.parent.document.location.href = '" + Request.ApplicationPath + "/default.aspx?acc=EXT';";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, true);
                }

                StringBuilder lsMenuInicio = new StringBuilder();
                List<MenuBean> loLstMenuBean = MenuController.subObtenerDatosMenu(liIdPerfil);

                if (loLstMenuBean.Count > 0)
                {
                    List<MenuBean> loLstMenuBeanPadre = loLstMenuBean.Where(obj => obj.IdMenuPadre.Equals(String.Empty)).ToList();

                    for (int i = 0; i < loLstMenuBeanPadre.Count; i++)
                    {
                        List<MenuBean> loLstMenuBeanHijo = loLstMenuBean.Where(obj => obj.IdMenuPadre.Equals(loLstMenuBeanPadre[i].IdMenu)).ToList();
                        if (loLstMenuBeanHijo.Count > 0)
                        {
                            lsMenuInicio.Append("<div class=\"col-md-4 col-sm-6 col-xs-12\">");
                            lsMenuInicio.Append("<div class=\"menu-ix\">");
                            lsMenuInicio.Append("<h3><i class=\"fas fa-" + loLstMenuBeanPadre[i].UrlImagen + "\"></i>");
                            lsMenuInicio.Append(loLstMenuBeanPadre[i].Descripcion);
                            lsMenuInicio.Append("</h3>");
                            lsMenuInicio.Append("<div class=\"list\">");
                            lsMenuInicio.Append("<ul class=\"all-list\">");

                            for (int j = 0; j < loLstMenuBeanHijo.Count; j++)
                            {
                                String lsDescripcionMenu = loLstMenuBeanHijo[j].Descripcion;
                                lsMenuInicio.Append("<li><a href=\""+loLstMenuBeanHijo[j].Url + "\"><img src=\"images/logo/vin.jpg\">"+lsDescripcionMenu+"</a></li>");
                                
                                //if (lsDescripcionMenu.Length >= 32)
                                //{
                                //    lsDescripcionMenu = lsDescripcionMenu.Substring(0, 32) + "...";
                                //}


                                //if (loLstMenuBeanHijo[j].Codigo.Trim().Equals("RMA"))
                                //{
                                //    lsMenuInicio.Append("<div class=\"cz-other-box-center-box-option\"> <a href='' onclick=\"javascript:irMenuMapaInicio();\" >" + lsDescripcionMenu + "</a> </div>");
                                //}
                                //else
                                //{
                                //    lsMenuInicio.Append("<div class=\"cz-other-box-center-box-option\"> <a href=\"" + loLstMenuBeanHijo[j].Url + "\">" + lsDescripcionMenu + "</a> </div>");
                                //}

                            }

                            lsMenuInicio.Append("</ul>");
                            lsMenuInicio.Append("</div>");
                            lsMenuInicio.Append("</div>");
                            lsMenuInicio.Append("</div>");
                        }
                    }
                }
                try
                {
                    List<Tipo> tipos = obtenerTipos();
                    //lsMenuInicio.Append("<div class=\"cz-other-box-main\">");
                    foreach (Tipo tipo in tipos)
                    {
                        lsMenuInicio.Append("<div class=\"col-md-4 col-sm-6 col-xs-12\">");
                        lsMenuInicio.Append("<div class=\"menu-ix\">");
                        lsMenuInicio.Append("<h3><i class=\"fas fa- \"></i>");
                        lsMenuInicio.Append(tipo.Nombre);
                        lsMenuInicio.Append("</h3>");
                        lsMenuInicio.Append("<div class=\"list\">");
                        lsMenuInicio.Append("<ul class=\"all-list\">");

                        //lsMenuInicio.Append("<div class=\"cz-other-box-center-box\">");
                        //lsMenuInicio.Append("<div class=\"cz-other-box-center-box-title\">").Append(tipo.Nombre).Append("</div>");
                        //lsMenuInicio.Append("<div class=\"cz-other-box-center-box-options\">");

                        if (tipo.Recursos.Count > 0)
                        {
                            foreach (Recurso recurso in tipo.Recursos)
                            {
                                lsMenuInicio.Append("<li><a target='blank' href=\"" + recurso.URL + "\"><img src=\"images/logo/vin.jpg\">" + recurso.Descripcion + "</a></li>");
                                //lsMenuInicio.Append("<div class=\"cz-other-box-center-box-option-nojs\"> <a target='blank' href=\"" + recurso.URL + "\" >" + recurso.Descripcion + "</a> </div>");
                            }
                        }
                        lsMenuInicio.Append("</ul>");
                        lsMenuInicio.Append("</div>");
                        lsMenuInicio.Append("</div>");
                        lsMenuInicio.Append("</div>");
                    }
                }
                catch (Exception) { };
                //lsMenuInicio.Append("</div>");
                MenuInicio.Text = lsMenuInicio.ToString();

            }
        }
        catch (Exception )
        {
             String lsScript = "parent.document.location.href = 'default.aspx?acc=EXT';";
             Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
        }
    }

    private List<Tipo> obtenerTipos()
    {
        String rutaXML = ConfigurationManager.AppSettings["URL_RECURSOS"];
        XmlDocument xml = LeerXmlRemoto(rutaXML);
        List<Tipo> tipos = obtenerTipoAPartirDeXML(xml);
        return tipos;
    }
    private XmlDocument LeerXmlRemoto(string url)
    {
        XmlDocument doc = new XmlDocument();
        doc.Load(url);
        return doc;
    }
    private List<Tipo> obtenerTipoAPartirDeXML(XmlDocument xml)
    {
        List<Tipo> tipos = new List<Tipo>();
        Tipo tipo;

        List<Recurso> recursos;
        Recurso recurso;

        XmlNodeList nodoTipos = xml.GetElementsByTagName("tipo");
        foreach (XmlElement nodoTipo in nodoTipos)
        {
            tipo = new Tipo();
            tipo.Nombre = nodoTipo.GetAttribute("name");
            recursos = new List<Recurso>();
            XmlNodeList nodoObjetos = nodoTipo.GetElementsByTagName("objeto");
            foreach (XmlElement objeto in nodoObjetos)
            {
                XmlNodeList propiedades = objeto.GetElementsByTagName("propiedad");
                recurso = new Recurso();
                foreach (XmlElement propiedad in propiedades)
                {
                    switch (propiedad.GetAttribute("name"))
                    {
                        case "descripcion":
                            recurso.Descripcion = propiedad.GetAttribute("value");
                            break;
                        case "url":
                            recurso.URL = propiedad.GetAttribute("value");
                            break;
                        case "estado":
                            recurso.Estado = propiedad.GetAttribute("value");
                            break;
                    }
                }
                if (recurso.Estado.Equals(Recurso.ESTADO_ACTIVO)) recursos.Add(recurso);
            }
            tipo.Recursos = recursos;
            tipos.Add(tipo);
        }
        return tipos;
    }

}