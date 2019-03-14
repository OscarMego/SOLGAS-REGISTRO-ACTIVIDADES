using System;
namespace Model.bean
{
    public class GrupoBean
    {
        public GrupoBean(){
            Codigo = "";
            Nombre="";

        }
        public int IDGrupo { get; set; }
        public String Codigo { get; set; }
        public String Nombre { get; set; }
        public int IdNivel { get; set; }
        public String Nivel { get; set; }
        public String CodigoPadreGrupo { get; set; }
        public String PadreDescrip { get; set; }
        public String tipo { get; set; }
        private String _IdOpcion;
        public String Descripcion { get; set; }
        public String IdOpcion
        {
            get { return _IdOpcion; }
            set { _IdOpcion = value; }
        }
        public String grupoDescrip
        {
            get
            {
                if (tipo == "S") { return "Sistema"; }
                return "General";
            }
        }
        public String tipoStyle
        {
            get
            {
                if (tipo == "S") { return "Display:none"; }
                return "";
            }
        }
        public String FlgHabilitado { get; set; }
        public String FlgHabilitadoDescrip
        {
            get
            {
                if (FlgHabilitado == "T") { return "SI"; }
                return "NO";
            }
        }
        public int page { get; set; }
        public int rows { get; set; }

    }
}
