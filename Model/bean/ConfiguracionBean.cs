using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class ConfiguracionBean
    {
        public String Codigo {get; set;}
        public String Descripcion { get; set; }
        public String Tipo { get; set; }
        public String TipoPadre { get; set; }
        public String Valor { get; set; }
        public String FlagHabilitado { get; set; }
        public Int16 Orden { get; set; }

        public ConfiguracionBean()
        {
            Codigo = String.Empty;
            Descripcion = String.Empty;
            Tipo = String.Empty;
            TipoPadre = String.Empty;
            Valor = String.Empty;
            FlagHabilitado = String.Empty;
            Orden = 0;
        }

    }
}
