using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model.bean;
using System.Data;
using System.Globalization;
using Model;
using business.functions;

namespace Controller
{
    public class ReporteController
    {

        public static String[] PosiColor = new String[] { "FF0000", "00FF00", "0000FF", "00FFFF", "FF00FF", "FFFF00", "7F0000", "007F00", "00007F", "007F7F", "7F007F", "7F7F00", "7F00FF", "007FFF", "FF7F00", "00FF7F", "FF007F", "7FFF00", "FEFF90", "7E0090", "000000", "FFFFFF", "888888" };
        public static String[] textColor = new String[] { "FFFFFF", "000000", "FFFFFF", "000000", "FFFFFF", "000000", "FFFFFF", "FFFFFF", "FFFFFF", "FFFFFF", "FFFFFF", "FFFFFF", "FFFFFF", "FFFFFF", "FFFFFF", "000000", "FFFFFF", "000000", "000000", "FFFFFF", "FFFFFF", "000000", "FFFFFF" };

        //public static Double getConfiguracionRDIS()
        //{
        //    DataTable dt = ConfiguracionModel.fnDatosConfiguracion();
        //    Double RDIS = 0;
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        if (dr["CodConfiguracion"].ToString() == "RDIS")
        //        {
        //            RDIS = Convert.ToDouble(dr["Valor"].ToString());
        //        }
        //    }
        //    return RDIS;
        //}

        //public static void crear(String nombre, String codigos)
        //{
        //    try
        //    {
        //    }

        //    catch (Exception ex)
        //    {

        //        throw new Exception(ex.Message);

        //    }

        //}

        //public static void actualizar(String idReporte, String codigos)
        //{
        //    try
        //    {
        //    }

        //    catch (Exception ex)
        //    {

        //        throw new Exception(ex.Message);

        //    }

        //}


        //public static void borrar(String id)
        //{
        //}

        //public static List<ComboBean> getReportes()
        //{
        //    DataTable dt = null;

        //    List<ComboBean> lst = new List<ComboBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            ComboBean bean = new ComboBean();
        //            bean.Codigo = row["IdMapa"].ToString();
        //            bean.Nombre = row["Descripcion"].ToString().Trim();
        //            lst.Add(bean);
        //        }

        //    }
        //    return lst;
        //}

        //public static List<GraficoItemBean> getRepConectNoConect()
        //{
        //    DataTable dt = null;//.getRepConectNoConect();
        //    List<GraficoItemBean> rep = new List<GraficoItemBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            rep.Add(new GraficoItemBean
        //            {
        //                name = row["Descripcion"].ToString(),
        //                y = Decimal.Parse(row["Valor"].ToString()),
        //            });
        //        }

        //    }
        //    return rep;
        //}
        //public static List<GraficoItemBean> getRepVisitaNoVisita()
        //{
        //    DataTable dt = null;//.getRepVisitaNoVisita();
        //    List<GraficoItemBean> rep = new List<GraficoItemBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            rep.Add(new GraficoItemBean
        //            {
        //                name = row["Descripcion"].ToString(),
        //                y = Decimal.Parse(row["Valor"].ToString()),
        //            });
        //        }

        //    }
        //    return rep;
        //}
        //public static List<GraficoItemBean> getRepPunInteNoPunInt()
        //{
        //    DataTable dt = null;//.getRepPunInteNoPunInt();
        //    List<GraficoItemBean> rep = new List<GraficoItemBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            rep.Add(new GraficoItemBean
        //            {
        //                name = row["Descripcion"].ToString(),
        //                y = Decimal.Parse(row["Valor"].ToString()),
        //            });
        //        }

        //    }
        //    return rep;
        //}
        //public static List<GraficoItemBean> getRepEnGeocFuera()
        //{
        //    DataTable dt = null;//.getRepEnGeocFuera();
        //    List<GraficoItemBean> rep = new List<GraficoItemBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            rep.Add(new GraficoItemBean
        //            {
        //                name = row["Descripcion"].ToString(),
        //                y = Decimal.Parse(row["Valor"].ToString()),
        //            });
        //        }

        //    }
        //    return rep;
        //}
        //public static List<GraficoItemBean> getRepVisitaFotoEstado()
        //{
        //    DataTable dt = null;//.getRepVisitaFotoEstado();
        //    List<GraficoItemBean> rep = new List<GraficoItemBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            rep.Add(new GraficoItemBean
        //            {
        //                name = row["Estado"].ToString(),
        //                y = Decimal.Parse(row["Cantidad"].ToString()),
        //            });
        //        }

