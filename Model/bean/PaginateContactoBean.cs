using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
  public  class PaginateContactoBean
    {
        public List<ContactoBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }

        public PaginateContactoBean()
        {
            lstResultados = new List<ContactoBean>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
