using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class MenuBean
    {
        private String _IdMenu;
        private String _IdMenuPadre;
        private String _Descripcion;
        private String _Url;
        private String _UrlImagen;
        private String _Codigo;

        public String IdMenu
        {
            get { return _IdMenu; }
            set { _IdMenu = value; }
        }
        
        public String IdMenuPadre
        {
            get { return _IdMenuPadre; }
            set { _IdMenuPadre = value; }
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

        public String UrlImagen
        {
            get { return _UrlImagen; }
            set { _UrlImagen = value; }
        }

        public String Codigo
        {
            get { return _Codigo; }
            set { _Codigo = value; }
        }

    }
}
