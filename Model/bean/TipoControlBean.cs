using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class TipoControlBean
    {
        public TipoControlBean()
        {
            Id = 0; Codigo = ""; Nombre = ""; FlgHabilitado = "";
        }

        public int Id { get; set; }
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public string FlgHabilitado { get; set; }
    }
}
