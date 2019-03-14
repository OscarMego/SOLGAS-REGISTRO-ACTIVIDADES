using System;
namespace Model.bean
{
    public class GrupoDetalleBean
    {
        public int IdGrupoDetalle { get; set; }
        public int IdGrupo { get; set; }
        public String Selecc { get; set; }
        public String Codigo { get; set; }
        public String Nombre { get; set; }
        public String IdCodigoDetallePadre { get; set; }
        public String Grupo { get; set; }
        public String Padre { get; set; }
        public String DetallePadre { get; set; }
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
