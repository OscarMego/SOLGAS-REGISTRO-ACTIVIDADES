using System;
using System.Collections.Generic;
namespace Model.bean
{
    public class PaginateGrupoBean
    {
        public List<GrupoBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }
        public PaginateGrupoBean() { lstResultados = new List<GrupoBean>(); totalPages = 0; totalrows = 0; }
    }
}
