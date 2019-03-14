using System;
using System.Collections.Generic;
using System.Text;

namespace Model.bean
{
    public class OportunidadBean
    {
        public OportunidadBean()
        {
            TipoReporte = "";
            Fecha = "";
            Latitud = "";
            Longitud = "";
            Contacto = "";
            Telefono = "";
            Email = "";
            Cargo = "";

            Campo = "";
            Zona = "";
            Canal = "";
            TipoActividad = "";
            DetalleActividad = "";
            IdConfiguracionoportunidadDetalle = 0;
            FechaInicio = "";
            FechaFin = "";
            Cliente = "";
            Usuario = "";
            Coordinador = "";
            Responsable = "";
            Etapa = "";
            Estado = "";
            FlgHabilitado = "";

            Codigo = "";
            FechaRegistro = "";
            Fuente = "";
            Rubro = "";
            TMAnio = "";
            Mes = 0;
            Anio = 0;
            idNegocio = "";
            idContacto = "";
            observaciones = "";
        }
        public String TipoReporte { get; set; }
         public String Fecha { get; set; }
        public String Latitud { get; set; }
         public String Longitud { get; set; }
         public String Contacto  { get; set; }
         public String Telefono  { get; set; }
         public String  Email { get; set; }
         public String Cargo { get; set; }
        public String Campo { get; set; }
        public String Usuario { get; set; }
        public String Zona { get; set; }
        public String TipoActividad { get; set; }
        public String DetalleActividad { get; set; }
        public String Cantidad { get; set; }
        public String txtcontrol { get; set; }
        public String idPadre { get; set; }
        public String ConfRep { get; set; }
        public String TiempoEtapa { get; set; }
        public String TiempoEtapaEjecutado { get; set; }
        public String Retrazo { get; set; }
        public String Cerrar { get; set; }
        public String eliminar { get; set; }
        public String CambiaEtapa { get; set; }
        public String idTipoControl { get; set; }
        public String ResponsableNombre { get; set; }
        public String idEtapaSiguiente { get; set; }
        public String idEtapa { get; set; }
        public int IdConfiguracionoportunidadDetalle { get; set; }
        public String id { get; set; }
        public String CliExist { get; set; }
        public String ConfOpor { get; set; }
        public String RazonSocial { get; set; }
        public String Ruc { get; set; }
        public String Region { get; set; }
        public String Canal { get; set; }
        public String CodCliente { get; set; }
        public string Etiqueta { get; set; }
        public string FechaInicio { get; set; }
        public string FechaFin { get; set; }
        public string Cliente { get; set; }
        public string Coordinador { get; set; }
        public string Responsable { get; set; }
        public string Etapa { get; set; }
        public string EtapaSiguiente { get; set; }
        public string Estado { get; set; }
        public string FlgHabilitado { get; set; }

        public string FechaEstimadaInicio { get; set; }
        public string FechaEstimadaFin { get; set; }
        public String IdFoto { get; set; }
        public String UsuSession { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public string FechaRegistro { get; set; }
        public string Fuente { get; set; }
        public string Rubro { get; set; }
        public string TMAnio { get; set; }
        public int Mes { get; set; }
        public int Anio { get; set; }

        public int page { get; set; }
        public int rows { get; set; }

        public string IdOportunidad { get; set; }
        public string ExisteCliente { get; set; }
        public string IdEtapaActual { get; set; }
        public string etapaActual { get; set; }
        public string IdEstadoActual { get; set; }
        public string estadoActual { get; set; }
        public string IdUsuarioResponsable { get; set; }
        public string usuarioResponsable { get; set; }
        public string ValorControl { get; set; }
        public string CodigoTipoControl { get; set; }
        public string CodigoGeneral { get; set; }
        public string Modificable { get; set; }
        public string Obligatorio { get; set; }
        public string MaxCaracter { get; set; }

        public string idContacto { get; set; }
        public string idNegocio { get; set; }
        public string observaciones { get; set; }
        public string IdConfiguracionOportunidad { get; set; }
        public String IdEtapaDetalle { get; set; }
        public List<ComboBean> columnasDinamicas { get; set; }
        public List<controlDinamico> lstControlDinamico { get; set; }
        public DateTime fecha { get; set; }
        public string latitud { get; set; }
        public string longitud { get; set; }
        public String tipoTotal { get; set; }

    }

    public class controlDinamico
    {
        public String id { get; set; }
        public String valor { get; set; }
    }
}
