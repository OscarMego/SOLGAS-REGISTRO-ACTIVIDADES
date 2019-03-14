using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model.bean;
using System.Data;
using Model;
using business.functions;

namespace Controller
{
    public class ServiciosController
    {
        public static List<NextelBean> subObtenerNextel(String psIdSupervisor)
        {
            DataTable ldtNextel = NextelModel.fnObtenerNextel(psIdSupervisor);
            List<NextelBean> loLstNextelBean = new List<NextelBean>();

            if (ldtNextel != null && ldtNextel.Rows.Count > 0)
            {
                foreach (DataRow row in ldtNextel.Rows)
                {
                    NextelBean loNextelBean = new NextelBean();
                    loNextelBean.IdOpcion = row["IdOpcion"].ToString();
                    loNextelBean.Descripcion = row["Descripcion"].ToString();
                    loNextelBean.Nextel = row["Nextel"].ToString();
                    loLstNextelBean.Add(loNextelBean);
                }

            }
            return loLstNextelBean;
        }

        public static List<GrupoBean> subObtenerGrupo(String psIdSupervisor)
        {
            DataTable ldtGrupo = null; 
            List<GrupoBean> loLstGrupoBean = new List<GrupoBean>();

            if (ldtGrupo != null && ldtGrupo.Rows.Count > 0)
            {
                foreach (DataRow row in ldtGrupo.Rows)
                {
                    GrupoBean loGrupoBean = new GrupoBean();
                    loGrupoBean.IdOpcion = row["IdOpcion"].ToString();
                    loGrupoBean.Descripcion = row["Descripcion"].ToString();
                    loLstGrupoBean.Add(loGrupoBean);
                }

            }
            return loLstGrupoBean;
        }

        public static PaginateReporteServicioBean subReporteServicios(String nextel, String grupo, String fechaInicio, String horaInicio, String fechaFin, String horaFin, int paginaActual,
                                                    int registroPorPagina, string idSupervisor, String gps, String network, String datos, String wifi)
        {
            PaginateReporteServicioBean loPaginateReporteServicioBean = new PaginateReporteServicioBean();
            DataTable ldtReporteServicios = ServiciosModel.subReporteServicios(nextel, grupo, fechaInicio, horaInicio, fechaFin, horaFin, paginaActual, registroPorPagina, idSupervisor, gps, network,datos,wifi);
            List<ServicioBean> loLstServicioBean = new List<ServicioBean>();

            Int32 liTotal = 0;
            if (ldtReporteServicios != null && ldtReporteServicios.Rows.Count > 0)
            {
                foreach (DataRow row in ldtReporteServicios.Rows)
                {
                    ServicioBean loServicioBean = new ServicioBean();
                    loServicioBean.Nextel = row["Nextel"].ToString();
                    loServicioBean.Nombre = row["Nombre"].ToString();
                    loServicioBean.Fecha = row["Fecha"].ToString();
                    loServicioBean.Estado = row["Estado"].ToString();
                    loServicioBean.Color = row["Color"].ToString();
                    loServicioBean.FlgGpsHabilitado = row["FlgGpsHabilitado"].ToString();
                    loServicioBean.FlgNetworkHabilitado = row["FlgNetworkHabilitado"].ToString();
                    loServicioBean.DatosHabilitado = row["DatosHabilitado"].ToString();
                    loServicioBean.WifiHabilitado = row["WifiHabilitado"].ToString();
                    loServicioBean.TamanioTotal = row["TamanioTotal"].ToString();
                    loServicioBean.Posicion = row["Posicion"].ToString();
                    liTotal = Convert.ToInt32(row["Total"].ToString());
                    loLstServicioBean.Add(loServicioBean);
                }

            }
            loPaginateReporteServicioBean.lstResultados = loLstServicioBean;
            loPaginateReporteServicioBean.totalPages = Utility.calculateNumberOfPages(liTotal, registroPorPagina);

            return loPaginateReporteServicioBean;
        }


        public static DataTable subReporteServiciosXLS(Int64 idUsuario, Int64 idGrupo, DateTime fechaInicio, DateTime fechaFin, Int64 idSupervisor, String gps, String network, String datos, String wifi)
        {
            return ServiciosModel.subReporteServiciosXLS( idUsuario,  idGrupo,  fechaInicio,  fechaFin,  idSupervisor,  gps,  network,  datos,  wifi);
        }

        public static DataTable subReporteResumenVisitaXLS(String fechaInicio, String fechaFin, String idGrupo, String idUsuario, String estado)
        {
            return ServiciosModel.subReporteResumenVisitaXLS(fechaInicio, fechaFin, idGrupo, idUsuario, estado);
        }

        public static DataTable subReporteDetalleVisitaXLS(DateTime fechaInicio, DateTime fechaFin, String idGrupo, String idUsuario, String estado, String PuntoInteres, String Geocerca)
        {
            String lsFechaInicio = fechaInicio.ToString("yyyyMMdd");
            String lsFechaFin = fechaFin.ToString("yyyyMMdd");
            return ServiciosModel.subReporteDetalleVisitaXLS(lsFechaInicio, lsFechaFin, idGrupo, idUsuario, estado, PuntoInteres, Geocerca);
        }
    }
}
