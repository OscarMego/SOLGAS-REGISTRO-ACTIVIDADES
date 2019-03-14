using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class PaginateUsuarioBean
    {
        public List<UsuarioBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }

        public PaginateUsuarioBean()
        {   lstResultados = new List<UsuarioBean>();
            totalPages = 0;
            totalrows = 0;
        }

    }
}
