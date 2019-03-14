using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Controller.functions.excel
{
    public class ExcelFileWorksheet
    {
        
        public String sheetTitle { get; set; }
        public String sheetName { get; set; }
        public DataTable dtSource { get; set; }
        public DataSet dsSource { get; set; }
        public List<String> columnHeader { get; set; }
        public List<String> columnFormat { get; set; }

        public ExcelFileWorksheet()
        {   sheetTitle = "";
            sheetName = "";
            dsSource = new DataSet();
            dtSource = new DataTable();
            columnHeader = new List<String>();
            columnFormat = new List<String>();
        }

    }
}
