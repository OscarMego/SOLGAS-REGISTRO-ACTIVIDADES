using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class PaginateTipoActividadBean
    {
        public List<TipoActividadBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }

        public PaginateTipoActividadBean()
        {
            lstResultados = new List<TipoActividadBean>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
