using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class PaginateClienteBean
    {
        public List<ClienteBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }
        public PaginateClienteBean()
        {
            lstResultados = new List<ClienteBean>();
            totalPages = 0; 
            totalrows = 0;
        }
    }
}