        //    }
        //    return rep;
        //}
        //public static List<ComboBean> getPlantillas()
        //{
        //    DataTable dt = null;//.getPlantillas();

        //    List<ComboBean> lst = new List<ComboBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            ComboBean bean = new ComboBean();
        //            bean.Codigo = row["IdPlantilla"].ToString();
        //            bean.Nombre = row["Descripcion"].ToString().Trim();
        //            lst.Add(bean);
        //        }

        //    }
        //    return lst;
        //}

        //public static List<FiltroBean> getFiltros(String idReporte, String Tipo)
        //{
        //    DataTable dt = null;//.getFiltros(idReporte, Tipo);

        //    List<FiltroBean> lst = new List<FiltroBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            FiltroBean bean = new FiltroBean();
        //            bean.IdFiltro = row["IdFiltro"].ToString();
        //            bean.Descripcion = row["Descripcion"].ToString().Trim();
        //            bean.CodFiltro = row["CodFiltro"].ToString().Trim();
        //            bean.TipoFiltro = row["TipoFiltro"].ToString().Trim();
        //            bean.Orden = row["Orden"].ToString().Trim();
        //            bean.TipoControl = row["TipoControl"].ToString().Trim();
        //            bean.Query = row["Query"].ToString().Trim();
        //            bean.IdCampo = row["IdCampo"].ToString().Trim();
        //            bean.IdCampoUltPosicion = row["IdCampo"].ToString().Trim();

        //            lst.Add(bean);
        //        }

        //    }
        //    return lst;
        //}


        //public static List<FiltroBean> getFiltros(String idReporte)
        //{
        //    DataTable dt = null;//.getFiltros(idReporte);

        //    List<FiltroBean> lst = new List<FiltroBean>();
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            FiltroBean bean = new FiltroBean();
        //            bean.IdFiltro = row["IdFiltro"].ToString();
        //            bean.Descripcion = row["Descripcion"].ToString().Trim();
        //            bean.CodFiltro = row["CodFiltro"].ToString().Trim();
        //            bean.TipoFiltro = row["TipoFiltro"].ToString().Trim();
        //            bean.Orden = row["Orden"].ToString().Trim();
        //            bean.TipoControl = row["TipoControl"].ToString().Trim();
        //            bean.Query = row["Query"].ToString().Trim();
        //            bean.IdCampo = row["IdCampo"].ToString().Trim();
        //            bean.IdCampoUltPosicion = row["IdCampo"].ToString().Trim();
        //            bean.habilitado = row["habilitado"].ToString().Trim();

        //            lst.Add(bean);
        //        }

        //    }
        //    return lst;
        //}



        //public static List<ComboBean> getLoad(String stp, String idSupervisor)
        //{
        //    DataTable dt = null;//.getLoad(stp, idSupervisor);

        //    List<ComboBean> lst = new List<ComboBean>();

        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            ComboBean bean = new ComboBean();
        //            bean.Codigo = row["IdOpcion"].ToString();
        //            bean.Nombre = row["Descripcion"].ToString().Trim();

        //            lst.Add(bean);
        //        }

        //    }

        //    return lst;
        //}


        //public static DataTable getCamposDinamicos(String IdSupervisor, String idReporte, String Filtros, String registros)
        //{
        //    DataTable dt = null;//.getCamposDinamicos(IdSupervisor, idReporte, Filtros, registros);

        //    return dt;
        //}

        //public static DataTable getCamposDinamicosADIA(String IdSupervisor, String idReporte, String Filtros, String registros)
        //{
        //    DataTable dt = null;//.getCamposDinamicosUltpos(IdSupervisor, idReporte, Filtros, registros);

        //    return dt;
        //}

        //public static DataTable getCamposInfowindows(String idRegistro, String idReporte)
        //{
        //    DataTable dt = null;//.getCamposInfowindows(idRegistro, idReporte);
        //    return dt;
        //}

