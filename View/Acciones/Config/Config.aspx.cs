using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Controller;
using Model.bean;
using Controller.functions;
using System.Web.Script.Serialization;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;
using Model;

public partial class Mantenimiento_Config : PageController
{
    protected override void initialize()
    {
        if (Session["lgn_id"] == null || !fnValidarPerfilMenu("COF", Enumerados.FlagPermisoPerfil.VER))
        {
            Session.Clear();
            string myScript = ConfigurationManager.AppSettings["URL_LOGIN"];
            String lsScript = "parent.document.location.href = '" + myScript + "/default.aspx?acc=SES';";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
        }
        else
        {
            try
            {
                if (!IsPostBack)
                {
                    //List<ConfiguracionBean> loLstConfiguracionBean = new List<ConfiguracionBean>();
                    //loLstConfiguracionBean = ConfiguracionController.subObtenerDatosConfiguracion();
                    //this.subEscribirConfiguracionModulo(loLstConfiguracionBean);
                    //this.subEscribirConfiguracionFunciones(loLstConfiguracionBean);
                    //this.subEscribirConfiguracionValores(loLstConfiguracionBean);
                    //List<ManualBean> loLstManuales = MenuController.subObtenerDatosManuales(Convert.ToInt32(Session["lgn_id"]));
                    //this.subEscribirManuales(loLstManuales);

                }

            }
            catch (Exception)
            {
                String lsRutaDefault = "parent.document.location.href = '../../default.aspx?acc=EXT';";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsRutaDefault, true);
            }
        }
    }

    private void subEscribirConfiguracionModulo(List<ConfiguracionBean> poLstConfiguracionBean)
    {
        StringBuilder loModuloConfiguracion = new StringBuilder();
        List<ConfiguracionBean> loLstConfiguracionBeanModulo = new List<ConfiguracionBean>();
        loLstConfiguracionBeanModulo = this.subObtenerListaConfiguracionPorCodigo(poLstConfiguracionBean, Enumerados.CodigoConfiguracion.MOD);
        //String lsDisplayNone = " style=\"display: none;\" ";
        //String lsStyle;
        if (loLstConfiguracionBeanModulo != null && loLstConfiguracionBeanModulo.Count > 0)
        {
            loModuloConfiguracion.Append("<div class=\"cz-form-content cz-content-extended\">");
            loModuloConfiguracion.Append("<div class=\"cz-form-subcontent\">");
            loModuloConfiguracion.Append("<div class=\"cz-form-subcontent-title\">");
            loModuloConfiguracion.Append("<p>Módulo</p>");
            loModuloConfiguracion.Append("</div>");
            loModuloConfiguracion.Append("<div class=\"cz-form-subcontent-content\">");
            loModuloConfiguracion.Append("<div class=\"cz-form-content-input-check\">");
            for (int i = 0; i < loLstConfiguracionBeanModulo.Count; i++)
            {
                if (loLstConfiguracionBeanModulo[i].FlagHabilitado.Equals(Enumerados.FlagHabilitado.T.ToString()))
                {

                    String lsInput = String.Empty;
                    /*lsStyle = loLstConfiguracionBeanModulo[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.MOD_GENERAL) ? lsDisplayNone : String.Empty;*/
                    String lsIdElementoHtml = loLstConfiguracionBeanModulo[i].Codigo.Trim() + "_" + loLstConfiguracionBeanModulo[i].Tipo.Trim();
                    lsInput = (loLstConfiguracionBeanModulo[i].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                               ? "<input type=\"checkbox\" class=\"cz-form-content-input-check\" id=\"" + lsIdElementoHtml + "\" name=\"" + lsIdElementoHtml + "\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\" onclick=\"javascript:modifiacarValorCheckedModulo('" + lsIdElementoHtml + "');\" checked=\"checked\" />"
                               : "<input type=\"checkbox\" class=\"cz-form-content-input-check\" id=\"" + lsIdElementoHtml + "\" name=\"" + lsIdElementoHtml + "\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\" onclick=\"javascript:modifiacarValorCheckedModulo('" + lsIdElementoHtml + "');\" />";
                    loModuloConfiguracion.Append(lsInput);
                    loModuloConfiguracion.Append("<a class=\"cz-form-content-input-check-title\" >" + loLstConfiguracionBeanModulo[i].Descripcion.Trim() + "<a/>");
                    loModuloConfiguracion.Append("<br />");
                    loModuloConfiguracion.Append("<br />");
                }
            }
            loModuloConfiguracion.Append("</div>");
            loModuloConfiguracion.Append("</div>");
            loModuloConfiguracion.Append("</div>");
            loModuloConfiguracion.Append("</div>");
        }

        litModulo.Text = loModuloConfiguracion.ToString();
    }

    private void subEscribirConfiguracionFunciones(List<ConfiguracionBean> poLstConfiguracionBean)
    {
        StringBuilder loFuncionesConfiguracion = new StringBuilder();
        List<ConfiguracionBean> loLstConfiguracionBeanFunciones = new List<ConfiguracionBean>();
        loLstConfiguracionBeanFunciones = this.subObtenerListaConfiguracionPorCodigo(poLstConfiguracionBean, Enumerados.CodigoConfiguracion.FUN);

        List<ConfiguracionBean> loLstConfiguracionBeanModulo = new List<ConfiguracionBean>();
        loLstConfiguracionBeanModulo = this.subObtenerListaConfiguracionPorCodigo(poLstConfiguracionBean, Enumerados.CodigoConfiguracion.MOD);
        // String lsStyle;
        //String lsDisplayNone = " style=\"display: none;\" ";
        for (int i = 0; i < loLstConfiguracionBeanModulo.Count; i++)
        {
            if (loLstConfiguracionBeanModulo[i].FlagHabilitado.Equals(Enumerados.FlagHabilitado.T.ToString()))
            {
                /*lsStyle = loLstConfiguracionBeanModulo[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.MOD_GENERAL) ? lsDisplayNone : String.Empty;*/
                List<ConfiguracionBean> loLstConfiguracionBeanFuncionesPorModulo = loLstConfiguracionBeanFunciones.FindAll(obj => obj.TipoPadre.Equals(loLstConfiguracionBeanModulo[i].Codigo));
                String lsClaseIndentificador = loLstConfiguracionBeanModulo[i].Codigo.Trim() + "_" + loLstConfiguracionBeanModulo[i].Tipo.Trim();
                if (loLstConfiguracionBeanFuncionesPorModulo != null && loLstConfiguracionBeanFuncionesPorModulo.Count > 0)
                {
                    loFuncionesConfiguracion.Append("<div class=\"cz-form-content cz-content-extended\" >");
                    loFuncionesConfiguracion.Append("<div class=\"cz-form-subcontent\">");
                    loFuncionesConfiguracion.Append("<div class=\"cz-form-subcontent-title\">");
                    loFuncionesConfiguracion.Append("<p>" + loLstConfiguracionBeanModulo[i].Descripcion.Trim() + "</p>");
                    loFuncionesConfiguracion.Append("</div>");
                    loFuncionesConfiguracion.Append("<div class=\"cz-form-subcontent-content\">");
                    loFuncionesConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                    for (int j = 0; j < loLstConfiguracionBeanFuncionesPorModulo.Count; j++)
                    {
                        if (loLstConfiguracionBeanFuncionesPorModulo[j].FlagHabilitado.Equals(Enumerados.FlagHabilitado.T.ToString()))
                        {

                            String lsInput = String.Empty;
                            String lsIdElementoHtml = loLstConfiguracionBeanFuncionesPorModulo[j].Codigo.Trim() + "_" + loLstConfiguracionBeanFuncionesPorModulo[j].Tipo.Trim();

                            lsInput = (loLstConfiguracionBeanFuncionesPorModulo[j].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                                       ? "<input type=\"checkbox\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" id=\"" + lsIdElementoHtml + "\" name=\"" + lsIdElementoHtml + "\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\"  onclick=\"javascript:modificarValoresFuncion('" + lsIdElementoHtml + "');\" checked=\"checked\"  />"
                                       : "<input type=\"checkbox\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" id=\"" + lsIdElementoHtml + "\" name=\"" + lsIdElementoHtml + "\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\"  onclick=\"javascript:modificarValoresFuncion('" + lsIdElementoHtml + "');\" />";
                            loFuncionesConfiguracion.Append(lsInput);
                            loFuncionesConfiguracion.Append("<a class=\"cz-form-content-input-check-title\">" + loLstConfiguracionBeanFuncionesPorModulo[j].Descripcion.Trim() + "<a/>");
                            loFuncionesConfiguracion.Append("</br>");
                            loFuncionesConfiguracion.Append("</br>");
                        }
                    }
                    loFuncionesConfiguracion.Append("</div>");
                    loFuncionesConfiguracion.Append("</div>");
                    loFuncionesConfiguracion.Append("</div>");
                    loFuncionesConfiguracion.Append("</div>");
                }
            }
        }
        litFunciones.Text = loFuncionesConfiguracion.ToString();

    }

    private void subEscribirConfiguracionValores(List<ConfiguracionBean> poLstConfiguracionBean)
    {
        StringBuilder loConfiguracionValoresConfiguracion = new StringBuilder();
        List<ConfiguracionBean> loLstConfiguracionBeanValoresConfiguracion = new List<ConfiguracionBean>();
        loLstConfiguracionBeanValoresConfiguracion = this.subObtenerListaConfiguracionPorCodigo(poLstConfiguracionBean, Enumerados.CodigoConfiguracion.COF);

        if (loLstConfiguracionBeanValoresConfiguracion != null && loLstConfiguracionBeanValoresConfiguracion.Count > 0)
        {

            loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content cz-content-extended\" ");
            loConfiguracionValoresConfiguracion.Append(">");
            loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-subcontent\">");
            loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-subcontent-title\">");
            loConfiguracionValoresConfiguracion.Append("<p>Configuración</p>");
            loConfiguracionValoresConfiguracion.Append("</div>");
            loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-subcontent-content\">");

            for (int i = 0; i < loLstConfiguracionBeanValoresConfiguracion.Count; i++)
            {
                if (loLstConfiguracionBeanValoresConfiguracion[i].FlagHabilitado.Equals(Enumerados.FlagHabilitado.T.ToString()))
                {

                    String lsCodigoModulo = poLstConfiguracionBean.Find(obj => obj.Codigo.Trim().Equals(loLstConfiguracionBeanValoresConfiguracion[i].TipoPadre.Trim()) && obj.Tipo.Trim().Equals(Enumerados.CodigoConfiguracion.FUN.ToString())).TipoPadre.Trim();
                    String lsClaseIdentificadorFuncion = loLstConfiguracionBeanValoresConfiguracion[i].TipoPadre.Trim() + "_" + Enumerados.CodigoConfiguracion.FUN.ToString();
                    String lsClaseIdentificadorModulo = lsCodigoModulo + "_" + Enumerados.CodigoConfiguracion.MOD.ToString() + "_" + Enumerados.CodigoConfiguracion.FUN.ToString();
                    String lsClaseIndentificador = lsClaseIdentificadorFuncion + " " + lsClaseIdentificadorModulo;

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_TIEMPO_ENVIO_GPS))
                    {

                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_TIEMPO_ENVIO_GPS + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\"  class=\"requerid cz-form-content-input-text " + lsClaseIndentificador + "\" onkeypress=\"javascript:fc_PermiteNumeros();\" placeholder=\"Ingrese un número\" maxlength=\"2\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" />");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible\" >");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible-button\"></div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_TIEMPO_ENVIO_PULSO))
                    {

                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_TIEMPO_ENVIO_PULSO + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\"  class=\"requerid cz-form-content-input-text " + lsClaseIndentificador + "\" onkeypress=\"javascript:fc_PermiteNumeros();\" placeholder=\"Ingrese un número\" maxlength=\"2\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" />");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible\" >");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible-button\"></div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_ENVIO_CORREO_GEOCERCA))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                        String lsInput = String.Empty;
                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_ENVIO_CORREO_GEOCERCA + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();
                        lsInput = (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                                    ? "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" Checked />"
                                    : "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" />";
                        loConfiguracionValoresConfiguracion.Append(lsInput);
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_HORA_SINCRONIZACION))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_HORA_SINCRONIZACION + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\" placeholder=\"HH:MM\" maxlength=\"5\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" class=\"requerid cz-form-content-input-text cz-form-content-input-timer " + lsClaseIndentificador + "\" onblur=\"javascript:fc_ValidaHoraOnblur(this.id);\" />");
                        loConfiguracionValoresConfiguracion.Append("<div id=\"cz-form-time-flag\" class=\"cz-form-content-input-timer-visible\">");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-calendar-visible-button\">");
                        loConfiguracionValoresConfiguracion.Append("<img alt=\"<>\" id=\"imgHorSin\" name=\"imgHorSin\" class=\"form-input-date-image\" style=\"margin-top: 1px;padding: 4px;position: absolute;z-index: 2;\"");
                        loConfiguracionValoresConfiguracion.Append("src=\"../../images/icons/timer.png\" />");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_DISTANCIA_MINIMA))
                    {

                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_DISTANCIA_MINIMA + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\"  class=\"requerid cz-form-content-input-text " + lsClaseIndentificador + "\" onkeypress=\"javascript:fc_PermiteNumeros();\" placeholder=\"Ingrese un número\" maxlength=\"5\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" />");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible\" >");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible-button\"></div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_TIEMPO_NO_REFERENCIAL))
                    {

                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_TIEMPO_NO_REFERENCIAL + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\"  class=\"requerid cz-form-content-input-text " + lsClaseIndentificador + "\" onkeypress=\"javascript:fc_PermiteNumeros();\" placeholder=\"Ingrese un número\" maxlength=\"5\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" />");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible\" >");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible-button\"></div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_HORA_INICIO_CAPTURA))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");

                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_HORA_INICIO_CAPTURA + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\" placeholder=\"HH:MM\" maxlength=\"5\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" class=\"requerid cz-form-content-input-text cz-form-content-input-timer " + lsClaseIndentificador + "\" onblur=\"javascript:fc_ValidaHoraOnblur(this.id);\" />");
                        loConfiguracionValoresConfiguracion.Append("<div id=\"cz-form-time-flag\" class=\"cz-form-content-input-timer-visible\">");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-calendar-visible-button\">");
                        loConfiguracionValoresConfiguracion.Append("<img alt=\"<>\" id=\"imgHorIni\" name=\"imgHorIni\" class=\"form-input-date-image\" style=\"margin-top: 1px;padding: 4px;position: absolute;z-index: 2;\"");
                        loConfiguracionValoresConfiguracion.Append("src=\"../../images/icons/timer.png\" />");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_HORA_FIN_CAPTURA))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");

                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_HORA_FIN_CAPTURA + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\" placeholder=\"HH:MM\" maxlength=\"2\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" class=\"requerid cz-form-content-input-text cz-form-content-input-timer " + lsClaseIndentificador + "\" onblur=\"javascript:fc_ValidaHoraOnblur(this.id);\" />");
                        loConfiguracionValoresConfiguracion.Append("<div id=\"cz-form-time-flag\" class=\"cz-form-content-input-timer-visible\">");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-calendar-visible-button\">");
                        loConfiguracionValoresConfiguracion.Append("<img alt=\"<>\" id=\"imgHorFin\" name=\"imgHorFin\" class=\"form-input-date-image\" style=\"margin-top: 1px;padding: 4px;position: absolute;z-index: 2;\"");
                        loConfiguracionValoresConfiguracion.Append("src=\"../../images/icons/timer.png\" />");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_MODO_AHORRO))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                        String lsInput = String.Empty;
                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_MODO_AHORRO + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();
                        lsInput = (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                                    ? "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" Checked />"
                                    : "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" />";
                        loConfiguracionValoresConfiguracion.Append(lsInput);
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_USAR_SENSOR_ACTIVIDAD))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                        String lsInput = String.Empty;
                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_USAR_SENSOR_ACTIVIDAD + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();
                        lsInput = (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                                    ? "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" Checked />"
                                    : "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" />";
                        loConfiguracionValoresConfiguracion.Append(lsInput);
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_USAR_GOOGLE_GEOCODING))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                        String lsInput = String.Empty;
                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_USAR_GOOGLE_GEOCODING + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();
                        lsInput = (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                                    ? "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" Checked />"
                                    : "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" />";
                        loConfiguracionValoresConfiguracion.Append(lsInput);
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_FORZAR_ENCENDIDO_DATOS))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                        String lsInput = String.Empty;
                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_FORZAR_ENCENDIDO_DATOS + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();
                        lsInput = (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                                    ? "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" Checked />"
                                    : "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" />";
                        loConfiguracionValoresConfiguracion.Append(lsInput);
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_FORZAR_ENCENDIDO_WIFI))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                        String lsInput = String.Empty;
                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_FORZAR_ENCENDIDO_WIFI + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();
                        lsInput = (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                                    ? "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" Checked />"
                                    : "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" />";
                        loConfiguracionValoresConfiguracion.Append(lsInput);
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_PRECISION_MINIMA_MAPA))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_PRECISION_MINIMA_MAPA + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\"  class=\"requerid cz-form-content-input-text " + lsClaseIndentificador + "\" onkeypress=\"javascript:fc_PermiteNumeros();\" placeholder=\"Ingrese un número\" maxlength=\"5\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" />");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible\" >");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible-button\"></div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_NOTIFICAR_GPS_DESACTIVADO))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_NOTIFICAR_GPS_DESACTIVADO + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\"  class=\"requerid cz-form-content-input-text " + lsClaseIndentificador + "\" onkeypress=\"javascript:fc_PermiteNumeros();\" placeholder=\"Ingrese un número\" maxlength=\"3\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" />");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible\" >");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible-button\"></div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_DIAS_FUNCIONAMIENTO))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                        String lsInput;
                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_DIAS_FUNCIONAMIENTO + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();
                        Int32 diasInt = Convert.ToInt32(loLstConfiguracionBeanValoresConfiguracion[i].Valor, 2);
                        lsInput = obtenerDias(diasInt, lsClaseIndentificador, lsIdElementoHtml);
                        loConfiguracionValoresConfiguracion.Append(lsInput);
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_PROVEEDOR_MAPS_SELECCIONADO))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input\">");

                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_PROVEEDOR_MAPS_SELECCIONADO + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();

                        String lsInput = String.Empty;
                        StringBuilder lsElementoHtml = new StringBuilder();
                        lsElementoHtml.Append("<select ");
                        lsElementoHtml.Append("id = \"");
                        lsElementoHtml.Append(lsIdElementoHtml);
                        lsElementoHtml.Append("\">");

                        foreach (Constantes.EnumProveedorMapas en in Enum.GetValues(typeof(Constantes.EnumProveedorMapas)))
                        {
                            lsElementoHtml.Append("<option ");
                            lsElementoHtml.Append("value=\"");
                            lsElementoHtml.Append((int)en);
                            lsElementoHtml.Append("\" ");
                            lsElementoHtml.Append("id=\"");
                            lsElementoHtml.Append(lsIdElementoHtml);
                            lsElementoHtml.Append("\" ");
                            lsElementoHtml.Append("class=\"cz-form-content-input ");
                            lsElementoHtml.Append(lsClaseIndentificador);
                            lsElementoHtml.Append("\" name=\"selProveedorMaps\" ");
                            if (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(((int)en).ToString()))
                            {
                                lsElementoHtml.Append("selected=\"true\"");
                            }
                            lsElementoHtml.Append(">");
                            lsElementoHtml.Append(en.ToString());
                            lsElementoHtml.Append("</option>");
                        }
                        lsElementoHtml.Append("<select>");
                        loConfiguracionValoresConfiguracion.Append(lsElementoHtml.ToString());
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_PROVEEDOR_REVERSE_GEOCODING_SELECCIONADO))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input\">");

                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_PROVEEDOR_REVERSE_GEOCODING_SELECCIONADO + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();

                        String lsInput = String.Empty;
                        StringBuilder lsElementoHtml = new StringBuilder();
                        lsElementoHtml.Append("<select ");
                        lsElementoHtml.Append("id = \"");
                        lsElementoHtml.Append(lsIdElementoHtml);
                        lsElementoHtml.Append("\">");

                        foreach (Constantes.EnumProveedorReverseGeocoding en in Enum.GetValues(typeof(Constantes.EnumProveedorReverseGeocoding)))
                        {
                            lsElementoHtml.Append("<option ");
                            lsElementoHtml.Append("value=\"");
                            lsElementoHtml.Append((int)en);
                            lsElementoHtml.Append("\" ");
                            lsElementoHtml.Append("id=\"");
                            lsElementoHtml.Append(lsIdElementoHtml);
                            lsElementoHtml.Append("\" ");
                            lsElementoHtml.Append("class=\"cz-form-content-input ");
                            lsElementoHtml.Append(lsClaseIndentificador);
                            lsElementoHtml.Append("\" name=\"selProveedorRevGeo\" ");
                            if (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(((int)en).ToString()))
                            {
                                lsElementoHtml.Append("selected=\"true\"");
                            }
                            lsElementoHtml.Append(">");
                            lsElementoHtml.Append(en.ToString());
                            lsElementoHtml.Append("</option>");
                        }
                        lsElementoHtml.Append("<select>");
                        loConfiguracionValoresConfiguracion.Append(lsElementoHtml.ToString());
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }


                    if (loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_VELOCIDAD_MAXIMA_PARA_DESCARTAR_POSICION))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<input type=\"text\" id=\"" + Constantes.CodigoValoresConfiguracion.CFG_VELOCIDAD_MAXIMA_PARA_DESCARTAR_POSICION + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo + "\"  class=\"requerid cz-form-content-input-text " + lsClaseIndentificador + "\" onkeypress=\"javascript:fc_PermiteNumeros();\" placeholder=\"Ingrese un número\" maxlength=\"2\" value=\"" + loLstConfiguracionBeanValoresConfiguracion[i].Valor.Trim() + "\" />");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible\" >");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-text-visible-button\"></div>");
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }

                    if (ConfigurationManager.AppSettings["NSERVICES_INSTANCIA_PADRE"] != null && !ConfigurationManager.AppSettings["NSERVICES_INSTANCIA_PADRE"].Equals("") && loLstConfiguracionBeanValoresConfiguracion[i].Codigo.Equals(Constantes.CodigoValoresConfiguracion.CFG_NSERVICES_EMBEBIDO))
                    {
                        loConfiguracionValoresConfiguracion.Append("<p>" + loLstConfiguracionBeanValoresConfiguracion[i].Descripcion.Trim() + "</p>");
                        loConfiguracionValoresConfiguracion.Append("<div class=\"cz-form-content-input-check\">");

                        String lsIdElementoHtml = Constantes.CodigoValoresConfiguracion.CFG_NSERVICES_EMBEBIDO + "_" + loLstConfiguracionBeanValoresConfiguracion[i].Tipo.Trim();
                        var lsInput = (loLstConfiguracionBeanValoresConfiguracion[i].Valor.Equals(Enumerados.FlagHabilitado.T.ToString()))
                            ? "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.T.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" Checked />"
                            : "<input type=\"checkbox\" id=\"" + lsIdElementoHtml + "\" class=\"cz-form-content-input-check " + lsClaseIndentificador + "\" name=\"chkConPosicion\" value=\"" + Enumerados.FlagHabilitado.F.ToString() + "\" onclick=\"javascript:modifiacarValorChecked('" + lsIdElementoHtml + "');\" />";
                        loConfiguracionValoresConfiguracion.Append(lsInput);
                        loConfiguracionValoresConfiguracion.Append("</div>");
                    }
                }
            }

            loConfiguracionValoresConfiguracion.Append("</div>");
            loConfiguracionValoresConfiguracion.Append("</div>");
            loConfiguracionValoresConfiguracion.Append("</div>");
        }


        litValoresConfiguracion.Text = loConfiguracionValoresConfiguracion.ToString();
    }

    private String obtenerDias(Int32 diasInt, String psClaseIndentificador, String psIdElementoHtml)
    {
        StringBuilder lsInputDias = new StringBuilder();
        lsInputDias.Append("<table style='width: 100%;'><tr>");
        foreach (int diaSemana in Enum.GetValues(typeof(Enumerados.DiaSemana)))
        {
            int diaSemanaInverso = diaSemana * -1;
            lsInputDias.Append("<td>").Append(Enum.GetName(typeof(Enumerados.DiaSemana), diaSemana));
            lsInputDias.Append("</td>");
        }
        lsInputDias.Append("</tr><tr>");
        foreach (int diaSemana in Enum.GetValues(typeof(Enumerados.DiaSemana)))
        {
            string marcado = "";
            int diaSemanaInverso = diaSemana * -1;
            lsInputDias.Append("<td><input type=\"checkbox\" tipo=\"" + psIdElementoHtml + "\" id=\"" + psIdElementoHtml + "_" + diaSemanaInverso + "\" class=\"cz-form-content-input-check " + psClaseIndentificador + "\" name=\"chkConPosicion\" value=\"");
            if ((diasInt & diaSemanaInverso) > 0)
            {
                lsInputDias.Append(Enumerados.FlagHabilitado.T.ToString());
                marcado = "Checked";
            }
            else
            {
                lsInputDias.Append(Enumerados.FlagHabilitado.F.ToString());
            }
            lsInputDias.Append("\" onclick=\"javascript:modifiacarValorChecked('" + psIdElementoHtml + "_" + diaSemanaInverso + "');\" ");
            lsInputDias.Append(marcado);
            lsInputDias.Append(" /></td>");
        }
        lsInputDias.Append("</tr></table>");
        return lsInputDias.ToString();
    }

    private void subEscribirManuales(List<ManualBean> poLstManuales)
    {
        StringBuilder loBuilder = new StringBuilder();
        string lsRutaManual = ConfigurationManager.AppSettings["urlDocs"] + "/" + Model.bean.ManagerConfiguracion.Version + "/";
        string lsManualFinal = ".pdf";
        loBuilder.Append("<ul>");

        ManualBean loManual = poLstManuales[0];
        //foreach (ManualBean loManual in poLstManuales)
        //{
        loBuilder.Append("<li><a href=\"" + lsRutaManual + loManual.Url + lsManualFinal + "\" >" + loManual.Descripcion + "</a></li>");
        //}
        loBuilder.Append("</ul>");
        litManual.Text = loBuilder.ToString();
    }

    private List<ConfiguracionBean> subObtenerListaConfiguracionPorCodigo(List<ConfiguracionBean> poLstConfiguracionBean, Enumerados.CodigoConfiguracion peCodigoConfiguracion)
    {
        List<ConfiguracionBean> loLstConfiguracionBean = new List<ConfiguracionBean>();
        loLstConfiguracionBean = poLstConfiguracionBean.FindAll(obj => obj.Tipo.Equals(peCodigoConfiguracion.ToString()));
        return loLstConfiguracionBean;
    }


    //[WebMethod(EnableSession = true)]
    [WebMethod]
    public static String guardarConfig(String json)
    {
        try
        {
            JavaScriptSerializer loJssSerializador = new JavaScriptSerializer();
            IDictionary<String, String> loLstDiccionarioConfiguracion = new Dictionary<String, String>();
            loLstDiccionarioConfiguracion = loJssSerializador.Deserialize<IDictionary<String, String>>(json);

            foreach (KeyValuePair<String, String> lsConfiguracionValor in loLstDiccionarioConfiguracion)
            {
                String lsIdConfiguracion = lsConfiguracionValor.Key;
                String[] laConfiguracion = lsIdConfiguracion.Split('_');
                if (laConfiguracion.Length == 2)
                {
                    ConfiguracionController.subInsertarDatosConfiguracion(laConfiguracion[1], laConfiguracion[0], lsConfiguracionValor.Value.ToString());
                }
            }
            Controller.GeneralController.subInicializarConfiguracion();
            return "OK";
        }
        catch (Exception ex)
        {
            throw new Exception("ERROR: " + ex.Message);
        }

    }

}