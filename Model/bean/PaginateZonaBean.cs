using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class PaginateZonaBean
    {
        public List<ZonaBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }

        public PaginateZonaBean()
        {
            lstResultados = new List<ZonaBean>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
