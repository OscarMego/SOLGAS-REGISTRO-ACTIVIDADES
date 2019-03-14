using System;
using System.Collections.Generic;
namespace Model.bean
{
    public class PaginatePerfilBean
    {
        public List<PerfilBean> lstResultados
        {
            get;
            set;
        }
        public Int32 totalPages
        {
            get;
            set;
        }
        public Int32 totalrows
        {
            get;
            set;
        }
        public PaginatePerfilBean()
        {
            lstResultados = new List<PerfilBean>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
