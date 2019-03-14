using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class ComboBean
    {
        public String Codigo { get; set; }
        public String Nombre { get; set; }
        public String Asunto { get; set; }
        public String Mensaje { get; set; }
        
        public ComboBean()
        {
            Codigo = "";
            Nombre = "";
            Asunto = "";
            Mensaje = "";
        }
    }
}