        //public static DataTable getCamposDinamicosAsReport(String IdSupervisor, String idReporte, String Filtros, String registros,String distancia, String kms, String estados, String movGeo,String tipoR,Int32 tiempoEnvio)
        //{
        //    DataTable dt;
        //    if (tipoR == "ADIA") { 
        //        dt = null;//.getCamposDinamicosUltpos(IdSupervisor, idReporte, Filtros, registros);
        //        DataView v = new DataView(dt);
        //        v.Sort = "FechaCelular DESC";
        //        dt = v.ToTable();
        //        return dt;
        //    }
        //    else {
        //        dt = null;//.getCamposDinamicos(IdSupervisor, idReporte, Filtros, registros);
        //        return dt;
        //    }
        //}

        //public static MapBean getCamposDinamicos_MapaADIA(String IdSupervisor, String idReporte, String Filtros, String registros, String distancia, String kms, String estados)
        //{
        //    MapBean beMap = new MapBean();
        //    List<PointBean> listaPoint = new List<PointBean>();
        //    List<GroupPolylineBean> listaPolynes = new List<GroupPolylineBean>();
        //    DataTable dt = null;//.getCamposDinamicosUltpos(IdSupervisor, idReporte, Filtros, registros);

        //    if (distancia != "F")
        //    {
        //        dt = ReporteController.getDistancia(dt);
        //    }

        //    int idxUsuario = 0;

        //    DataView v = new DataView(dt);
        //    v.Sort = "FechaCelular ASC";
        //    dt = v.ToTable();

        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        PointBean be = new PointBean();

        //        if (estados != "F")
        //        {

        //            String color = "FFFFFF";
        //            if (dr["colorEst"].Equals("56FF56"))
        //            {
        //                color = "000000";
        //            }
        //            be.colorIcono = dr["colorEst"].ToString();
        //            be.colorTexto = color;

        //        }
        //        else
        //        {
        //            be.colorIcono = PosiColor[idxUsuario];
        //            be.colorTexto = textColor[idxUsuario];
        //        }
        //        be.idCorrelativo = dr["ordenMap"].ToString();
        //        be.textoIcono = dr["ordenMap"].ToString();
        //        be.img = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=" + be.textoIcono + "|" + be.colorIcono + "|" + be.colorTexto;
        //        if (dr["visita"].ToString() == "T")
        //        {
        //            be.img = "../../images/interes/Blanco56FF56.png";
        //        }
        //        be.latitud = dr["latitud"].ToString();
        //        be.longitud = dr["longitud"].ToString();
        //        be.precision = dr["precision"].ToString();
        //        be.titulo = dr["NOM"].ToString() + " - " + dr["NXT"].ToString() + " : " + be.textoIcono;
        //        be.msg = "<div style='text-align: center;' class='infoWPoint' textoIcono='" + be.textoIcono + "' idCorre='" + be.idCorrelativo + "' idPoint='" + dr["IdRegistro"] + "'><img src='../../images/icons/loader/ico_loader-arrow-orange.gif' /><p>buscando resultados</p></div>";
        //        PointBean.FiltroBean loFiltro;
        //        foreach (DataColumn dc in dt.Columns)
        //        {
        //            loFiltro = new PointBean.FiltroBean();
        //            loFiltro.descripcion = dr[dc.ColumnName].ToString();
        //            be.filtros.Add(loFiltro);
        //        }
        //        listaPoint.Add(be);
        //        idxUsuario++;

        //        if (idxUsuario == PosiColor.Length)
        //        {
        //            idxUsuario = 0;
        //        }

        //    }

        //    beMap.puntos = listaPoint;
        //    beMap.grouppolylines = listaPolynes;

        //    return beMap;
        //}

        //public static List<MapGeocercaBean> getGeocerca(String IdGeocerca)
        //{

        //    MapGeocercaBean beGeo;
        //    List<MapGeocercaBean> listaGeo = new List<MapGeocercaBean>();

        //    DataTable dt = null;//.getGeocerca(IdGeocerca);

        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        beGeo = new MapGeocercaBean();
        //        beGeo.id = dr["IdGeocerca"].ToString();
        //        beGeo.nombre = dr["Descripcion"].ToString();
        //        beGeo.punto = dr["Punto"].ToString();
        //        beGeo.puntos = puntosGeo(beGeo.punto);
        //        listaGeo.Add(beGeo);
        //    }

        //    return listaGeo;
        //}

