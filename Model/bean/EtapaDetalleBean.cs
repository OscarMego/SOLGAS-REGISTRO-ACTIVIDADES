using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class EtapaDetalleBean
    {
        public EtapaDetalleBean()
        {
            IdEtapa = "";
	        IdEtapaDetalle = 0;
	        Id = 0;
	        Etiqueta = "";
	        TipoControl = "";
	        MaxCaracter = "";
	        Grupo = "";
	        Obligatorio = "";
	        Modificable = "";
	        FlgHabilitado = "";
        }
        public string IdEtapa { get; set; }
        public int IdEtapaDetalle { get; set; }
        public int Id { get; set; }
        public string Etiqueta { get; set; }
        public string TipoControl { get; set; }
        public string MaxCaracter { get; set; }
        public string Grupo { get; set; }
        public string Obligatorio { get; set; }
        public string Modificable { get; set; }
        public string FlgHabilitado { get; set; }
        public String Perfiles { get; set; }
    }
}
