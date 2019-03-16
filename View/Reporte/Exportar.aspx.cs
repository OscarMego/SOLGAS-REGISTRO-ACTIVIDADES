using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller.functions.excel;
using Controller;
using Model.bean;
using System.Text;
using business.functions;
using System.Data;
using System.Configuration;
using Tools;
using Model;
using Newtonsoft.Json;

public partial class Reporte_Exportar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["MOD"] == "REP_BANDACT")
        {
            Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(Request["valores"]);
            String fechaInicio = dataJSON["FechaInicio"].ToString();
            String fechaFin = dataJSON["FechaFin"].ToString();
            String canal = dataJSON["Canal"].ToString();
            if (canal != string.Empty)
            {
                canal = canal.Remove(canal.Length - 1);
            }
            String zona = dataJSON["Zona"].ToString();
            if (zona != string.Empty)
            {
                zona = zona.Remove(zona.Length - 1);
            }
            String tipoActividad = dataJSON["TipoActividad"].ToString();
            if (tipoActividad != string.Empty)
            {
                tipoActividad = tipoActividad.Remove(tipoActividad.Length - 1);
            }
            String detalleActividad = dataJSON["DetalleActividad"].ToString();
            if (detalleActividad != string.Empty)
            {
                detalleActividad = detalleActividad.Remove(detalleActividad.Length - 1);
            }
            String usuario = dataJSON["Usuario"].ToString();
            if (usuario != string.Empty)
            {
                usuario = usuario.Remove(usuario.Length - 1);
            }
            String cliente = dataJSON["Cliente"].ToString();
            if (cliente != string.Empty)
            {
                cliente = cliente.Remove(cliente.Length - 1);
            }
            String campo = dataJSON["Campo"].ToString();
            if (campo != string.Empty)
            {
                campo = campo.Remove(campo.Length - 1);
            }
            String tipoReporte = dataJSON["TipoReporte"].ToString();
            String usuaSession = HttpContext.Current.Session["lgn_id"].ToString();
            //PAG
            String pagina = dataJSON["pagina"].ToString();
            String filas = dataJSON["filas"].ToString();

            if (campo == string.Empty)
            {
                campo = "[Fecha],[Canal],[Zona],[Tipo Actividad],[Sub Tipo Actividad],[Usuario],[Cliente]";
            }

            var item = new OportunidadBean
            {
                FechaInicio = DateUtils.getStringDateYYMMDDHHMM(fechaInicio),
                FechaFin = DateUtils.getStringDateYYMMDDHHMM(fechaFin),
                Canal = canal,
                Zona = zona,
                TipoActividad = tipoActividad,
                DetalleActividad = detalleActividad,
                Usuario = usuario,
                Cliente = cliente,
                Campo = campo,
                TipoReporte = tipoReporte,
                UsuSession= usuaSession

            };
            
            DataTable dt = OportunidadController.GetReporteAllPaginateExcel(item);

            ExcelFileSpreadsheet exportExcel = this.prepararExportacionExcelReporteOportunidades(dt);
            ExcelFileUtils.ExportToExcel(exportExcel, "ReporteActividad");
        }

        if (Request["MOD"] == "REP_BANDOPORT")
        {
            Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(Request["valores"]);
            String FechaInicio = DateUtils.getStringDateYYMMDDHHMM(dataJSON["FechaInicio"].ToString());
            String FechaFin = DateUtils.getStringDateYYMMDDHHMM(dataJSON["FechaFin"].ToString());
            String Codigo = dataJSON["Codigo"].ToString();
            String Coordinador = dataJSON["Coordinador"].ToString();
            String Responsable = dataJSON["Responsable"].ToString();
            String Estado = dataJSON["Estado"].ToString();
            String Etapa = dataJSON["Etapa"].ToString();
            String Rubro = dataJSON["Rubro"].ToString();
            String ConfRep = dataJSON["ConfRep"].ToString();
            String Cliente = dataJSON["Cliente"].ToString();
            var usuSession = Session["lgn_id"].ToString();
            //PAG
            var item = new OportunidadBean()
            {
                FechaInicio=FechaInicio,
                FechaFin=FechaFin,
                Codigo=Codigo,
                Responsable=Responsable,
                Estado=Estado,
                Etapa=Etapa,
                Rubro=Rubro,
                ConfRep=ConfRep,
                Cliente=Cliente,
                UsuSession=usuSession,
                Coordinador = Coordinador
            };

            //1:Administrador,2:Jefe de Ventas,3:Coordinador Go2Market,4:Supervisor Venta,5:Vendedor
            
            


            DataTable dt = OportunidadController.GetReporteAllPaginateExcel(item);
            List<String> colores = new List<String>();
            foreach (DataRow rowIV in dt.Rows)
            {
                if (rowIV["Retrazo"].ToString() == "T")
                {
                    colores.Add("#ff6666");
                }
                else
                {
                    colores.Add("");
                }
            }
            ExcelFileSpreadsheet exportExcel = this.prepararExportacionExcelReporteOportunidades(dt);
            ExcelFileUtils.ExportToExcelColor(exportExcel, colores, "ReporteOportunidad");
        }
        
        else if (Request["MOD"] == "REP_TRACKING")
        {
            Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(Request["valores"]);
            String Fecha = dataJSON["Fecha"].ToString();
            String JefeVenta = dataJSON["JefeVenta"].ToString();
            String Supervisor = dataJSON["Supervisor"].ToString();
            String Grupo = dataJSON["Grupo"].ToString();
            String coordinador = "";
            String Vendedor = dataJSON["Vendedor"].ToString();
            String Tipo = dataJSON["Tipo"].ToString();


            //PAG
            String pagina = "0";
            String filas = "10";// dataJSON["filas"].ToString();

            var item = new ReporteBean();

            //1:Administrador,2:Jefe de Ventas,3:Coordinador Go2Market,4:Supervisor Venta,5:Vendedor
            var perfil = Session["lgn_perfil"].ToString();
            if (perfil == "3")
            {
                coordinador = Session["lgn_codigo"].ToString();
            }
            else if (perfil == "2")
            {
                JefeVenta = Session["lgn_codigo"].ToString();
            }
            else if (perfil == "4")
            {
                Supervisor = Session["lgn_codigo"].ToString();
            }
            //DataTable dt = TrackingController.getReporteTrackingDataTable(DateUtils.getStringDateYYMMDDHHMM(Fecha), coordinador, JefeVenta, Supervisor, Grupo, Vendedor, Tipo);

            //ExcelFileSpreadsheet exportExcel = this.prepararExportacionExcelReporteTracking(dt);
            //ExcelFileUtils.ExportToExcel(exportExcel, "ReporteTracking");
        }
        else if (Request["MOD"] == "REP_SERVICIOS")
        {
            Int64 lsNextel = Int64.Parse(Request["Nextel"].ToString());
            Int64 lsGrupo = Int64.Parse(Request["Grupo"].ToString());

            string[] lsFechaInicio = (Request["FechaInicio"].ToString()).Split('/');
            string[] lsHoraInicio = (Request["HoraInicio"].ToString().Equals("24:00")) ? "23:59".Split(':') : Request["HoraInicio"].ToString().Split(':');
            string[] lsFechaFin = (Request["FechaFin"].ToString()).Split('/');
            string[] lsHoraFin = (Request["HoraFin"].ToString().Equals("24:00")) ? "23:59".Split(':') : Request["HoraFin"].ToString().Split(':');


            DateTime loDtInicio = new DateTime(Int32.Parse(lsFechaInicio[2]), Int32.Parse(lsFechaInicio[1]), Int32.Parse(lsFechaInicio[0]), Int32.Parse(lsHoraInicio[0]), Int32.Parse(lsHoraInicio[1]), 0);
            DateTime loDtFin = new DateTime(Int32.Parse(lsFechaFin[2]), Int32.Parse(lsFechaFin[1]), Int32.Parse(lsFechaFin[0]), Int32.Parse(lsHoraFin[0]), Int32.Parse(lsHoraFin[1]), 0);

            Int64 lsIdSupervisor = 0;
            if (Session["lgn_id"] != null)
            {
                lsIdSupervisor = Int64.Parse(Session["lgn_id"].ToString());
            }

            String lsFlagGps = Request["FlagGps"].ToString();
            String lsFlagNetwork = Request["FlagNetwork"].ToString();
            String lsFlagDatos = Request["FlagDatos"].ToString();
            String lsFlagWifi = Request["FlagWifi"].ToString();


            //DataTable ldtServicios = ServiciosController.subReporteServiciosXLS(lsNextel, lsGrupo, loDtInicio, loDtFin, lsIdSupervisor, lsFlagGps, lsFlagNetwork, lsFlagDatos, lsFlagWifi);
            //ExcelFileSpreadsheet exportExcel = this.prepararExportacionExcelServicios(ldtServicios, String.Join("/", lsFechaInicio), String.Join("/", lsFechaFin));
            //ExcelFileUtils.ExportToExcel(exportExcel, Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_SUP_PLU));
        }
    }
    private ExcelFileSpreadsheet prepararExportacionExcelReporteVenta(DataTable dt)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";
        dt.Columns.Remove("item");
        dt.Columns.Remove("congps");
        dt.Columns.Remove("latitud");
        dt.Columns.Remove("longitud");
        dt.Columns.Remove("TOTALROWS");
        
        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = "Reporte de ventas";
        ws.sheetName = "Reporte Ventas";
        ws.dtSource = dt;

        ws.columnHeader.Add("Pedido");
        ws.columnHeader.Add("Vendedor");
        ws.columnHeader.Add("Supervisor");
        ws.columnHeader.Add("Cliente");
        ws.columnHeader.Add("Dirección");
        ws.columnHeader.Add("Fecha Inicio");
        ws.columnHeader.Add("Fecha Fin");
        ws.columnHeader.Add("Condición Venta");
        ws.columnHeader.Add("Monto Total");

        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelReporteNoVenta(DataTable dt)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";
        dt.Columns.Remove("item");
        dt.Columns.Remove("congps");
        dt.Columns.Remove("latitud");
        dt.Columns.Remove("longitud");
        dt.Columns.Remove("TOTALROWS");
        dt.Columns.Remove("codigoregistro");
        dt.Columns.Remove("cliente");
        
        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = "Reporte de No Ventas";
        ws.sheetName = "Reporte de No Ventas";
        ws.dtSource = dt;

        ws.columnHeader.Add("Vendedor");
        ws.columnHeader.Add("Direccion Cliente");
        ws.columnHeader.Add("Fecha Registro");
        ws.columnHeader.Add("Motivo");

        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelReporteInicioVenta(DataTable dt)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";
        
        dt.Columns.Remove("item");
        dt.Columns.Remove("congps");
        dt.Columns.Remove("latitud");
        dt.Columns.Remove("longitud");
        dt.Columns.Remove("tipo");
        dt.Columns.Remove("supervisor");
        dt.Columns.Remove("direccion");
        dt.Columns.Remove("fechafin");
        dt.Columns.Remove("condicionventa");
        dt.Columns.Remove("TOTALROWS");
        
        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = "Reporte Inicio Ventas";
        ws.sheetName = "Reporte Inicio Ventas";
        ws.dtSource = dt;

        ws.columnHeader.Add("Cod. Pedido.");
        ws.columnHeader.Add("Vendedor");
        ws.columnHeader.Add("Cliente");
        ws.columnHeader.Add("Hora de Inicio");
        ws.columnHeader.Add("Monto Total");

        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelReporteOportunidades(DataTable dt)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";


        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = "Reporte Actividades";
        ws.sheetName = "Reporte Actividades";
        ws.dtSource = dt;

        int countColumn = GetColumnCount(dt);

        int diff = countColumn - 0;
        int temp = diff;
        int j = 0;

        while (j < diff)
        {
            temp = diff - j;
            int diffTemp = countColumn - temp;
            String nameColumn = dt.Columns[diffTemp].ToString();
            if (nameColumn.Count() > 3)
            {
                string cod = nameColumn.Substring(0, 3);
                if (cod.Equals(Constantes.ColDinamico))
                {
                    nameColumn = nameColumn.Replace(cod, "");
                }

            }
            ws.columnHeader.Add(nameColumn);
            ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
            j++;
        };
        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelReporteTracking(DataTable dt)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";

        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = "Reporte de Tracking";
        ws.sheetName = "Reporte de Tracking";
        ws.dtSource = dt;

        ws.columnHeader.Add("Tipo");
        ws.columnHeader.Add("Codigo");
        ws.columnHeader.Add("Codigo Vendedor");
        ws.columnHeader.Add("Nombre Vendedor");
        ws.columnHeader.Add("Codigo CLiente");
        ws.columnHeader.Add("Nombre Cliente");
        ws.columnHeader.Add("Monto");
        ws.columnHeader.Add("Motivo");
        ws.columnHeader.Add("Latitud");
        ws.columnHeader.Add("Longitud");

        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelMonitorZonasDetalle(DataTable dt, string ubicacion, string estado, string fecha)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = "";// Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";

        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = "Monitores de Zonas de Carga " + (estado == "C" ? "Cerrado " + fecha : "En Proceso");
        ws.dtSource = dt;
        ws.sheetName = (estado == "C" ? "Cerrado" : "En Proceso");


        int countColumn = GetColumnCount(dt);

        int diff = countColumn - 0;
        int temp = diff;
        int j = 0;

        while (j < diff)
        {
            temp = diff - j;
            int diffTemp = countColumn - temp;
            String nameColumn = dt.Columns[diffTemp].ToString();
            if (nameColumn.Count() > 3)
            {
                string cod = nameColumn.Substring(0, 3);
                if (cod.Equals(Constantes.ColDinamico))
                {
                    nameColumn = nameColumn.Replace(cod, "");
                }

            }
            ws.columnHeader.Add(nameColumn);
            ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
            j++;
        }
        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelServicios(DataTable dt, String fecini, String fecfin)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";

        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_SUP_PLU).Substring(0, 1).ToUpper() + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_SUP_PLU).Substring(1) + " del " + fecini + " al " + fecfin;
        ws.sheetName = fecini.Replace('/', '-') + " al " + fecfin.Replace('/', '-');
        ws.dtSource = dt;

        ws.columnHeader.Add("Número");
        ws.columnHeader.Add("Nombre");
        ws.columnHeader.Add("Bateria");
        ws.columnHeader.Add("Señal");
        ws.columnHeader.Add("Fecha");
        ws.columnHeader.Add("Estado");
        ws.columnHeader.Add("GPS");
        ws.columnHeader.Add("Network");
        ws.columnHeader.Add("Datos");
        ws.columnHeader.Add("WiFi");
        ws.columnHeader.Add("Tiene Ubicación");

        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelEnvios(DataTable dt, String fecini, String fecfin)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";

        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_MSJ_PLU).Substring(0, 1).ToUpper() + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_MSJ_PLU).Substring(1) + " del " + fecini + " al " + fecfin;
        ws.sheetName = fecini.Replace('/', '-') + " al " + fecfin.Replace('/', '-');
        ws.dtSource = dt;

        ws.columnHeader.Add("Id");
        ws.columnHeader.Add("Número");
        ws.columnHeader.Add("Usuario");
        ws.columnHeader.Add("Fecha Envio");
        ws.columnHeader.Add("Fecha Recepción");
        ws.columnHeader.Add("Fecha Lectura");
        ws.columnHeader.Add("Mensaje");
        ws.columnHeader.Add("Estado");
        ws.columnHeader.Add("Control");
        ws.columnHeader.Add("Valor");

        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);

        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelResumenVisita(DataTable dt, String fecini, String fecfin)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";

        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_REP_RVI).Substring(0, 1).ToUpper() + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_REP_RVI).Substring(1) + " del " + fecini + " al " + fecfin;
        ws.sheetName = fecini.Replace('/', '-') + " al " + fecfin.Replace('/', '-');
        ws.dtSource = dt;

        ws.columnHeader.Add("Teléfono");
        ws.columnHeader.Add("Usuario");
        ws.columnHeader.Add("Grupo");
        ws.columnHeader.Add("Fecha");
        ws.columnHeader.Add("DesGeo");
        ws.columnHeader.Add("Estados");
        ws.columnHeader.Add("Inicio");
        ws.columnHeader.Add("Último");
        ws.columnHeader.Add("Fotos");

        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ss.worksheets.Add(ws);

        return ss;
    }
    private ExcelFileSpreadsheet prepararExportacionExcelDetalleVisita(DataTable dt, String fecini, String fecfin)
    {
        ExcelFileSpreadsheet ss = new ExcelFileSpreadsheet();
        ss.propertyAuthor = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_OPERADOR) + Controller.GeneralController.getCultureIdioma() + " del Peru";
        ss.propertyTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.WEB_APP_NAME) + " - Exportacion de Datos";

        ExcelFileWorksheet ws = new ExcelFileWorksheet();
        ws.sheetTitle = Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_DET_RVI).Substring(0, 1).ToUpper() + Model.bean.IdiomaCultura.getMensaje(Model.bean.IdiomaCultura.ETI_DET_RVI).Substring(1) + " del " + fecini + " al " + fecfin;
        ws.sheetName = fecini.Replace('/', '-') + " al " + fecfin.Replace('/', '-');
        ws.dtSource = dt;

        //ws.columnHeader.Add("IdRegistro");
        ws.columnHeader.Add("Teléfono");
        ws.columnHeader.Add("Usuario");
        ws.columnHeader.Add("Grupo");
        ws.columnHeader.Add("Estados");
        ws.columnHeader.Add("Fecha");
        ws.columnHeader.Add("PuntoInteres");
        ws.columnHeader.Add("GeoCerca");
        ws.columnHeader.Add("Comentario");
        //ws.columnHeader.Add("FlagFoto");
        ws.columnHeader.Add("Latitud");
        ws.columnHeader.Add("Longitud");
        //ws.columnHeader.Add("IdVisista");       
        //ws.columnHeader.Add("DesGeo");
        //ws.columnHeader.Add("TamanioTotal");
        //ws.columnHeader.Add("Total");

        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        //ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        //ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        //ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        //ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        //ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        //ws.columnFormat.Add(ExcelFileCellFormat.TEXT);
        ss.worksheets.Add(ws);

        return ss;
    }
    public static int GetColumnCount(DataTable table)
    {
        int count = 0;
        if (table != null)
        {
            foreach (System.Data.DataColumn col in table.Columns)
            {
                count++;
            }
        }
        return count;
    }
}