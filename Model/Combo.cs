using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class Combo
    {
        public String Codigo { get; set; }
        public String Nombre { get; set; }
        public String Asunto { get; set; }
        public String Mensaje { get; set; }

        public Combo()
        {
            Codigo = "";
            Nombre = "";
            Asunto = "";
            Mensaje = "";
        }
    }
}
