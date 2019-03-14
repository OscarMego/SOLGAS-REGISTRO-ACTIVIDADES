using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class PaginateGrupoBean_1
    {
        public List<GrupoBean_1> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }

        public PaginateGrupoBean_1()
        {
            lstResultados = new List<GrupoBean_1>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
