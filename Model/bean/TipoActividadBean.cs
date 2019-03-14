using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class TipoActividadBean
    {
        public int item { get; set; }
        public Int64 id { get; set; }
        public String codigo { get; set; }
        public String nombre { get; set; }
        public Int64 idNegocio { get; set; }
        public String canal { get; set; }
        public String meta { get; set; }
        public string total { get; set; }
        public String Flag { get; set; }
        public int page { get; set; }
        public int rows { get; set; }
        public string oportunidad { get; set; }
        public string contacto { get; set; }
    }
}
