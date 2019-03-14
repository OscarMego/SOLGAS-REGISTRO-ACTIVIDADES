using System;
using System.Collections.Generic;
using System.Text;

namespace Model.bean
{
    public class ActividadBean
    {
        public ActividadBean()
        {               
            FechaInicio = "";
            FechaFin = "";
            Canal = "";
            Zona = "";
            TipoActividad = "";
            DetalleActividad = "";
            Usuario = "";
            Cliente = "";
        }

        public int page { get; set; }
        public int rows { get; set; }
        public string FechaInicio { get; set; }
        public string FechaFin { get; set; }
        public string Canal { get; set; }
        public string Zona { get; set; }
        public string TipoActividad { get; set;  }
        public string DetalleActividad { get; set; }
        public string Usuario { get; set; }
        public string Cliente { get; set; }
        public List<ComboBean> columnasDinamicas { get; set; }
        public List<controlDinamico> lstControlDinamico { get; set; }
        
    }

}
