using business.functions;
using Controller;
using Model;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using Tools;

namespace View.Mantenimiento.Cliente
{
    public partial class ClienteNew : System.Web.UI.Page
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
                CargaCombo();
                divId.Visible = false;
                if (!IsPostBack)
                {
                    string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();
                    Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);
                    if (dataJSON != null)
                    {
                        String Codigo = dataJSON["codigo"].ToString();
                        Session["lstClienteInstalacion"] = null;
                        ClienteBean obj = ClienteController.Get(new ClienteBean { CLI_PK = int.Parse(dataJSON["codigo"].ToString()) });
                        myModalLabel.InnerText = "Editar " + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_CLIENTE);
                        List<ClienteInstalacionBean> nopaginate = new List<ClienteInstalacionBean>();
                        nopaginate = ClienteController.getAllInstalacion(Codigo);
                        if (obj != null)
                        {
                            hdIdCliente.Value = (obj.CLI_PK).ToString();
                            MtxtIdCliente.Value = (obj.CLI_PK).ToString();
                            MtxtRazonSocial.Value = obj.Razon_Social;
                            MtxtRUC.Value = obj.RUC;
                            MtxtDireccion.Value = obj.Direccion;
                            MtxtReferencia.Value = obj.Referencia;
                            MddlIdNegocio.SelectedValue = obj.IdNegocio.ToString();
                            MddlIdRubro.SelectedValue = obj.IdRubro.ToString();
                            MddlIdRegion.SelectedValue = obj.IdRegion.ToString();
                            MddlIdOrganizacionVenta.SelectedValue = obj.IdOrganizacionVenta.ToString();
                            MddlIdCanal.SelectedValue = obj.IdCanal.ToString();
                            MddlIdTipo.SelectedValue = obj.IdTipo.ToString();
                            //litGrillaInstalacion.Text = DibujaTabla(new List<ClienteInstalacionBean>());
                            litGrillaInstalacion.Text = DibujaTabla(nopaginate);
                            //MddlIdZona.SelectedValue = obj.IdZona.ToString();
                            divId.Visible = true;
                        }
                    }
                    else
                    {
                        myModalLabel.InnerText = "Crear " + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_CLIENTE);
                        litGrillaInstalacion.Text = DibujaTabla(new List<ClienteInstalacionBean>());
                    }
                }
            }
        }

        private void CargaCombo()
        {
            try
            {
                var zona = ZonaController.GetAll(new ZonaBean { Flag = "T" });
                Utility.ComboNuevo(MddlIdZona, zona, "IdZona", "Nombre");
                var negocio = NegocioController.GetAll(new NegocioBean { Nombre = "" });
                Utility.ComboNuevo(MddlIdNegocio, negocio, "IdNegocio", "Nombre");
                var usurio = UsuarioController.GetAll(new UsuarioBean {FlgHabilitado="T" });
                Utility.ComboNuevo(MddlIdUsuario, usurio, "IdUsuario", "Nombres");

                var rubro = GeneralTipoController.GetAll(new GeneralTipoBean { IdTipo = 1 });
                Utility.ComboNuevo(MddlIdRubro, rubro, "IdGeneral", "Nombre");
                var region = GeneralTipoController.GetAll(new GeneralTipoBean { IdTipo = 2 });
                Utility.ComboNuevo(MddlIdRegion, region, "IdGeneral", "Nombre");
                var organVenta = GeneralTipoController.GetAll(new GeneralTipoBean { IdTipo = 3 });
                Utility.ComboNuevo(MddlIdOrganizacionVenta, organVenta, "IdGeneral", "Nombre");
                var canal = GeneralTipoController.GetAll(new GeneralTipoBean { IdTipo = 4 });
                Utility.ComboNuevo(MddlIdCanal, canal, "IdGeneral", "Nombre");

            }
            catch (Exception ex)
            {
                LogHelper.LogException(ex, "Error :" + this);
                throw new Exception("ERROR: " + ex.Message);
            }
        }

        public String DibujaTabla(List<ClienteInstalacionBean> lst)
        {
            String GenTabla = "";
            GenTabla = "<table class='grilla table' id='Table1' style='width: 100%;'>" +
                           "<thead>" +
                            "   <tr>" +
                             "      <th scope='col'>Id</th>" +
                              "     <th scope='col'>Cod. Instalación</th>" +
                              "     <th scope='col'>Descripcion</th>" +
                              "     <th scope='col'>Dirección</th>" +
                              "     <th scope='col'>Referencia</th>" +
            "     <th scope='col'>Zona</th>" +
            "     <th scope='col'>Usuario</th>";
            GenTabla += "     <th scope='col'><i class='fas fa-pencil-alt'></i></th>";
            GenTabla += "     <th scope='col'><i class='fa fa-trash-alt'></i></th>";
            GenTabla += "</tr>";
            GenTabla += "</thead>";
            GenTabla += "<tbody>";
            GenTabla += fndibujaTr(lst);

            GenTabla += "</tbody>" + "</table>";
            return GenTabla;
        }
        public static String fndibujaTr(List<ClienteInstalacionBean> list)
        {
            String dibutaTr = "";
            int row = 0, row2 = 0;
            foreach (var item2 in list)
            {
                if (item2.Habilitado == "T")
                {
                    dibutaTr += "<tr " + (row2 % 2 == 0 ? "class='file'" : "") + ">" +
                "<td align='center'>" + row2++ + "</td>" +
                 "<td align='center'>" + item2.CodInstalacion + "</td>" +
                "<td align='center'>" + item2.Descripcion + "</td>" +
                "<td align='center'>" + item2.Direccion + "</td>" +
                "<td align='center'>" + item2.Referencia + "</td>" +
                "<td align='center'>" + item2.Zona + "</td>" +
                "<td align='center'>" + item2.Usuario + "</td>" +
                "<td  align='center' style='width:5%;'>" +
                    " <button type='button' class='btn nuevo editItemReg2 movil' title='Editar' cod='" + row + "'> " +
                    " <i class='fas fa-pencil-alt'></i> " +
                    "  </button>" +
                "  </td>" +
                "<td align='center' style='width:5%;'>" +
                "  <button type='button' class='btn nuevo delItemRegCtr movil' title='Borrar' cod='" + row + "'>" +
                "   <i class='fa fa-trash-alt'></i>" +
                "     </button>" +
            " </td>" +
            "</tr>";
                }

                row++;
            }

            HttpContext.Current.Session["lstClienteInstalacion"] = list;
            return dibutaTr;
        }
        [WebMethod]
        public static String AgregarInstalacion(string index, string IdCliente, string codInstalacion, string Descripcion, string Direccion,
            string Referencia, string Habilitado, string idZona, string IdUsuario, string nombreZona, string nombreUsuario)
        {
            var item = new ClienteInstalacionBean
            {
                IDCliente = IdCliente,
                CodInstalacion = codInstalacion,
                Descripcion = Descripcion,
                Direccion = Direccion,
                Referencia = Referencia,
                Habilitado = Habilitado,
                IDZona = idZona,
                IDUsuario = IdUsuario,
                Zona = nombreZona,
                Usuario = nombreUsuario
            };
            var list = (List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"];
            item.Index = (list.Count).ToString();
            if (list == null)
            {
                list = new List<ClienteInstalacionBean>();
                list.Add(item);
            }
            else
            {
                if (index == "")
                {
                    list.Add(item);
                }
                else
                {
                    list[int.Parse(index)-1].IDCliente = IdCliente;
                    list[int.Parse(index)-1].Descripcion = Descripcion;
                    list[int.Parse(index)-1].IDUsuario = IdUsuario;
                    list[int.Parse(index)-1].CodInstalacion = codInstalacion;
                    list[int.Parse(index)-1].IDZona = idZona;
                    list[int.Parse(index)-1].Descripcion = Descripcion;
                    list[int.Parse(index)-1].Direccion = Direccion;
                    list[int.Parse(index)-1].Referencia = Referencia;
                    list[int.Parse(index)-1].Habilitado = "T";
                    list[int.Parse(index) - 1].Zona = nombreZona;
                    list[int.Parse(index) - 1].Usuario = nombreUsuario;
                }
            }
            String dibutaTr = "";
            dibutaTr = fndibujaTr(list);
            HttpContext.Current.Session["lstClienteInstalacion"] = list;
            return dibutaTr;
        }


        [WebMethod]
        public static ClienteInstalacionBean EditarInstalacion(string Codigo, string Index)
        {
            ClienteInstalacionBean obj = ((List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"])[int.Parse(Index)];
            return obj;
        }

        [WebMethod]
        public static String EliminarInstalacion(string index)
        {
            List<ClienteInstalacionBean> list = (List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"];
            ClienteInstalacionBean obj = (list)[int.Parse(index)];
            obj.Habilitado = "F";
            String dibutaTr = "";
            if (obj.IDClienteInstalacion == "" || obj.IDClienteInstalacion == "0")
            {
                list.RemoveAt(int.Parse(index));
            }
            HttpContext.Current.Session["lstClienteInstalacion"] = list;
            dibutaTr = fndibujaTr(list);
            return dibutaTr;
        }
    }
}