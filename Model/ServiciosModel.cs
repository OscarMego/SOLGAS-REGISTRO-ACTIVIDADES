using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;


namespace Model
{
    public class ServiciosModel
    {
        public static DataTable subReporteServicios(String nextel, String grupo, String fechaInicio, String horaInicio, String fechaFin, String horaFin, int paginaActual,
                                                    int registroPorPagina, string idSupervisor, String gps, String network, String datos, String wifi)
        {

            try
            {
                ArrayList allParameters = new ArrayList();

                SqlParameter parameter;

                parameter = new SqlParameter("@Nextel", SqlDbType.VarChar, 20);
                parameter.Value = nextel;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
                parameter.Value = fechaInicio;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@HoraInicio", SqlDbType.VarChar, 5);
                parameter.Value = horaInicio;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
                parameter.Value = fechaFin;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@HoraFin", SqlDbType.VarChar, 5);
                parameter.Value = horaFin;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@Grupo", SqlDbType.VarChar, 20);
                parameter.Value = grupo;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@PIV_PAG_ACTUAL", SqlDbType.Int);
                parameter.Value = paginaActual;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@PIV_NUMERO_REGISTROS", SqlDbType.Int);
                parameter.Value = registroPorPagina;
                allParameters.Add(parameter);



                parameter = new SqlParameter("@IdSupervisor", SqlDbType.BigInt);
                parameter.Value = idSupervisor;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagGps", SqlDbType.VarChar, 2);
                parameter.Value = gps;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagNetwork", SqlDbType.VarChar, 2);
                parameter.Value = network;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagDatos", SqlDbType.VarChar, 2);
                parameter.Value = datos;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagWifi", SqlDbType.VarChar, 2);
                parameter.Value = wifi;
                allParameters.Add(parameter);

                return SqlConnector.getDataTable("spS_RepSelServiciosActivos", allParameters);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //TODO: cambiar por el Service
        public static DataTable subReporteServiciosXLS(Int64 idUsuario, Int64 idGrupo, DateTime fechaInicio, DateTime fechaFin, Int64 idSupervisor, String gps, String network, String datos, String wifi)
        {

            try
            {
                ArrayList allParameters = new ArrayList();

                SqlParameter parameter;

                parameter = new SqlParameter("@IdUsuario", SqlDbType.BigInt);
                parameter.Value = idUsuario;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FechaInicio", SqlDbType.DateTime);
                parameter.Value = fechaInicio;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FechaFin", SqlDbType.DateTime);
                parameter.Value = fechaFin;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@IdGrupo", SqlDbType.BigInt);
                parameter.Value = idGrupo;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@IdSupervisor", SqlDbType.BigInt);
                parameter.Value = idSupervisor;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagGpsHabilitado", SqlDbType.Char, 2);
                parameter.Value = gps;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagNetworkHabilitado", SqlDbType.Char, 2);
                parameter.Value = network;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagDatosHabilitado", SqlDbType.Char, 2);
                parameter.Value = datos;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagWifiHabilitado", SqlDbType.Char, 2);
                parameter.Value = wifi;
                allParameters.Add(parameter);

                return SqlConnector.getDataTable("spS_RepSelServiciosActivosExcel", allParameters);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable subReporteResumenVisitaXLS(String fechaInicio, String fechaFin, String idGrupo, String idUsuario, String Estado)
        {

            try
            {
                ArrayList allParameters = new ArrayList();

                SqlParameter parameter;
                
                parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
                parameter.Value = fechaInicio;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
                parameter.Value = fechaFin;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@IdGrupo", SqlDbType.VarChar, 2000);
                parameter.Value = idGrupo;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@IdUsuario", SqlDbType.VarChar, 2000);
                parameter.Value = idUsuario;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@IdEstado", SqlDbType.VarChar, 200);
                parameter.Value = Estado;
                allParameters.Add(parameter);

                return SqlConnector.getDataTable("spS_RepSelResumenVisitaActivasExcel", allParameters);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable subReporteDetalleVisitaXLS(String fechaInicio, String fechaFin, String idGrupo, String idUsuario, String Estado, String PuntoInteres, String Geocerca)
        {

            try
            {
                ArrayList allParameters = new ArrayList();

                SqlParameter parameter;

                parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
                parameter.Value = fechaInicio;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
                parameter.Value = fechaFin;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@IdGrupo", SqlDbType.VarChar, 2000);
                parameter.Value = idGrupo;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@IdUsuario", SqlDbType.VarChar, 2000);
                parameter.Value = idUsuario;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@IdEstado", SqlDbType.VarChar, 200);
                parameter.Value = Estado;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagPuntoInteres", SqlDbType.VarChar, 200);
                parameter.Value = PuntoInteres;
                allParameters.Add(parameter);

                parameter = new SqlParameter("@FlagGeoCerca", SqlDbType.VarChar, 200);
                parameter.Value = Geocerca;
                allParameters.Add(parameter);

                return SqlConnector.getDataTable("spS_RepSelVisitaActivasExcel", allParameters);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
