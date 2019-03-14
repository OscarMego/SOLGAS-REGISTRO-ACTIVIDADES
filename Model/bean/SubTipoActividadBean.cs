using System;
using System.Collections.Generic;
namespace Model.bean
{
    public class SubTipoActividadBean
    {
        public SubTipoActividadBean()
        {
            IDSubTipoActividad="";
        }


        public String IDSubTipoActividad { get; set; }
        public String Codigo { get; set; }
        public String Descripcion { get; set; }
        public String FlgHabilitado { get; set; }
        public Int64 idtipoactividad { get; set; }
        public String tipoactividad { get; set; }
        public Int64 IdSubTipoActividadPredecesora { get; set; }
        public int TiempoEtapa { get; set; }
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
        public List<SubTipoActividadDetBean> lstControlDinamico { get; set; }
        public List<SubTipoActividadDet2Bean> lstControlDinamico2 { get; set; }
        public String Perfiles { get; set; }
    }
}
