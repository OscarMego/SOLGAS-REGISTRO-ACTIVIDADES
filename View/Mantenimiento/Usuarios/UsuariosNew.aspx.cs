﻿using business.functions;
using Controller;
using Model;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI;
using Tools;

public partial class Mantenimiento_Usuarios_UsuariosNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["lgn_id"] == null)
        {
            Session.Clear();
            string myScript = ConfigurationManager.AppSettings["URL_LOGIN"];
            String lsScript = "parent.document.location.href = '" + myScript + "/default.aspx?acc=SES';";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
        }
        else
        {
            CargaCombos();
            if (!IsPostBack)
            {
                string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                if (dataJSON != null)
                {

                    UsuarioBean obj = UsuarioController.Get(new UsuarioBean { IdUsuario = int.Parse(dataJSON["codigo"].ToString()), Codigo = dataJSON["codigo"].ToString() });
                    myModalLabel.InnerText = "Editar " + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_USUARIO);

                    MtxtIdUsuario.Value = obj.IdUsuario.ToString();
                    MtxtCodigo.Value = obj.Codigo;
                    MtxtNombres.Value = obj.Nombres;
                    MtxtLoginUsuario.Value = obj.LoginUsuario;
                    MtxtEmail.Value = obj.Email;
                    MtxtClave.Value = obj.clave;
                    hidClave.Value = obj.clave;
                    MddlIdPerfil.SelectedValue = obj.IdPerfil.ToString();
                    MddlIdCanal.SelectedValue = obj.IdCanal.ToString();
                    if (obj.FlgActiveDirectory.Equals("T"))
                    {
                        chkmodificable.Checked = true;
                    }
                    else
                    {
                        chkmodificable.Checked = false;
                    }
                    MtxtCodigo.Disabled = true;

                }
                else
                {
                    myModalLabel.InnerText = "Crear " + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_USUARIO);
                }
            }
        }
    }

    private void CargaCombos()
    {
        try
        {
            var perfil = PerfilController.GetAll(new PerfilBean { FlgHabilitado = "T" });
            Utility.ComboNuevo(MddlIdPerfil, perfil, "IdPerfil", "Descripcion");
            
            var canal = NegocioController.GetAll(new NegocioBean { Nombre = "" });
            Utility.ComboNuevo(MddlIdCanal, canal, "IdNegocio", "Nombre");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }

}