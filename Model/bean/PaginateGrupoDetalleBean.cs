using System;
using System.Collections.Generic;
namespace Model.bean
{
    public class PaginateGrupoDetalleBean
    {
        public List<GrupoDetalleBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }
        public PaginateGrupoDetalleBean()
        {
            lstResultados = new List<GrupoDetalleBean>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
