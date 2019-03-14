using System;
namespace Model.bean
{
    public class PerfilBean
    {
        public PerfilBean()
        {
            IdPerfil = 0;
            Nombre = "";
            Descripcion = "";
            FlgHabilitado = "";
        }
        public int item
        {
            get;
            set;
        }
        public int IdPerfil
        {
            get;
            set;
        }
        public string Nombre
        {
            get;
            set;
        }
        public string Descripcion
        {
            get;
            set;
        }
        public string FlgHabilitado
        {
            get;
            set;
        }
        public string FlgHabilitadoDescrip
        {
            get
            {
                if (FlgHabilitado == "T")
                {
                    return "SI";
                }
                return "NO";
            }
        }
        public int page
        {
            get;
            set;
        }
        public int rows
        {
            get;
            set;
        }

        public string Seleccion { get; set; }
    }
}
