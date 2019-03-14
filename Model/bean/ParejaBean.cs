using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class ParejaBean
    {
        public String Clave { get; set; }
        public String Valor { get; set; }

        public ParejaBean()
        {
            Clave = "";
            Valor = "";
        }

        public ParejaBean(String clave, String valor)
        {
            this.Clave = clave;
            this.Valor = valor;
        }
    }
}