        //public static List<NextelBean> getUsuariosPorGrupo(String codigosGrupo){
        //    DataTable dt = null;//.getUsuariosPorGrupo(codigosGrupo);
        //    List<NextelBean> nextels=new List<NextelBean>();
        //    NextelBean nextel;
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        nextel = new NextelBean();
        //        nextel.IdOpcion = dr["IdOpcion"].ToString();
        //        nextel.Nextel = dr["Nextel"].ToString();
        //        nextel.Descripcion = dr["Descripcion"].ToString();
        //        nextels.Add(nextel);
        //    }
        //    return nextels;
        //}
        //public static MapBean getPuntosInteres(String IdCapa)
        //{
        //    MapBean beMap = new MapBean();
        //    List<PointBean> listaPoint = new List<PointBean>();
        //    List<GroupPolylineBean> listaPolynes = new List<GroupPolylineBean>();
        //    DataTable dt = null; ;


        //    int i = 1;

        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        PointBean be = new PointBean();



        //        be.img = "../../images/interes/" + dr["Icono"].ToString() + ".png";
        //        be.latitud = dr["latitud"].ToString();
        //        be.longitud = dr["longitud"].ToString();
        //        be.titulo = dr["Nombre"].ToString();
        //        be.precision = dr["RadioPrecision"].ToString();
        //        be.colorIcono = dr["Color"].ToString();

        //        StringBuilder t1 = new StringBuilder();
        //        t1.Append("<table style='width: 180px;' class='noPointer grillaMapa table table-bordered table-striped'>\n");
        //        t1.Append("<thead>\n");
        //        t1.Append("<tr>");

        //        t1.Append("<th >" + dr["Nombre"].ToString() + "</th>");

        //        t1.Append("</tr>");
        //        t1.Append("</thead>\n");
        //        t1.Append("<tbody>\n");
        //        t1.Append("<tr>");
        //        t1.Append("<td>" + dr["Descripcion"].ToString() + "</td>");
        //        t1.Append("</tr>");
        //        t1.Append("</tbody>\n");

        //        be.msg = t1.ToString();
        //        listaPoint.Add(be);
        //        i++;

        //    }


        //    beMap.puntos = listaPoint;
        //    beMap.grouppolylines = listaPolynes;

        //    return beMap;
        //}

        //public static List<MapGeocercaBean> getGeocercas()
        //{
        //    DataTable dt = null;//.getGeocercas();
        //    List<MapGeocercaBean> lista = new List<MapGeocercaBean>();

        //    foreach (DataRow row in dt.Rows)
        //    {


        //        MapGeocercaBean bean = new MapGeocercaBean();
        //        bean.id = row["idOpcion"].ToString();
        //        bean.nombre = row["Descripcion"].ToString();
        //        bean.punto = row["Punto"].ToString();
        //        bean.puntos = puntosGeo(bean.punto);
        //        lista.Add(bean);

        //    }
        //    return lista;
        //}

        //public static List<MapGeocercaBean> getGeocercasConAsignacion(List<MapControlBean> controles)
        //{
        //    DataTable dt = null;//.getGeocercasConAsignacion(controles);
        //    List<MapGeocercaBean> lista = new List<MapGeocercaBean>();

        //    foreach (DataRow row in dt.Rows)
        //    {


        //        MapGeocercaBean bean = new MapGeocercaBean();
        //        bean.id = row["idOpcion"].ToString();
        //        bean.nombre = row["Descripcion"].ToString();
        //        bean.punto = row["Punto"].ToString();
        //        bean.puntos = puntosGeo(bean.punto);
        //        lista.Add(bean);

        //    }
        //    return lista;
        //}
        //public static String getControlesSMS(String idPlantilla)
        //{
        //    StringBuilder sb = new StringBuilder();
        //    DataTable dt = null;//.getControles(idPlantilla);

        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        sb.Append("<input type=\"hidden\" name=\"hTitulo\" id=\"hTitulo\" value=\"" + dr["Titulo"].ToString() + "\"/>").Append(getControlSMS(dr["CodControl"].ToString(), dr["IdControl"].ToString(), dr["Descripcion"].ToString(), dr["FlagObligatorio"].ToString()));
        //    }

        //    return sb.ToString();


        //}

        //private static String getControlSMS(String Tipo, String id, String Descripcion, String Flag)
        //{
        //    StringBuilder sb = new StringBuilder();
        //    String requerido = "";
        //    String asterisco = "";
        //    if (Flag != "F")
        //    {
        //        requerido = "requerid";
        //        asterisco = "*";
        //    }

