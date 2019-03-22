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
                        nopaginate = ClienteController.getAllInstalacion(Codigo, "-1","");
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
                var codigo = HttpContext.Current.Session["lgn_id"].ToString();
                var negocio = NegocioController.GetAll(new NegocioBean { Nombre = "" }, codigo);
                Utility.ComboNuevo(MddlIdNegocio, negocio, "IdNegocio", "Nombre");


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
            "     <th scope='col'>Vendedor</th>";
            GenTabla += "     <th scope='col'><i class='fas fa-pencil-alt'></i></th>";
            GenTabla += "     <th scope='col'><i id='itemEdit' class='fa fa-trash-alt'></i></th>";
            GenTabla += "</tr>";
            GenTabla += "</thead>";
            GenTabla += "<tbody>";
            GenTabla += fndibujaTr(lst, "T");

            GenTabla += "</tbody>" + "</table>";
            return GenTabla;
        }
        public static String fndibujaTr(List<ClienteInstalacionBean> list, String habilitado)
        {
            String dibutaTr = "";
            int row = 0, row2 = 0;
            foreach (var item2 in list)
            {
                if (habilitado == "T")
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
                        " <button type='button' class='btn nuevo editItemReg2 movil' title='Editar' cod='" + item2.Index + "'> " +
                        " <i class='fas fa-pencil-alt'></i> " +
                        "  </button>" +
                    "  </td>" +
                    "<td align='center' style='width:5%;'>" +
                    "  <button type='button' class='btn nuevo delItemRegCtr movil' title='Borrar' cod='" + item2.Index + "'>" +
                    "   <i class='fa fa-trash-alt'></i>" +
                    "     </button>" +
                " </td>" +
                "</tr>";
                    }
                }
                else
                {
                    if (item2.Habilitado == "F")
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
                        " <button type='button' class='btn nuevo editItemReg2 movil' title='Editar' cod='" + item2.Index + "'> " +
                        " <i class='fas fa-pencil-alt'></i> " +
                        "  </button>" +
                    "  </td>" +
                    "<td align='center' style='width:5%;'>" +
                    "  <button type='button' class='btn nuevo restaurarInstalacion movil' title='Restaurar' cod='" + item2.Index + "'>" +
                    "   <i class='fa fa-redo-alt'></i>" +
                    "     </button>" +
                " </td>" +
                "</tr>";
                    }
                }

                row++;
            }

            HttpContext.Current.Session["lstClienteInstalacion"] = list;
            return dibutaTr;
        }
        [WebMethod]
        public static String listarInstalaciones(String eliminado)
        {
            var list = (List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"];
            string dibutaTr = fndibujaTr(list, eliminado);
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
            item.Index = (list.Count + 1).ToString();
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
                    foreach (ClienteInstalacionBean obj in list)
                    {
                        if (index == obj.Index)
                        {
                            obj.IDCliente = IdCliente;
                            obj.Descripcion = Descripcion;
                            obj.IDUsuario = IdUsuario;
                            obj.CodInstalacion = codInstalacion;
                            obj.IDZona = idZona;
                            obj.Descripcion = Descripcion;
                            obj.Direccion = Direccion;
                            obj.Referencia = Referencia;
                            obj.Habilitado = Habilitado;
                            obj.Zona = nombreZona;
                            obj.Usuario = nombreUsuario;
                        }
                    }
                }
            }
            String dibutaTr = "";
            dibutaTr = fndibujaTr(list, Habilitado);
            HttpContext.Current.Session["lstClienteInstalacion"] = list;
            return dibutaTr;
        }


        [WebMethod]
        public static ClienteInstalacionBean EditarInstalacion(string Codigo, string Index)
        {
            List<ClienteInstalacionBean> objList = ((List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"]);
            ClienteInstalacionBean obj = null;
            foreach (ClienteInstalacionBean obj1 in objList)
            {
                if (Index == obj1.Index)
                {
                    obj = obj1;
                    break;
                }
            }
            return obj;
        }

        [WebMethod]
        public static String EliminarInstalacion(string index)
        {
            List<ClienteInstalacionBean> list = (List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"];
            String dibutaTr = "";
            int contador = 0;
            foreach (ClienteInstalacionBean obj in list)
            {
                if (obj.Index == index)
                {
                    obj.Habilitado = "F";
                    if (string.IsNullOrEmpty(obj.IDClienteInstalacion) || obj.IDClienteInstalacion == "0")
                    {
                        list.RemoveAt(contador);
                    }
                    break;
                }
                contador++;
            }
            HttpContext.Current.Session["lstClienteInstalacion"] = list;
            dibutaTr = fndibujaTr(list, "T");
            return dibutaTr;
        }

        [WebMethod]
        public static String RestaurarInstalacion(String codigo, string index)
        {
            List<ClienteInstalacionBean> list = (List<ClienteInstalacionBean>)HttpContext.Current.Session["lstClienteInstalacion"];
            foreach (ClienteInstalacionBean obj in list)
            {
                if (index == obj.Index)
                {
                    obj.Habilitado = "T"; break;
                }
            }
            String dibutaTr = "";
            //if (obj.IDClienteInstalacion == "" || obj.IDClienteInstalacion == "0")
            //{
            //    list.RemoveAt(int.Parse(index));
            //}
            HttpContext.Current.Session["lstClienteInstalacion"] = list;
            dibutaTr = fndibujaTr(list, "F");
            return dibutaTr;
        }
    }
}