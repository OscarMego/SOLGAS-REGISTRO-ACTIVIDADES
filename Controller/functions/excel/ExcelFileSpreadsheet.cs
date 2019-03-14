using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Controller.functions.excel
{
    public class ExcelFileSpreadsheet
    {
        public String propertyTitle { get; set; }
        public String propertyAuthor { get; set; }
        public List<ExcelFileWorksheet> worksheets { get; set; }

        public ExcelFileSpreadsheet()
        {   propertyTitle = "";
            propertyAuthor = "Nextel del Peru S.A.";
            worksheets = new List<ExcelFileWorksheet>();
        }

    }
}