        //    if (Tipo == "TXA")
        //    {
        //        sb.Append("<div class=\"cz-form-content\" style='height: 80px;width:510px'>");
        //        sb.Append("<p >" + Descripcion + asterisco + "</p >");
        //        sb.Append("<textarea maxlength='500' placeholder='Máximo 500 caracteres' tipo='TXA' cod='" + id + "'  style='width: 500px;height: 32px;' class='controlSMS TXA " + requerido + "' id=\"" + Tipo + id + "\"></textarea>");
        //    }
        //    else if (Tipo == "TXT")
        //    {



        //        sb.Append("<div class=\"cz-form-content\" style='height: 60px;'>");
        //        sb.Append("<p >" + Descripcion + asterisco + "</p >");
        //        sb.Append("<input maxlength='50' placeholder='Máximo 50 caracteres' type=\"text\" tipo='TXT' cod='" + id + "' id=\"" + Tipo + id + "\"  class=\"" + requerido + " controlSMS cz-form-content-input-text\"/>");
        //        sb.Append("<div class=\"cz-form-content-input-text-visible\"><div class=\"cz-form-content-input-text-visible-button\"></div></div>");


        //    }
        //    else if (Tipo == "MAP")
        //    {
        //        sb.Append("<div class=\"cz-form-content\" style='width:510px;height: 350px;'>");
        //        sb.Append("<input id=\"hLatitud\" cod='" + id + "' type=\"hidden\" />");
        //        sb.Append("<input id=\"hLongitud\" cod='" + id + "' type=\"hidden\" />");
        //        sb.Append("<p >" + Descripcion + "</p >");
        //        sb.Append("<div id='dvAddress'>");
        //        sb.Append("<input name=\"address\" type=\"text\" id=\"address\" style=\"width: 200px;\" placeholder=\"Ingresa Dirección\" />");

        //        sb.Append("<input style='z-index:0; margin-top:0px;margin-top: 0px;padding-left: 12px;padding-right: 12px;padding-top: 3px;padding-bottom: 4px;background-image: url(\"../../imagery/all/icons/buscar.png\");  background-repeat: no-repeat;  background-position: 2px;background-size: 16px;' type='button' class='btnDireccion form-button cz-form-content-input-button cz-form-content-input-button-image' value=''>");
        //        sb.Append("</div>");
        //        sb.Append("<div id='mapdiv'></div>");
        //    }

        //    sb.Append(" </div>");

        //    return sb.ToString();
        //}

        //private static List<GeocercaPuntosBean> puntosGeo(String puntos)
        //{
        //    List<GeocercaPuntosBean> points = new List<GeocercaPuntosBean>();

        //    String[] rows = puntos.Split('@');

        //    for (int i = 0; i < rows.Length; i++)
        //    {
        //        String[] lalo = rows[i].Split('|');
        //        GeocercaPuntosBean be = new GeocercaPuntosBean();
        //        be.latitud = lalo[0];
        //        be.longitud = lalo[1];

        //        points.Add(be);
        //    }


        //    return points;
        //}

        //public static void envSMS(String IDMENSAJE, String IDUSUARIO, String PLANTILLA, String CONTROLES, String VALORES, String FECHA)
        //{

        //}

        //public static DataTable getDistancia(DataTable dt)
        //{
        //    dt.Columns.Add("distancia");

        //    String latitud="0.0";
        //    String longitud="0.0";

        //    List<DataRow> rowsToDelete = new List<DataRow>();
        //    Double distanciaMin = ReporteController.getConfiguracionRDIS();
        //    List<String> nextels = new List<String>();
        //    string nextel = "";

        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        if (dr["NXT"].ToString() != nextel)
        //        {

        //            try
        //            {
        //                nextel = dr["NXT"].ToString();
        //                nextels.Add(nextel);

        //            }
        //            catch (Exception)
        //            {

        //                continue;
        //            }
        //        }
        //    }


        //    foreach (String nxt in nextels)
        //    {

        //        DataRow drOld = null;
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            if (dr["NXT"].ToString() == nxt.ToString())
        //            {

