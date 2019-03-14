using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class GeneralTipoBean
    {
        public int item { get; set; }
        public Int64 IdGeneral { get; set; }
        public int IdTipo { get; set; }
        public String Tipo { get; set; }
        public String Codigo { get; set; }
        public String Nombre { get; set; }
        public String Flag { get; set; }
        public int page { get; set; }
        public int rows { get; set; }
    }
}
