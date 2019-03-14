using System;
using System.Collections.Generic;
using System.Text;

namespace Model.bean
{
    public class UsuarioBean
    {
        public UsuarioBean()
        {
            IdUsuario = 0; Codigo = "";
            Nombres = ""; Apellidos = ""; LoginUsuario = ""; Email = ""; FlgHabilitado = ""; clave = ""; IdPerfil = 0; IdZona = 0; IdCanal = 0;
            AllIdPerfil = ""; FlgActiveDirectory = "";
        }
        public int item { get; set; }
        public int IdUsuario { get; set; }
        public string Codigo { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string LoginUsuario { get; set; }
        public string Email { get; set; }
        public String Telefono { get; set; }
        public string FlgHabilitado { get; set; }
        public string clave { get; set; }
        public int IdPerfil { get; set; }
        public int IdCanal { get; set; }
        public int IdZona { get; set; }
        public String AllIdPerfil { get; set; }
        public string EditPass { get; set; }
        public string Coordinadores { get; set; }
        public string FlgActiveDirectory { get; set; }

        public string FlgHabilitadoDescrip
        {
            get
            {
                if (FlgHabilitado == "T") { return "SI"; }
                return "NO";
            }
        }
        public String Seleccion { get; set; }
        public int page { get; set; }
        public int rows { get; set; }

        public String Vendedores { get; set; }
        public String IdResultado { get; set; }
        public Dictionary<String, RolBean> hashRol { get; set; }
        public string NombrePerfil { get; set; }
        public string NombreCanal { get; set; }
        public string NombreZona { get; set; }

    }
}
