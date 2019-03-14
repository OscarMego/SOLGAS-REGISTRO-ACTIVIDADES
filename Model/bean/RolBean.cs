using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
   public class RolBean

    {
        public String IdMenu { get; set; }
        public String IdMenuPadre { get; set; }
        public List<RolBean> listaRolHijos { get; set; }
        public String FlgCrear {get; set;}
        public String FlgVer { get; set; }
        public String FlgEditar { get; set; }
        public String FlgEliminar { get; set; }
        public String DescripcionMenu { get; set; }
    }
}