        //                if (drOld != null)
        //                {
        //                    dr["distancia"] = distance(Convert.ToDouble(drOld["Latitud"].ToString()), Convert.ToDouble(drOld["Longitud"].ToString()), Convert.ToDouble(dr["Latitud"].ToString()), Convert.ToDouble(dr["Longitud"].ToString()));
        //                }
        //                else
        //                {
        //                    latitud = dr["Latitud"].ToString();
        //                    longitud = dr["Longitud"].ToString();
        //                    dr["distancia"] = "9999999";
        //                }
        //                if (Convert.ToDouble(dr["distancia"].ToString()) < distanciaMin)
        //                {
        //                    dr["latitud"] = latitud;
        //                    dr["longitud"] = longitud;
        //                }
        //                else
        //                {
        //                    latitud = dr["Latitud"].ToString();
        //                    longitud = dr["Longitud"].ToString();
        //                }
        //                drOld = dr;
        //            }
        //        }

        //    }
        //    dt.AcceptChanges();


        //    DataView dv = new DataView(dt);
        //    dv.Sort = "FechaCelular DESC";
        //    dt = dv.ToTable();

        //    return dt;

        //}

        //public static DataTable getKMS(DataTable dt)
        //{
        //    dt.Columns.Add("kms");
        //    List<DataRow> rowsToDelete = new List<DataRow>();
        //    Double distanciaMin = ReporteController.getConfiguracionRDIS();
        //    List<String> nextels = new List<String>();
        //    string nextel = "";

        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        if (dr["NXT"].ToString() != nextel)
        //        {

        //            try
        //            {
        //                nextel = dr["NXT"].ToString();
        //                nextels.Add(nextel);

        //            }
        //            catch (Exception)
        //            {

        //                continue;
        //            }
        //        }
        //    }


        //    foreach (String nxt in nextels)
        //    {

        //        DataRow drOld = null;
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            if (dr["NXT"].ToString() == nxt.ToString())
        //            {

        //                if (drOld != null)
        //                {
        //                    dr["kms"] = (distance(Convert.ToDouble(drOld["Latitud"].ToString()), Convert.ToDouble(drOld["Longitud"].ToString()), Convert.ToDouble(dr["Latitud"].ToString()), Convert.ToDouble(dr["Longitud"].ToString())) / 1000);
        //                }
        //                else
        //                {
        //                    dr["kms"] = "0";
        //                }
        //                drOld = dr;



        //            }
        //        }

        //    }


        //    return dt;

        //}

        //private static double distance(Double lat1, Double lon1, Double lat2, Double lon2)
        //{
        //    var R = 6371; // km (change this constant to get miles)
        //    var dLat = (lat2 - lat1) * Math.PI / 180;
        //    var dLon = (lon2 - lon1) * Math.PI / 180;
        //    var a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
        //        Math.Cos(lat1 * Math.PI / 180) * Math.Cos(lat2 * Math.PI / 180) *
        //        Math.Sin(dLon / 2) * Math.Sin(dLon / 2);
        //    var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
        //    var d = R * c;
        //    return Math.Round(d * 1000);//m

        //}

        //public static DataTable getDeltaTiempoConPrimeraPosicion(DataTable dt, Int32 tiempoEnvio)
        //{

        //    dt.Columns.Add("delta");

        //    DataView dv = new DataView(dt);
        //    dv.Sort = "NXT ASC,fechaCelular ASC";
        //    dt = dv.ToTable();
        //    String nextel = "";
        //    DataRow drOld = null;
        //    int i = 0;
        //    foreach (DataRow dr in dt.Rows)
        //    {

        //        if (dr["NXT"].ToString() == nextel)
        //        {          
        //            if (drOld != null)
        //            {
        //                Int32 delta = deltaTime((DateTime)drOld["FechaCelular"], (DateTime)dr["FechaCelular"]);
        //                dr["delta"] = delta.ToString();
        //                if (delta >= (tiempoEnvio-5))
        //                {
        //                    drOld = dr;
        //                }
        //            }
        //            else
        //            {
        //                dr["delta"] = "0";
        //                drOld = dr;
        //            }
        //        }
        //        else
        //        {
        //            if (i != 0)
        //            {
        //                dt.Rows[i-1]["delta"] = "0";
        //            }

        //            nextel = dr["NXT"].ToString();
        //            dr["delta"] = "0";
        //            drOld = null;
        //        }

        //        i++;
        //    }

        //    dt.AcceptChanges();


        //    dv = new DataView(dt);
        //    dv.Sort = "FechaCelular DESC";
        //    dt = dv.ToTable();

