using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class PaginateEtapaBean
    {
        public List<EtapaBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }

        public PaginateEtapaBean()
        {   lstResultados = new List<EtapaBean>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
