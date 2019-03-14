using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class Recurso
    {
        public static readonly String ESTADO_ACTIVO = "A";
        public static readonly String ESTADO_HABILITADO = "T";
        public static readonly String ESTADO_DESHABILITADO = "F";
        public static readonly String ESTADO_INACTIVO = "I";

        private String _descripcion;
        private String _url;
        private String _estado;

        public String Descripcion
        {
            get { return _descripcion; }
            set { _descripcion = value; }
        }
        public String URL
        {
            get { return _url; }
            set { _url= value; }
        }
        public String Estado
        {
            get { return _estado; }
            set { _estado = value; }
        }
    }
}