        //    return dt;

        //}

        //private static Int32 deltaTime(DateTime fechaInicio, DateTime fechaFin)
        //{   
        //    try
        //    {
        //        Int32 diferencia = Convert.ToInt32((fechaFin - fechaInicio).TotalMinutes);
        //        return diferencia;
        //    }
        //    catch (Exception)
        //    {

        //    }
        //    return 0;
        //}


        public static GraficoBean ReporteGraficoEstadoPorEtapa(OportunidadBean item)
        {
            var dt = ReporteModel.ReporteGraficoEstadoPorEtapa(item);

            var result = new GraficoItemBean();
            var lst = new List<OportunidadBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var reporte = new OportunidadBean()
                    {
                        Estado = row["Estado"].ToString(),
                        Etapa = row["Etapa"].ToString(),
                        Cantidad = row["cant"].ToString(),
                    };

                    lst.Add(reporte);
                }
            }
            // var data = lst
            //.GroupBy(p => p.Etapa)
            //.Select(g => g.FirstOrDefault())
            //.ToArray();

            String[] categorias = lst.Select(s => s.Etapa).Distinct().ToArray();
            String[] estados = lst.Select(s => s.Estado).Distinct().ToArray();
            List<GraficoItem2Bean> lGrafic = new List<GraficoItem2Bean>();
            foreach (var es in estados)
            {
                GraficoItem2Bean eGraf = new GraficoItem2Bean();
                eGraf.name = es;
                int j = 0;
                Decimal[] dataEt = new Decimal[categorias.Length];
                foreach (var cat in categorias)
                {
                    var cant = lst.Find(x => x.Estado == es && x.Etapa == cat);
                    if (cant != null)
                    {
                        dataEt[j] = Decimal.Parse(cant.Cantidad);
                    }
                    else
                    {
                        dataEt[j] = 0;
                    }
                    j++;
                }
                eGraf.data = dataEt;
                lGrafic.Add(eGraf);
            }
            GraficoBean lPadreGrafic = new GraficoBean { categorias = categorias, itemsArr = lGrafic };
            return lPadreGrafic;
        }
        public static List<GraficoItemBean> ReporteGraficoOportPorEtapa(OportunidadBean item)
        {
            var dt = ReporteModel.ReporteGraficoOportEtapas(item);

            var lst = new List<GraficoItemBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var reporte = new GraficoItemBean()
                    {
                        name = row["Etapa"].ToString(),
                        y = Decimal.Parse(row["cant"].ToString()),
                    };

                    lst.Add(reporte);
                }
            }
            return lst;
        }
        public static GraficoBean ReporteGraficoExcesoTiempo(OportunidadBean item)
        {
            var dt = ReporteModel.ReporteGraficoExcesoTiempo(item);

            var result = new GraficoItemBean();
            var lst = new List<OportunidadBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var reporte = new OportunidadBean()
                    {
                        Estado = row["Estado"].ToString(),
                        Etapa = row["Etapa"].ToString(),
                        Cantidad = row["cantidad"].ToString(),
                    };

                    lst.Add(reporte);
                }
            }
            // var data = lst
            //.GroupBy(p => p.Etapa)
            //.Select(g => g.FirstOrDefault())
            //.ToArray();

            String[] categorias = lst.Select(s => s.Etapa).Distinct().ToArray();
            String[] estados = lst.Select(s => s.Estado).Distinct().ToArray();
            List<GraficoItem2Bean> lGrafic = new List<GraficoItem2Bean>();
            foreach (var es in estados)
            {
                GraficoItem2Bean eGraf = new GraficoItem2Bean();
                eGraf.name = es;
                int j = 0;
                Decimal[] dataEt = new Decimal[categorias.Length];
                foreach (var cat in categorias)
                {
                    var cant = lst.Find(x => x.Estado == es && x.Etapa == cat);
                    if (cant != null)
                    {
                        dataEt[j] = Decimal.Parse(cant.Cantidad);
                    }
                    else
                    {
                        dataEt[j] = 0;
                    }
                    j++;
                }
                eGraf.data = dataEt;
                lGrafic.Add(eGraf);
            }
            GraficoBean lPadreGrafic = new GraficoBean { categorias = categorias, itemsArr = lGrafic };
            return lPadreGrafic;
        }
    }
}
