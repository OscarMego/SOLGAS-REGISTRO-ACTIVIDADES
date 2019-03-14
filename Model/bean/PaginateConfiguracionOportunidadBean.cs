using System;
using System.Collections.Generic;
namespace Model.bean
{
    public class PaginateConfiguracionOportunidadBean
    {
        public List<SubTipoActividadBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }
        public PaginateConfiguracionOportunidadBean() { lstResultados = new List<SubTipoActividadBean>(); totalPages = 0; totalrows = 0; }
    }
}
