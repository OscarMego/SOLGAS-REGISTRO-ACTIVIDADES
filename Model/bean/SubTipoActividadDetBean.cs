using System;
namespace Model.bean
{
    public class SubTipoActividadDetBean
    {
        public SubTipoActividadDetBean() { 
        }
        public String DesSubTipoActividadDetPadre { get; set; }
        public String Index { get; set; }
        public String TipoControlDescrip { get; set; }
        public String IDSubTipoActividad { get; set; }
        public String IdSubTipoActividadDetalle { get; set; }
        public String Etiqueta { get; set; }
        public String IdTipoControl { get; set; }
        public String CodigoTipoControl { get; set; }
        public String CodigoGeneral { get; set; }
        public String DescripcionGeneral { get; set; }
        public String Modificable { get; set; }
        public String ModificableDescrip
        {
            get
            {
                if (Modificable == "T") { return "SI"; }
                return "NO";
            }
        }
        public String Obligatorio { get; set; }
        public String ObligatorioDescrip
        {
            get
            {
                if (Obligatorio == "T") { return "SI"; }
                return "NO";
            }
        }
        public String MaxCaracter { get; set; }
        public String FlgPadre { get; set; }
        public String IdSubTipoActividadDetPadre { get; set; }
        public String FlgHabilitado { get; set; }
        public String Perfiles { get; set; }
        public String FlgHabilitadoDescrip
        {
            get
            {
                if (FlgHabilitado == "T") { return "SI"; }
                return "NO";
            }
        }
        public String PerfilesDesc { get; set; }
        public int page { get; set; }
        public int rows { get; set; }
    }
    public class SubTipoActividadDet2Bean
    {
        public String Fila { get; set; }
        public String IDSubTipoActividad { get; set; }
        public String IdSubTipoActividadDetalle { get; set; }
        public String Etiqueta { get; set; }
        public String IdTipoControl { get; set; }
        public String CodigoGeneral { get; set; }
        public String Modificable { get; set; }
        public String Obligatorio { get; set; }
        public String MaxCaracter { get; set; }
        public String FlgHabilitado { get; set; }
        public String FlgPadre { get; set; }
        public String IdSubTipoActividadDetPadre { get; set; }
        public String Perfiles { get; set; }
    }
}
