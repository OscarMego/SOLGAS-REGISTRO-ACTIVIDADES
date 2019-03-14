using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class PaginateOportunidadBean
    {
        public List<OportunidadBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }

        public PaginateOportunidadBean()
        {   
            lstResultados = new List<OportunidadBean>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
