using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class PaginateReporteServicioBean
    {
         public List<ServicioBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }


        public PaginateReporteServicioBean()
        {
            lstResultados = new List<ServicioBean>();
            totalPages = 0;
            
        }
    }
}
