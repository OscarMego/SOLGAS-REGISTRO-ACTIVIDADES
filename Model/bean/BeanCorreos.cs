using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class BeanCorreos
    {
        private String _asunto;
        private String _msj;
        private String _email;
        public String tipo { get; set; }
        public String asunto
        {
            get { return _asunto; }
            set { _asunto = value; }
        }

        public String msj
        {
            get { return _msj; }
            set { _msj = value; }
        }

        public String email
        {
            get { return _email; }
            set { _email = value; }
        }
    }
    public class BeanConfiguracion
    {
        private String _servidorCorreos;
        private int _puerto;
        private String _usuarioCorreo;
        private String _contrasena;

        public String servidorCorreos
        {
            get { return _servidorCorreos; }
            set { _servidorCorreos = value; }
        }

        public int puerto
        {
            get { return _puerto; }
            set { _puerto = value; }
        }

        public String usuarioCorreo
        {
            get { return _usuarioCorreo; }
            set { _usuarioCorreo = value; }
        }
        public String contrasena
        {
            get { return _contrasena; }
            set { _contrasena = value; }
        }
    }
}