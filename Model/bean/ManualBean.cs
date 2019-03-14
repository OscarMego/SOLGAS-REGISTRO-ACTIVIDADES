using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class ManualBean
    {
        private String _IdManual;
        private String _Descripcion;
        private String _Url;
        private String _Formato;
        private String _Codigo;

        public String Codigo
        {
            get { return _Codigo; }
            set { _Codigo = value; }
        }

        public String IdManual
        {
            get { return _IdManual; }
            set { _IdManual = value; }
        }
        
        public String Descripcion
        {
            get { return _Descripcion; }
            set { _Descripcion = value; }
        }

        public String Url
        {
            get { return _Url; }
            set { _Url = value; }
        }

        public String Formato
        {
            get { return _Formato; }
            set { _Formato = value; }
        }
    }
}
