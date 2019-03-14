using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Controller
{
    public class TrackingController
    {
        public static List<ReporteBean> getReporteTrackingBean(String fecha, String coordinador, String jefeventa,
           String supervisor, String grupo, String vendedor, String tipo)
        {
            DataTable dt = TrackingModel.ReporteTracking(fecha, coordinador, jefeventa, supervisor, grupo, vendedor, tipo);
            var lst = new List<ReporteBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var reporte = new ReporteBean();
                    reporte.tipo = row["tipo"].ToString();
                    reporte.codigo = row["CODIGO"].ToString();
                    reporte.codigoVendedor = row["CODIGOVENDEDOR"].ToString();
                    reporte.vendedor = row["VENDEDOR"].ToString();
                    reporte.codigoCliente = row["CODIGOCLIENTE"].ToString();
                    reporte.cliente = row["CLIENTE"].ToString();
                    reporte.montoTotal = row["MONTO_TOTAL"].ToString();
                    reporte.motivo = row["MOTIVO"].ToString();
                    reporte.latitud = row["LATITUD"].ToString();
                    reporte.longitud = row["LONGITUD"].ToString();

                    lst.Add(reporte);
                }

            }
            return lst;
        }
        public static DataTable getReporteTrackingDataTable(String fecha, String coordinador, String jefeventa,
           String supervisor, String grupo, String vendedor, String tipo)
        {
            return TrackingModel.ReporteTracking(fecha, coordinador, jefeventa, supervisor, grupo, vendedor, tipo);
        }

        public static MapBean getReporteTracking(List<ReporteBean> lst/*String fecha, String coordinador, String jefeventa,
           String supervisor, String grupo, String vendedor, String tipo*/)
        {
            MapBean beMap = new MapBean();
            List<PointBean> listaPoint = new List<PointBean>();
            //DataTable dt = TrackingModel.ReporteTracking(fecha, coordinador, jefeventa, supervisor, grupo, vendedor, tipo);

            String visita = "";
            String celda = "";
            int rowindex = 1;

            foreach (ReporteBean dr in lst)
            {
                PointBean be = new PointBean();
                be.latitud = dr.latitud;
                be.longitud = dr.longitud;
                
                be.msg = "<h4>" + dr.vendedor + "</h4>";
                if (dr.tipo == "VENTA")
                {
                    be.img = "../../images/gps/pedido.png";
                }
                else
                {
                    be.img = "../../images/gps/no-pedido.png";
                }

                be.titulo = "SECUENCIA " + rowindex++; ;

                listaPoint.Add(be);
            }
            beMap.puntos = listaPoint;
            return beMap;
        }

    }
}
