using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class NextelBean
    {
        private String _IdOpcion;
        private String _Descripcion;
        private String _Nextel;
        
        public String IdOpcion
        {
            get { return _IdOpcion; }
            set { _IdOpcion = value; }
        }

        public String Descripcion
        {
            get { return _Descripcion; }
            set { _Descripcion = value; }
        }

        public String Nextel
        {
            get { return _Nextel; }
            set { _Nextel = value; }
        }

    }
}
