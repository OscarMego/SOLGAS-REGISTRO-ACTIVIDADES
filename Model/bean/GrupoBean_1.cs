using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class GrupoBean_1
    {
        public String codigo { get; set; }
        public String seleccion { get; set; }
        public String id { get; set; } // ID Supervisor
        public String Descripcion { get; set; }
        public String geocerca { get; set; }
        public String flagHabilitado { get; set; }
        private String _IdResultado;
        public String Tipo { get; set; }
        private String _IdOpcion;
        public String Item { get; set; }
        public string TipoDescrip
        {
            get
            {
                if (Tipo == "1") { return "Grupo"; }
                if (Tipo == "2") { return "Motivo"; }
                if (Tipo == "3") { return "Giro"; }
                return "";
            }
        }

        public String diaCapturaPosiciones { get; set; }
        public String horaInicioCaptura { get; set; }
        public String horaFinCaptura { get; set; }
        public String horaSincroAutomatica { get; set; }
        public String tiempoEntreEnvioPosiciones { get; set; }


        public String IdOpcion
        {
            get { return _IdOpcion; }
            set { _IdOpcion = value; }
        }

         public String IdResultado
        {
            get { return _IdResultado; }
            set { _IdResultado = value; }
        }

         public GrupoBean_1()
        {
            id = "";
            Descripcion = "";
            geocerca = "";
            flagHabilitado = "";
            _IdResultado = "0";
        }

         public int page { get; set; }
         public int rows { get; set; }
    }
}
