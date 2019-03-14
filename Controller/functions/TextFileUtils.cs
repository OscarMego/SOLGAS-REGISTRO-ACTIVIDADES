using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;
using System.Web;

namespace Controller.functions
{
    public class TextFileUtils
    {

        public static void ExportToTextFile(DataTable dt, string fileName)
        {
            HttpContext context = HttpContext.Current;
            context.Response.Clear();

            foreach (DataRow row in dt.Rows)
            {
                for (int i = 0; i < dt.Columns.Count; i++)
                { context.Response.Write(row[i].ToString() + ","); }
                context.Response.Write(Environment.NewLine);
            }

            DateTime date = DateTime.Now;
            context.Response.ContentType = "text/csv";
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + "_" + date.Date.ToString("yyyyMMdd") + "_" + date.Hour + date.Minute + date.Millisecond + ".txt");
            context.Response.End();
        }

        public static void createTextFile(DataTable dt, String path, String fileName)
        {
            StringBuilder sb = new StringBuilder();
            if (dt.Columns.Count != 0)
            {
                //foreach (DataColumn column in dt.Columns)
                //{ sb.Append(column.ColumnName + ','); }
                //sb.Append("\r\n");

                foreach (DataRow row in dt.Rows)
                {
                    foreach (DataColumn column in dt.Columns)
                    { sb.Append(row[column].ToString() + '|'); }

                    sb.Append("\r\n");
                }
            }

            String fileLocation = path + "/" + fileName + ".txt";
            System.IO.File.WriteAllText(fileLocation, sb.ToString());

        }
    }
}
