using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class GeocercaBean
    {
        public String id { get; set; }
        public String nombre { get; set; }
        public String Descripcion { get; set; }
        public String Puntos { get; set; }
        public String FlagHabilitado { get; set; }
        public String Rectangulo { get; set; }
        public List<GeocercaPuntosBean> LstGeocercaPuntosBean { get; set; }


        public GeocercaBean()
        {   
            id = "";
            nombre="";
            Descripcion = String.Empty;
            Puntos = String.Empty;
            FlagHabilitado = String.Empty;
            Rectangulo = String.Empty;
        
        }
    }

    public class GeocercaPuntosBean
    {
        public String latitud { get; set; }
        public String longitud { get; set; }



        public GeocercaPuntosBean()
        {
            latitud = "";

            longitud = "";

        }
    }
}
