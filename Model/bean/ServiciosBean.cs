using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class ServicioBean
    {
        private String _Nextel;

        public String Nextel
        {
            get { return _Nextel; }
            set { _Nextel = value; }
        }
        private String _Nombre;


        public String Nombre
        {
            get { return _Nombre; }
            set { _Nombre = value; }
        }
        private String _Fecha;


        public String Fecha
        {
            get { return _Fecha; }
            set { _Fecha = value; }
        }
        private String _Estado;


        public String Estado
        {
            get { return _Estado; }
            set { _Estado = value; }
        }
        private String _Color;


        public String Color
        {
            get { return _Color; }
            set { _Color = value; }
        }
        private String _FlgGpsHabilitado;


        public String FlgGpsHabilitado
        {
            get { return _FlgGpsHabilitado; }
            set { _FlgGpsHabilitado = value; }
        }
        private String _FlgNetworkHabilitado;


        public String FlgNetworkHabilitado
        {
            get { return _FlgNetworkHabilitado; }
            set { _FlgNetworkHabilitado = value; }
        }
        private String _DatosHabilitado;

        public String DatosHabilitado
        {
            get { return _DatosHabilitado; }
            set { _DatosHabilitado = value; }
        }
        private String _WifiHabilitado;

        public String WifiHabilitado
        {
            get { return _WifiHabilitado; }
            set { _WifiHabilitado = value; }
        }
        private String _TamanioTotal;

        public String TamanioTotal
        {
            get { return _TamanioTotal; }
            set { _TamanioTotal = value; }
        }

        private String _Posicion;
        public String Posicion
        {
            get { return _Posicion; }
            set { _Posicion = value; }
        }

        private String _Grupo;
        public String Grupo
        {
            get { return _Grupo; }
            set { _Grupo = value; }
        }

        private String _Usuario;
        public String Usuario
        {
            get { return _Usuario; }
            set { _Usuario = value; }
        }

        private String _DesGeo;
        public String DesGeo
        {
            get { return _DesGeo; }
            set { _DesGeo = value; }
        }

        private String _GeoCerca;
        public String GeoCerca
        {
            get { return _GeoCerca; }
            set { _GeoCerca = value; }
        }

        private String _Estados;
        public String Estados
        {
            get { return _Estados; }
            set { _Estados = value; }
        }

        private String _Inicio;
        public String Inicio
        {
            get { return _Inicio; }
            set { _Inicio = value; }
        }

        private String _Ultimo;
        public String Ultimo
        {
            get { return _Ultimo; }
            set { _Ultimo = value; }
        }

        private String _Fotos;
        public String Fotos
        {
            get { return _Fotos; }
            set { _Fotos = value; }
        }

        private String _Punto_Interes;
        public String Punto_Interes
        {
            get { return _Punto_Interes; }
            set { _Punto_Interes = value; }
        }

        private String _Comentario;
        public String Comentario
        {
            get { return _Comentario; }
            set { _Comentario = value; }
        }

        private String _FlagFoto;
        public String FlagFoto
        {
            get { return _FlagFoto; }
            set { _FlagFoto = value; }
        }

        private String _Latitud;
        public String Latitud
        {
            get { return _Latitud; }
            set { _Latitud = value; }
        }

        private String _Longitud;
        public String Longitud
        {
            get { return _Longitud; }
            set { _Longitud = value; }
        }

        private String _IdGrupo;
        public String IdGrupo
        {
            get { return _IdGrupo; }
            set { _IdGrupo = value; }
        }

        private String _IdUsuario;
        public String IdUsuario
        {
            get { return _IdUsuario; }
            set { _IdUsuario = value; }
        }

        public int idRegistro { get; set; }
        public int IdVisita { get; set; }
        public String EIdVisita {  
            get
            {
                if (IdVisita ==0) return "display:none";
                else return "";
            
            }
        }
        public int idvisitaFoto { get; set; }
        public String EidvisitaFoto
        {
            get
            {
                if (idvisitaFoto == 0) return "display:none";
                else return "";

            }
        }
        public String estadoResum { get; set; }

        private String _Ind_Estado;
        public String Ind_Estado
        {
            get { return _Ind_Estado; }
            set { _Ind_Estado = value; }
        }
    }
}
