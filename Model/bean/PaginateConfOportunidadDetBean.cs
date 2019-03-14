using System;
using System.Collections.Generic;
namespace Model.bean
{
    public class PaginateConfOportunidadDetBean
    {
        public List<SubTipoActividadDetBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }
        public PaginateConfOportunidadDetBean() { lstResultados = new List<SubTipoActividadDetBean>(); totalPages = 0; totalrows = 0; }
    }
}
