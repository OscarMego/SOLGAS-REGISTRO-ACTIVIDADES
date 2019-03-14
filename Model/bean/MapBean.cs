using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.bean
{
    public class MapBean
    {
        public List<PointBean> puntos { get; set; }
        public List<GroupPolylineBean> grouppolylines { get; set; }

        public MapBean()
        {

        }
    }


    public class PointBean
    {
        public String latitud { get; set; }
        public String longitud { get; set; }
        public String colorIcono { get; set; }
        public String colorTexto { get; set; }
        public String idCorrelativo { get; set; }
        public String textoIcono { get; set; }
        public String kms { get; set; }
        public String msg { get; set; }
        public String img { get; set; }
        public String titulo { get; set; }
        public String precision { get; set; }
        public List<FiltroBean> filtros { get; set; }
        public String flgMovGeocerca { get; set; }

        public PointBean()
        {
            latitud = "";
            longitud = "";
            msg = "";
            img = "";
            titulo = "";
            precision = "";
            colorIcono = "";
            idCorrelativo = "";
            filtros = new List<FiltroBean>();
            flgMovGeocerca = "";
        }

        public class FiltroBean
        {
            public String descripcion { get; set; }
        }

    }

    public class GroupPolylineBean
    {
        public String color { get; set; }
        public List<PolylineBean> polylines { get; set; }

        public GroupPolylineBean()
        {
        }
    }
    public class PolylineBean
    {
        public String latitud { get; set; }
        public String longitud { get; set; }
        public String color { get; set; }

        public PolylineBean()
        {
            latitud = "";
            longitud = "";
        }
    }
}
