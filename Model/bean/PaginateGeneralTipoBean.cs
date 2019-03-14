using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.bean
{
    public class PaginateGeneralTipoBean
    {

        public List<GeneralTipoBean> lstResultados { get; set; }
        public Int32 totalPages { get; set; }
        public Int32 totalrows { get; set; }

        public PaginateGeneralTipoBean()
        {
            lstResultados = new List<GeneralTipoBean>();
            totalPages = 0;
            totalrows = 0;
        }
    }
}
