using business.functions;
using Controller;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;

public partial class Mantenimiento_SubTipoActividad_SubTipoActividadNew : System.Web.UI.Page
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
            Session["SesTipoControl"] = null;
            Session["SesGrupo"] = null;
            Session["DetalleSubTipoActividad"] = null;
            Session["lstPerfiles"] = null;

            CargaComboTipoControl();
            CargaComboGeneral();

            Session["lstPerfiles"] = PerfilController.GetAll(new PerfilBean { FlgHabilitado = "T" });

            if (!IsPostBack)
            {
                string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

                Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

                if (dataJSON != null)
                {
                    String Codigo = dataJSON["codigo"].ToString();

                    SubTipoActividadBean obj = SubTipoActividadController.Get(
                       new SubTipoActividadBean
                       {
                           IDSubTipoActividad = dataJSON["codigo"].ToString(),
                           Codigo = "",
                           Descripcion = ""
                       });
                    myModalLabel.InnerText = "Editar Sub Tipo Actividad"; //+ Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_CONFOPORTUNIDADES);

                    if (obj != null)
                    {
                        MtxtIdConfOp.Value = (obj.IDSubTipoActividad).ToString();
                        MtxtCodigo.Value = obj.Codigo;
                        MtxtDescripcion.Value = obj.Descripcion;
                        MddlTipoActividad.SelectedValue = obj.idtipoactividad.ToString();
                        hdIdSubTipoActividad.Value = obj.IdSubTipoActividadPredecesora.ToString();
                        MtxtTiempoEtapa.Value = obj.TiempoEtapa.ToString();
                        MtxtCodigo.Disabled = true;

                    }

                    //MtxtEtapaPredecesora.Value = ObtenerEtapaPredecesora(MddlTipoActividad.SelectedValue).Descripcion;

                    var item = new SubTipoActividadBean
                    {
                        IDSubTipoActividad = Codigo
                    };

                    List<SubTipoActividadDetBean> nopaginate = SubTipoActividadController.GetAllControl(item);

                    foreach (var hijos in nopaginate.Where(x => x.IdSubTipoActividadDetPadre != "" && x.CodigoGeneral != "").ToList())
                    {
                        //hijos.IdConfigOportunidadDetPadre;
                        var idx = nopaginate.FindIndex(x => x.IdSubTipoActividadDetalle == hijos.IdSubTipoActividadDetPadre);
                        hijos.IdSubTipoActividadDetPadre = idx.ToString();
                    }
                    HttpContext.Current.Session["DetallesEtapa"] = nopaginate;

                    litGrillaEtapa.Text = DibujaTabla(nopaginate);



                    //grdMant.DataSource = nopaginate;
                    //grdMant.DataBind();
                    //grdMant.HeaderRow.TableSection = TableRowSection.TableHeader;

                }
                else
                {
                    litGrillaEtapa.Text = DibujaTabla(new List<SubTipoActividadDetBean>());
                    //grdMant.DataSource = new List<EtapaBean> { new EtapaBean()};
                    //grdMant.DataBind();
                    //grdMant.HeaderRow.TableSection = TableRowSection.TableHeader;


                    myModalLabel.InnerText = "Crear Sub Tipo Actividad";//+ Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_CONFOPORTUNIDADES);
                }
            }
        }
    }

    public String DibujaTabla(List<SubTipoActividadDetBean> lst)
    {
        String GenTabla = "";
        GenTabla = "<table class='grilla table' id='Table1' style='width: 100%;'>" +
                       "<thead>" +
                        "   <tr>" +
                         "      <th scope='col'>Id</th>" +
                          "     <th scope='col'>Etiqueta</th>" +
                          "     <th scope='col'>Tipo Control</th>" +
                          "     <th scope='col'>Max. Caracteres</th>" +
                          "     <th scope='col'>Grupo</th>" +
        "     <th scope='col'>Obligatorio</th>" +
        "     <th scope='col'>Control Padre</th>";
        GenTabla += "     <th scope='col'><i class='fas fa-pencil-alt'></i></th>";
        GenTabla += "     <th scope='col'><i class='fa fa-trash-alt'></i></th>";
        GenTabla += "</tr>";
        GenTabla += "</thead>";
        GenTabla += "<tbody>";
        GenTabla += fndibujaTr(lst);
        //foreach (var eRepor in lst)
        //{
        //    GenTabla += "<tr " + (row++ % 2 == 0 ? "" : "class='file'") + ">" +
        //                "<td align='center'  >" + row + "</td>" +
        //                "<td align='center'  >" + eRepor.Etiqueta + "</td>" +
        //                "<td align='center'  >" + eRepor.TipoControlDescrip + "</td>" +
        //                "<td align='center'  >" + eRepor.MaxCaracter + "</td>" +
        //                "<td align='center'  >" + eRepor.Grupo + "</td>"+
        //    "<td align='center'  >" + eRepor.FlgObligatorioDescrip + "</td>"+
        //    "<td align='center'  >" + eRepor.FlgModificableDescrip + "</td>";
        //    //Cerrar Oportunidad
        //    GenTabla += "<td ><button type='button' class='btn nuevo editItemReg2'  title='Editar' ";
        //    GenTabla += " cod='" + eRepor.Id2 + "' > ";
        //    GenTabla += " <i class='fas fa-pencil-alt'></i> ";
        //    GenTabla += "</button></td>";

        //    GenTabla += "<td ><button type='button' class='btn nuevo delItemRegCtr' title='Borrar'";
        //    GenTabla += " cod='" + eRepor.Id2 + "' > ";
        //    GenTabla += " <i class='fa fa-trash-alt'></i> ";
        //    GenTabla += "</button></td>";

        //    GenTabla += "</tr>";

        //}

        GenTabla += "</tbody>" + "</table>";
        return GenTabla;
    }


    private void CargaComboTipoControl()
    {
        try
        {
            var tipoControl = EtapaController.ObtenerTipoControl(new TipoControlBean { FlgHabilitado = "T" });
            //tipoControl.Remove(tipoControl.Find(x=> x.Codigo=="9"));
            HttpContext.Current.Session["SesTipoControl"] = tipoControl;
            Utility.ComboNuevo(MddlTipoControl, tipoControl, "Codigo", "Nombre");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }

    private void CargaComboGeneral()
    {
        try
        {
            var general = EtapaController.ObtenerGrupo(new GrupoBean { FlgHabilitado = "T" });
            HttpContext.Current.Session["SesGrupo"] = general;
            Utility.ComboNuevo(MddlGrupo, general, "IDGrupo", "Nombre");

            var tipoactividad = TipoActividadController.GetAll(new TipoActividadBean());
            Utility.ComboBuscar(MddlTipoActividad, tipoactividad, "id", "nombre");

            //var subtipoactividad = SubTipoActividadController.GetAll("0");
            //Utility.ComboSeleccionar(MddlIdEtapaPredecesora, subtipoactividad, "IDSubTipoActividad", "Descripcion");
        }
        catch (Exception ex)
        {
            LogHelper.LogException(ex, "Error :" + this);
            throw new Exception("ERROR: " + ex.Message);
        }
    }
    [WebMethod]
    public static List<ListItem> ComboMultPerfil()
    {
        List<ListItem> lstComboBean = PerfilController.GetAll(new PerfilBean { FlgHabilitado = "T" }).Select(x => new ListItem()
        {
            Text = x.Descripcion,
            Value = x.IdPerfil.ToString(),
            Selected = true,
        }).ToList();
        return lstComboBean;
    }

    [WebMethod]
    public static String AgregarDetalleEtapa(string index, string idConfOpDe, string idConfOp, string Etiqueta, string IdTipoControl, string CodigoGrupo, string MaxCaracter,
        string Modificable, string Obligatorio, String Perfiles, String IControlPadre)
    {
        if (IControlPadre == null)
        {
            IControlPadre = "";
        }
        var lstTipoControl = (List<TipoControlBean>)HttpContext.Current.Session["SesTipoControl"];
        var lstGrupo = (List<GrupoBean>)HttpContext.Current.Session["SesGrupo"];
        var lstPerfiles = (List<PerfilBean>)HttpContext.Current.Session["lstPerfiles"];

        var NombreTipoControl = lstTipoControl.Find(x => x.Codigo.ToString() == IdTipoControl).Nombre;
        var idtctr = lstTipoControl.Find(x => x.Codigo.ToString() == IdTipoControl).Id.ToString();
        String NombreGeneral = "";
        if (CodigoGrupo != "")
        {
            NombreGeneral = lstGrupo.Find(x => x.IDGrupo == Int32.Parse(CodigoGrupo)).Nombre;
        }

        String PerfilesDesc = "";
        foreach (var ePeri in Perfiles.Split(','))
        {
            if (ePeri != "")
            {
                PerfilesDesc = PerfilesDesc + lstPerfiles.Find(x => x.IdPerfil.ToString() == ePeri).Descripcion + ",";
            }
        }


        var item = new SubTipoActividadDetBean
        {
            IdSubTipoActividadDetalle = idConfOpDe,
            IDSubTipoActividad = idConfOp,
            Etiqueta = Etiqueta,
            CodigoGeneral = CodigoGrupo,
            DescripcionGeneral = NombreGeneral,
            TipoControlDescrip = NombreTipoControl,
            IdTipoControl = idtctr,
            MaxCaracter = MaxCaracter,
            Modificable = Modificable,
            Obligatorio = Obligatorio,
            FlgHabilitado = "T",
            Perfiles = Perfiles,
            PerfilesDesc = PerfilesDesc,
            FlgPadre = "",
            IdSubTipoActividadDetPadre = IControlPadre,
            CodigoTipoControl = IdTipoControl
        };

        var list = (List<SubTipoActividadDetBean>)HttpContext.Current.Session["DetalleSubTipoActividad"];

        var descControl = "";
        if (IControlPadre != "" || IControlPadre == null)
        {
            descControl = list.Find(X => X.Index == IControlPadre).Etiqueta;
        }

        item.Index = (list.Count).ToString();
        item.DesSubTipoActividadDetPadre = descControl;
        if (list == null)
        {
            list = new List<SubTipoActividadDetBean>();
            list.Add(item);
        }
        else
        {
            //if (index == "" || index == "0")
            //{
            //    list.Add(item);
            //}
            if (index == "")
            {
                list.Add(item);
            }
            else
            {
                list[int.Parse(index)].Etiqueta = Etiqueta;
                list[int.Parse(index)].CodigoGeneral = CodigoGrupo;
                list[int.Parse(index)].DescripcionGeneral = NombreGeneral;
                list[int.Parse(index)].TipoControlDescrip = NombreTipoControl;
                list[int.Parse(index)].IdTipoControl = idtctr;
                list[int.Parse(index)].MaxCaracter = MaxCaracter;
                list[int.Parse(index)].Modificable = Modificable;
                list[int.Parse(index)].Obligatorio = Obligatorio;

                list[int.Parse(index)].FlgHabilitado = "T";
                list[int.Parse(index)].Perfiles = Perfiles;
                list[int.Parse(index)].PerfilesDesc = PerfilesDesc;
                list[int.Parse(index)].IDSubTipoActividad = idConfOp;
                list[int.Parse(index)].FlgPadre = "";
                list[int.Parse(index)].IdSubTipoActividadDetPadre = IControlPadre;
                list[int.Parse(index)].CodigoTipoControl = IdTipoControl;
                list[int.Parse(index)].DesSubTipoActividadDetPadre = descControl;
            }

        }

        String dibutaTr = "";
        dibutaTr = fndibujaTr(list);

        HttpContext.Current.Session["DetallesEtapa"] = list;
        return dibutaTr;
    }
    public static String fndibujaTr(List<SubTipoActividadDetBean> list)
    {
        String dibutaTr = "";
        int row = 0, row2 = 0;
        foreach (var item2 in list)
        {
            if (item2.FlgHabilitado == "T")
            {
                dibutaTr += "<tr " + (row2 % 2 == 0 ? "class='file'" : "") + ">" +
            "<td align='center'>" + row2++ + "</td>" +
            "<td align='center'>" + item2.Etiqueta + "</td>" +
            "<td align='center'>" + item2.TipoControlDescrip + "</td>" +
            "<td align='center'>" + item2.MaxCaracter + "</td>" +
            "<td align='center'>" + item2.DescripcionGeneral + "</td>" +
            "<td align='center'>" + item2.ObligatorioDescrip + "</td>" +
            "<td align='center'>" + item2.DesSubTipoActividadDetPadre + "</td>" +
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

        HttpContext.Current.Session["DetalleSubTipoActividad"] = list;
        return dibutaTr;
    }
    [WebMethod]
    public static SubTipoActividadDetBean EditarDetalle(string Codigo, string Index)
    {
        SubTipoActividadDetBean obj = ((List<SubTipoActividadDetBean>)HttpContext.Current.Session["DetalleSubTipoActividad"])[int.Parse(Index)];

        return obj;
    }

    [WebMethod]
    public static TipoActividadBean ObtenerEstadoOportunidad(int Id)
    {
        var item = new TipoActividadBean
        {
            id = Id
        };
        TipoActividadBean obj = TipoActividadController.GetAll(item)[0];
        return obj;
    }

    [WebMethod]
    public static SubTipoActividadBean ObtenerEtapaPredecesora(string Id)
    {
        Int64 vID = 0;
        if (Id == "")
            vID = 0;
        else vID = Int64.Parse(Id);
        var item = new SubTipoActividadBean
        {
            idtipoactividad = vID
        };
        SubTipoActividadBean obj = SubTipoActividadController.GetSubTipoActividadPredecesora(item);
        return obj;
    }

    [WebMethod]
    public static List<SubTipoActividadBean> ListarEtapaPredecesora(string Id)
    {
        Int64 vID = 0;
        if (Id == "")
            vID = 0;
        else vID = Int64.Parse(Id);
        var item = new SubTipoActividadBean
        {
            idtipoactividad = vID
        };
        List<SubTipoActividadBean> obj = SubTipoActividadController.GetSubTipoActividadPredecesoraAll(item);
        return obj;
    }

    [WebMethod]
    public static List<SubTipoActividadBean> ListarEtapaPredecesoraAsignados(string Id)
    {
        Int64 vID = 0;
        if (Id == "")
            vID = 0;
        else vID = Int64.Parse(Id);
        var item = new SubTipoActividadBean
        {
            idtipoactividad = vID
        };
        List<SubTipoActividadBean> obj = SubTipoActividadController.GetSubTipoActividadPredecesoraAll(item);
        return obj;
    }

    [WebMethod]
    public static String EliminarDetalle(string index)
    {
        List<SubTipoActividadDetBean> list = (List<SubTipoActividadDetBean>)HttpContext.Current.Session["DetalleSubTipoActividad"];
        SubTipoActividadDetBean obj = (list)[int.Parse(index)];
        obj.FlgHabilitado = "F";
        String dibutaTr = "";
        if (obj.IdSubTipoActividadDetalle == "" || obj.IdSubTipoActividadDetalle == "0")
        {
            list.RemoveAt(int.Parse(index));
        }
        HttpContext.Current.Session["DetalleSubTipoActividad"] = list;
        dibutaTr = fndibujaTr(list);
        return dibutaTr;
    }

    [WebMethod]
    public static List<ListItem> ConsultaControlCombo(string ctrid, String idSelec, String idGeneral)
    {
        List<SubTipoActividadDetBean> list = (List<SubTipoActividadDetBean>)HttpContext.Current.Session["DetalleSubTipoActividad"];
        List<GrupoBean> lstGeneral = (List<GrupoBean>)HttpContext.Current.Session["SesGrupo"];
        String vIdGenPadre = "";
        try
        {
            vIdGenPadre = lstGeneral.Find(x => x.IDGrupo == Int32.Parse(idGeneral)).CodigoPadreGrupo;
        }
        catch (Exception)
        { }
        if (vIdGenPadre == "")
        {
            return new List<ListItem>();
        }
        var listResult = list.Where(x => x.CodigoTipoControl == "3" && x.FlgHabilitado == "T" && x.CodigoGeneral == vIdGenPadre).ToList().Select(x => new ListItem()
        {
            Text = x.Etiqueta,
            Value = x.Index.ToString(),
            Selected = (x.Index.ToString() == idSelec ? true : false),
        }).ToList(); ;

        return listResult;
    }
}