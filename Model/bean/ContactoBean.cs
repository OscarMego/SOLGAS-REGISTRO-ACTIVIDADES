using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class ContactoBean
    {
        public Int64 IdContacto { get; set; }
        public String Nombre { get; set; }
        public String Telefono { get; set; }
        public String Email { get; set; }
        public String Cargo { get; set; }
        public Int64 IdCliente { get; set; }
        public String Cliente { get; set; }
        public Int64 IdZona { get; set; }
        public Int64 IdClienteInstalacion { get; set; }
        public String Zona { get; set; }

        public String Flag { get; set; }
        public int page { get; set; }
        public int rows { get; set; }
    }
}
