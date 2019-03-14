using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class Tipo
    {
        private String _nombre;
        private List<Recurso> _recursos;

        public String Nombre
        {
            get { return _nombre; }
            set { _nombre = value; }
        }
        public List<Recurso> Recursos {
            get { return _recursos; }
            set { _recursos = value; }
        }
    }
}
