using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class EtapaBean
    {
        public EtapaBean()
        {
            Etapa = ""; 
            FlgHabilitado = "";

            IdEtapa = 0;
            CodEtapa = "";
            CodEtapaDetalle = "";
            Descripcion = "";  
		    EtapaPredecesora = "";
            IdEtapaPredecesora = ""; 
		    TiempoEtapa = ""; 
		    FechaRegistro = "";

            Id = 0;
            Etiqueta = "";
            TipoControlDescrip = "";
            MaxCaracter = "";
            Grupo = "";
            FlgObligatorio = "";
            FlgModificable = "";
            TipoControl = "";

            IdEtapaDetalle = 0;
            
        }

        public String CodigoTipoControl { get; set; }
        public String IdGeneral { get; set; }
        public string Etapa { get; set; }
        public string FlgHabilitado { get; set; }
        public string seleccion { get; set; }

        public int IdEtapa { get; set; }
        public string CodEtapa { get; set; }
        public string CodEtapaDetalle { get; set; }
        public string Descripcion  { get; set; }
        public string IdEtapaPredecesora { get; set; }
        public string EtapaPredecesora  { get; set; }
        public string TiempoEtapa  { get; set; }
        public string FechaRegistro  { get; set; }

        public int Id { get; set; }
        public int Id2 { get; set; }
        public string Etiqueta { get; set; }
        public string TipoControlDescrip { get; set; }
        public string MaxCaracter { get; set; }
        public string Grupo { get; set; }
        public string FlgObligatorio { get; set; }
        public string FlgModificable { get; set; }

        public int IdEtapaDetalle { get; set; }

        public string FlgObligatorioDescrip
        {
            get
            {
                if (FlgObligatorio == "T") { return "SI"; }
                return "NO";
            }
        }

        public string FlgModificableDescrip
        {
            get
            {
                if (FlgModificable == "T") { return "SI"; }
                return "NO";
            }
        }

        public string TipoControl { get; set; }
        
        public int page { get; set; }
        public int rows { get; set; }

        public String IdResultado { get; set; }
        public Dictionary<String, RolBean> hashRol { get; set; }

        public List<PerfilBean> Perfiles { get; set; }
        public String PerfilesCont { get; set; }
        public String PerfilesDescrip { get; set; }
    }
}
