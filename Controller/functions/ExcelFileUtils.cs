using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Web.UI.WebControls;
using System.Web;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.IO;
using System.Drawing;
using OfficeOpenXml.Drawing;
using System.Globalization;
using System.Threading;


namespace Controller.functions.excel
{
    public class ExcelFileUtils
    {
        public static void ExportToExcel(ExcelFileSpreadsheet spreadsheet, String filename)
        {
            using (ExcelPackage p = new ExcelPackage())
            {
                int contWorksheet = 1;
                int initalCol = 2;
                int initialRow = 2;

                // Ingresamos los datos para las propiedades del archivo Excel
                p.Workbook.Properties.Author = spreadsheet.propertyAuthor;
                p.Workbook.Properties.Title = spreadsheet.propertyTitle;

                foreach (ExcelFileWorksheet worksheet in spreadsheet.worksheets)
                {   // Creamos un Worksheet
                    p.Workbook.Worksheets.Add(worksheet.sheetName);

                    ExcelWorksheet ws = p.Workbook.Worksheets[contWorksheet];
                    ws.Cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    ws.Cells.Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.White);
                    ws.Cells.Style.Font.Size = 10;
                    ws.Cells.Style.Font.Name = "Arial";

                    int colIndex = initalCol;
                    int rowIndex = initialRow;
                    int contHeader = 1;
                    int indexHeader = 0;
                    int contRow = 0;
                    DataTable dt = worksheet.dtSource;

                    if (!worksheet.sheetTitle.Equals(""))
                    {
                        // Unimos celdas para poder colocar el titulo de la grilla a mostrar
                        ws.Cells[colIndex, rowIndex].Value = worksheet.sheetTitle;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Merge = true;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.Font.Size = 12;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.Font.Bold = true;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                        rowIndex = rowIndex + 2;
                    }

                    // Creamos las cabeceras de la grilla
                    foreach (DataColumn dc in dt.Columns)
                    {
                        var cell = ws.Cells[rowIndex, colIndex];
                        cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                        var fill = cell.Style.Fill;
                        fill.PatternType = ExcelFillStyle.Solid;
                        fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#D7D2CB"));

                        var font = cell.Style.Font;
                        font.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        font.Bold = true;

                        var border = cell.Style.Border;
                        border.Top.Style = ExcelBorderStyle.Thin;
                        border.Top.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));


                        if (contHeader == 1)
                        {
                            border.Left.Style = ExcelBorderStyle.Thin;
                            border.Left.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        }

                        if (contHeader < dt.Columns.Count)
                        {
                            border.Right.Style = ExcelBorderStyle.Thin;
                            border.Right.Color.SetColor(System.Drawing.Color.White);
                        }
                        else
                        {
                            border.Right.Style = ExcelBorderStyle.Thin;
                            border.Right.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        }

                        // Colocamos el nombre de la celda en la cabecera
                        cell.Value = worksheet.columnHeader[indexHeader];

                        double cellSize = ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width;
                        double proposedCellSize = cell.Value.ToString().Trim().Length * 1.3;
                        if (cellSize <= proposedCellSize)
                        {
                            ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width = proposedCellSize;
                        }

                        colIndex++;
                        contHeader++;
                        indexHeader++;

                    }

                    contRow = 1;

                    // Agregamos el contenido del DataTable en las celdas de la grilla
                    foreach (DataRow dr in dt.Rows)
                    {
                        colIndex = initalCol;
                        rowIndex++;
                        int contCol = 1;
                        int cellIndex = 0;

                        foreach (DataColumn dc in dt.Columns)
                        {
                            var cell = ws.Cells[rowIndex, colIndex];

                            var fill = cell.Style.Fill;
                            fill.PatternType = ExcelFillStyle.Solid;

                            if (rowIndex % 2 == 0)
                            {
                                fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#ECEEE7"));
                            }

                            String strValue = "";
                            if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.TEXT))
                            {
                                cell.Value = dr[dc.ColumnName].ToString();
                                strValue = cell.Value.ToString();
                            }
                            else
                            {
                                if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.NUMERIC))
                                {
                                    cell.Value = Convert.ToInt32(dr[dc.ColumnName]);
                                    strValue = cell.Value.ToString();
                                }
                                else
                                {
                                    if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.FLOAT))
                                    {
                                        cell.Value = Convert.ToDecimal(dr[dc.ColumnName]);
                                        strValue = cell.Value.ToString();
                                    }
                                    else
                                    {
                                        if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DOUBLE))
                                        {
                                            cell.Value = Convert.ToDouble(dr[dc.ColumnName]);
                                            strValue = cell.Value.ToString();
                                        }
                                        else
                                        {
                                            if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DATE))
                                            {
                                                Thread.CurrentThread.CurrentCulture = new CultureInfo("fr-FR");
                                                DateTime datetime = DateTime.Parse(dr[dc.ColumnName].ToString());
                                                String day = datetime.ToString("dd");
                                                String month = datetime.ToString("MM");
                                                String year = datetime.ToString("yyyy");
                                                cell.Value = day + "/" + month + "/" + year;
                                                strValue = cell.Value.ToString();
                                            }
                                            else
                                            {
                                                if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.TIME))
                                                {
                                                    DateTime datetime = DateTime.Parse(dr[dc.ColumnName].ToString());
                                                    String hora = datetime.ToString("hh");
                                                    String minuto = datetime.ToString("mm");
                                                    cell.Value = hora + ":" + minuto;
                                                    strValue = cell.Value.ToString();
                                                }
                                                else
                                                {
                                                    if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DATETIME))
                                                    {
                                                        cell.Value = dr[dc.ColumnName].ToString();
                                                        strValue = cell.Value.ToString();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                            var border = cell.Style.Border;

                            if (contCol == 1)
                            {
                                border.Left.Style = ExcelBorderStyle.Thin;
                                border.Left.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            if (contCol < dt.Columns.Count)
                            {
                                border.Right.Style = ExcelBorderStyle.Thin;
                                border.Right.Color.SetColor(System.Drawing.Color.White);
                            }
                            else
                            {
                                border.Right.Style = ExcelBorderStyle.Thin;
                                border.Right.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            if (contRow == dt.Rows.Count)
                            {
                                border.Bottom.Style = ExcelBorderStyle.Thin;
                                border.Bottom.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            var font = cell.Style.Font;
                            font.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            font.Bold = false;

                            double cellSize = ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width;
                            double proposedCellSize = strValue.Trim().Length * 1.3;
                            if (cellSize <= proposedCellSize)
                            { ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width = proposedCellSize; }

                            colIndex++;
                            contCol++;
                            cellIndex++;

                        }
                        contRow++;
                    }

                    // Agregamos las imagenes que se incluiran en este Worksheet
                    /*
                    string codigo_color = System.Configuration.ConfigurationManager.AppSettings["codigocolorcss"].ToString();
                    string tema = "entel-excel-";

                    if (codigo_color == "1")
                    {
                        tema = "nextel-excel-";
                    }
                    else if (codigo_color == "2")
                    {
                        tema = "entel-excel-";
                    }
                     */

                    //Bitmap imageDescarga = new Bitmap(logoDescargaPath);

                    //String logoDescargaPath = HttpContext.Current.Server.MapPath("~") + "/images/logo/descarga" + Controller.GeneralController.obtenerTemaActual() + ".png";
                    
                    /*
                    String logoNextelPath = HttpContext.Current.Server.MapPath("~") + "/images/logo/excel" + Controller.GeneralController.obtenerTemaActual() + ".png";
                 
                    Bitmap imageNextel = new Bitmap(logoNextelPath);
                   
                    ExcelPicture pictureNextel = null;
                    //ExcelPicture pictureDescarga = null;

                    if (imageNextel != null)
                    {
                        pictureNextel = ws.Drawings.AddPicture("logoNextel", imageNextel);
                        pictureNextel.From.Column = initalCol - 1;
                        pictureNextel.From.Row = initialRow + contRow + 2;
                        pictureNextel.SetSize(imageNextel.Width - 20, imageNextel.Height);
                    }
                     */ 
                     
                    /*
                    if (imageDescarga != null)
                    {
                        int imgRow = initialRow + contRow + 2;
                        int imgCol = initalCol + (dt.Columns.Count - 1);

                        int cellwidth = ExcelHelper.ColumnWidth2Pixel(ws, ws.Cells[imgRow, imgCol].Worksheet.Column(imgCol).Width);
                        int imagewidth = imageDescarga.Width;
                        int diff = cellwidth - imagewidth;
                        pictureDescarga = ws.Drawings.AddPicture("logoDescarga", imageDescarga);
                        pictureDescarga.SetPosition(imgRow, 0, imgCol - 1, diff);
                        pictureDescarga.SetSize(imageDescarga.Width, imageDescarga.Height);
                    }
                    */
                    contWorksheet++;
                }

                // Generamos el archivo Excel y mostramos el popup de descarga
                Byte[] bin = p.GetAsByteArray();
                DateTime date = DateTime.Now;
                HttpContext context = HttpContext.Current;
                context.Response.Clear();
                context.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "_" + date.Date.ToString("yyyyMMdd") + "_" + date.Hour + date.Minute + date.Millisecond + ".xlsx");
                context.Response.BinaryWrite(bin);
                context.Response.End();
            }
        }
        public static void ExportToExcelColor(ExcelFileSpreadsheet spreadsheet,List<String> colores, String filename)
        {
            using (ExcelPackage p = new ExcelPackage())
            {
                int contWorksheet = 1;
                int initalCol = 2;
                int initialRow = 2;

                // Ingresamos los datos para las propiedades del archivo Excel
                p.Workbook.Properties.Author = spreadsheet.propertyAuthor;
                p.Workbook.Properties.Title = spreadsheet.propertyTitle;

                foreach (ExcelFileWorksheet worksheet in spreadsheet.worksheets)
                {   // Creamos un Worksheet
                    p.Workbook.Worksheets.Add(worksheet.sheetName);

                    ExcelWorksheet ws = p.Workbook.Worksheets[contWorksheet];
                    ws.Cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    ws.Cells.Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.White);
                    ws.Cells.Style.Font.Size = 10;
                    ws.Cells.Style.Font.Name = "Arial";

                    int colIndex = initalCol;
                    int rowIndex = initialRow;
                    int contHeader = 1;
                    int indexHeader = 0;
                    int contRow = 0;
                    DataTable dt = worksheet.dtSource;

                    if (!worksheet.sheetTitle.Equals(""))
                    {
                        // Unimos celdas para poder colocar el titulo de la grilla a mostrar
                        ws.Cells[colIndex, rowIndex].Value = worksheet.sheetTitle;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Merge = true;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.Font.Size = 12;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.Font.Bold = true;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                        rowIndex = rowIndex + 2;
                    }

                    // Creamos las cabeceras de la grilla
                    foreach (DataColumn dc in dt.Columns)
                    {
                        var cell = ws.Cells[rowIndex, colIndex];
                        cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                        var fill = cell.Style.Fill;
                        fill.PatternType = ExcelFillStyle.Solid;
                        fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#D7D2CB"));

                        var font = cell.Style.Font;
                        font.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        font.Bold = true;

                        var border = cell.Style.Border;
                        border.Top.Style = ExcelBorderStyle.Thin;
                        border.Top.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));


                        if (contHeader == 1)
                        {
                            border.Left.Style = ExcelBorderStyle.Thin;
                            border.Left.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        }

                        if (contHeader < dt.Columns.Count)
                        {
                            border.Right.Style = ExcelBorderStyle.Thin;
                            border.Right.Color.SetColor(System.Drawing.Color.White);
                        }
                        else
                        {
                            border.Right.Style = ExcelBorderStyle.Thin;
                            border.Right.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        }

                        // Colocamos el nombre de la celda en la cabecera
                        cell.Value = worksheet.columnHeader[indexHeader];

                        double cellSize = ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width;
                        double proposedCellSize = cell.Value.ToString().Trim().Length * 1.3;
                        if (cellSize <= proposedCellSize)
                        {
                            ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width = proposedCellSize;
                        }

                        colIndex++;
                        contHeader++;
                        indexHeader++;

                    }

                    contRow = 1;

                    // Agregamos el contenido del DataTable en las celdas de la grilla
                    foreach (DataRow dr in dt.Rows)
                    {

                        colIndex = initalCol;
                        rowIndex++;
                        int contCol = 1;
                        int cellIndex = 0;

                        foreach (DataColumn dc in dt.Columns)
                        {
                            var cell = ws.Cells[rowIndex, colIndex];

                            var fill = cell.Style.Fill;
                            fill.PatternType = ExcelFillStyle.Solid;

                            if (rowIndex % 2 == 0)
                            {
                                fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#ECEEE7"));
                            }
                            if (colores[contRow - 1] != "")
                            {
                                fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml(colores[contRow - 1]));
                            } 
                            String strValue = "";
                            if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.TEXT))
                            {
                                cell.Value = dr[dc.ColumnName].ToString();
                                strValue = cell.Value.ToString();
                            }
                            else
                            {
                                if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.NUMERIC))
                                {
                                    cell.Value = Convert.ToInt32(dr[dc.ColumnName]);
                                    strValue = cell.Value.ToString();
                                }
                                else
                                {
                                    if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.FLOAT))
                                    {
                                        cell.Value = Convert.ToDecimal(dr[dc.ColumnName]);
                                        strValue = cell.Value.ToString();
                                    }
                                    else
                                    {
                                        if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DOUBLE))
                                        {
                                            cell.Value = Convert.ToDouble(dr[dc.ColumnName]);
                                            strValue = cell.Value.ToString();
                                        }
                                        else
                                        {
                                            if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DATE))
                                            {
                                                Thread.CurrentThread.CurrentCulture = new CultureInfo("fr-FR");
                                                DateTime datetime = DateTime.Parse(dr[dc.ColumnName].ToString());
                                                String day = datetime.ToString("dd");
                                                String month = datetime.ToString("MM");
                                                String year = datetime.ToString("yyyy");
                                                cell.Value = day + "/" + month + "/" + year;
                                                strValue = cell.Value.ToString();
                                            }
                                            else
                                            {
                                                if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.TIME))
                                                {
                                                    DateTime datetime = DateTime.Parse(dr[dc.ColumnName].ToString());
                                                    String hora = datetime.ToString("hh");
                                                    String minuto = datetime.ToString("mm");
                                                    cell.Value = hora + ":" + minuto;
                                                    strValue = cell.Value.ToString();
                                                }
                                                else
                                                {
                                                    if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DATETIME))
                                                    {
                                                        cell.Value = dr[dc.ColumnName].ToString();
                                                        strValue = cell.Value.ToString();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                            var border = cell.Style.Border;

                            if (contCol == 1)
                            {
                                border.Left.Style = ExcelBorderStyle.Thin;
                                border.Left.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            if (contCol < dt.Columns.Count)
                            {
                                border.Right.Style = ExcelBorderStyle.Thin;
                                border.Right.Color.SetColor(System.Drawing.Color.White);
                            }
                            else
                            {
                                border.Right.Style = ExcelBorderStyle.Thin;
                                border.Right.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            if (contRow == dt.Rows.Count)
                            {
                                border.Bottom.Style = ExcelBorderStyle.Thin;
                                border.Bottom.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            var font = cell.Style.Font;
                            font.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            font.Bold = false;

                            double cellSize = ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width;
                            double proposedCellSize = strValue.Trim().Length * 1.3;
                            if (cellSize <= proposedCellSize)
                            { ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width = proposedCellSize; }

                            colIndex++;
                            contCol++;
                            cellIndex++;

                        }
                        contRow++;
                    }

                    // Agregamos las imagenes que se incluiran en este Worksheet
                    /*
                    string codigo_color = System.Configuration.ConfigurationManager.AppSettings["codigocolorcss"].ToString();
                    string tema = "entel-excel-";

                    if (codigo_color == "1")
                    {
                        tema = "nextel-excel-";
                    }
                    else if (codigo_color == "2")
                    {
                        tema = "entel-excel-";
                    }
                     */

                    //Bitmap imageDescarga = new Bitmap(logoDescargaPath);

                    //String logoDescargaPath = HttpContext.Current.Server.MapPath("~") + "/images/logo/descarga" + Controller.GeneralController.obtenerTemaActual() + ".png";

                    /*
                    String logoNextelPath = HttpContext.Current.Server.MapPath("~") + "/images/logo/excel" + Controller.GeneralController.obtenerTemaActual() + ".png";
                 
                    Bitmap imageNextel = new Bitmap(logoNextelPath);
                   
                    ExcelPicture pictureNextel = null;
                    //ExcelPicture pictureDescarga = null;

                    if (imageNextel != null)
                    {
                        pictureNextel = ws.Drawings.AddPicture("logoNextel", imageNextel);
                        pictureNextel.From.Column = initalCol - 1;
                        pictureNextel.From.Row = initialRow + contRow + 2;
                        pictureNextel.SetSize(imageNextel.Width - 20, imageNextel.Height);
                    }
                     */

                    /*
                    if (imageDescarga != null)
                    {
                        int imgRow = initialRow + contRow + 2;
                        int imgCol = initalCol + (dt.Columns.Count - 1);

                        int cellwidth = ExcelHelper.ColumnWidth2Pixel(ws, ws.Cells[imgRow, imgCol].Worksheet.Column(imgCol).Width);
                        int imagewidth = imageDescarga.Width;
                        int diff = cellwidth - imagewidth;
                        pictureDescarga = ws.Drawings.AddPicture("logoDescarga", imageDescarga);
                        pictureDescarga.SetPosition(imgRow, 0, imgCol - 1, diff);
                        pictureDescarga.SetSize(imageDescarga.Width, imageDescarga.Height);
                    }
                    */
                    contWorksheet++;
                }

                // Generamos el archivo Excel y mostramos el popup de descarga
                Byte[] bin = p.GetAsByteArray();
                DateTime date = DateTime.Now;
                HttpContext context = HttpContext.Current;
                context.Response.Clear();
                context.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "_" + date.Date.ToString("yyyyMMdd") + "_" + date.Hour + date.Minute + date.Millisecond + ".xlsx");
                context.Response.BinaryWrite(bin);
                context.Response.End();
            }
        }

        public static void ExportToExcelCSV(DataTable dt, string fileName)
        {
            HttpContext context = HttpContext.Current;
            context.Response.Clear();

            foreach (DataRow row in dt.Rows)
            {
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    context.Response.Write(row[i].ToString() + ",");
                }
                context.Response.Write(Environment.NewLine);
            }

            DateTime date = DateTime.Now;
            context.Response.ContentType = "text/csv";
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + "_" + date.Date.ToString("yyyyMMdd") + "_" + date.Hour + date.Minute + date.Millisecond + ".csv");
            context.Response.End();
        }

        // ===================================================================================================

        public static void createExcelFile(ExcelFileSpreadsheet spreadsheet, String path, String fileName)
        {
            using (ExcelPackage p = new ExcelPackage())
            {
                int contWorksheet = 1;
                int initalCol = 2;
                int initialRow = 2;

                // Ingresamos los datos para las propiedades del archivo Excel
                p.Workbook.Properties.Author = spreadsheet.propertyAuthor;
                p.Workbook.Properties.Title = spreadsheet.propertyTitle;

                foreach (ExcelFileWorksheet worksheet in spreadsheet.worksheets)
                {
                    // Creamos un Worksheet
                    p.Workbook.Worksheets.Add(worksheet.sheetName);

                    ExcelWorksheet ws = p.Workbook.Worksheets[contWorksheet];
                    ws.Cells.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    ws.Cells.Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.White);
                    ws.Cells.Style.Font.Size = 10;
                    ws.Cells.Style.Font.Name = "Arial";

                    int colIndex = initalCol;
                    int rowIndex = initialRow;
                    int contHeader = 1;
                    int indexHeader = 0;

                    DataTable dt = worksheet.dtSource;

                    if (!worksheet.sheetTitle.Equals(""))
                    {   // Unimos celdas para poder colocar el titulo de la grilla a mostrar
                        ws.Cells[colIndex, rowIndex].Value = worksheet.sheetTitle;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Merge = true;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.Font.Size = 12;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.Font.Bold = true;
                        ws.Cells[colIndex, rowIndex, colIndex, rowIndex + (dt.Columns.Count - 1)].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                        rowIndex = rowIndex + 2;
                    }

                    // Creamos las cabeceras de la grilla
                    foreach (DataColumn dc in dt.Columns)
                    {
                        var cell = ws.Cells[rowIndex, colIndex];
                        cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                        var fill = cell.Style.Fill;
                        fill.PatternType = ExcelFillStyle.Solid;
                        fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#D7D2CB"));

                        var font = cell.Style.Font;
                        font.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        font.Bold = true;

                        var border = cell.Style.Border;
                        border.Top.Style = ExcelBorderStyle.Thin;
                        border.Top.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));


                        if (contHeader == 1)
                        {
                            border.Left.Style = ExcelBorderStyle.Thin;
                            border.Left.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        }

                        if (contHeader < dt.Columns.Count)
                        {
                            border.Right.Style = ExcelBorderStyle.Thin;
                            border.Right.Color.SetColor(System.Drawing.Color.White);
                        }
                        else
                        {
                            border.Right.Style = ExcelBorderStyle.Thin;
                            border.Right.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                        }

                        // Colocamos el nombre de la celda en la cabecera
                        cell.Value = worksheet.columnHeader[indexHeader];

                        double cellSize = ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width;
                        double proposedCellSize = cell.Value.ToString().Trim().Length * 1.3;

                        if (cellSize <= proposedCellSize)
                        {
                            ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width = proposedCellSize;
                        }

                        colIndex++;
                        contHeader++;
                        indexHeader++;

                    }

                    int contRow = 1;

                    // Agregamos el contenido del DataTable en las celdas de la grilla
                    foreach (DataRow dr in dt.Rows)
                    {
                        colIndex = initalCol;
                        rowIndex++;
                        int contCol = 1;
                        int cellIndex = 0;

                        foreach (DataColumn dc in dt.Columns)
                        {
                            var cell = ws.Cells[rowIndex, colIndex];

                            var fill = cell.Style.Fill;
                            fill.PatternType = ExcelFillStyle.Solid;

                            if (rowIndex % 2 == 0)
                            { fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#ECEEE7")); }

                            String strValue = "";
                            if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.TEXT))
                            {
                                cell.Value = dr[dc.ColumnName].ToString();
                                strValue = cell.Value.ToString();
                            }
                            else
                            {
                                if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.NUMERIC))
                                {
                                    cell.Value = Convert.ToInt32(dr[dc.ColumnName]);
                                    strValue = cell.Value.ToString();
                                }
                                else
                                {
                                    if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.FLOAT))
                                    {
                                        cell.Value = Convert.ToDecimal(dr[dc.ColumnName]);
                                        strValue = cell.Value.ToString();
                                    }
                                    else
                                    {
                                        if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DOUBLE))
                                        {
                                            cell.Value = Convert.ToDouble(dr[dc.ColumnName]);
                                            strValue = cell.Value.ToString();
                                        }
                                        else
                                        {
                                            if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DATE))
                                            {
                                                DateTime datetime = DateTime.Parse(dr[dc.ColumnName].ToString());
                                                String day = datetime.ToString("dd");
                                                String month = datetime.ToString("MM");
                                                String year = datetime.ToString("yyyy");
                                                cell.Value = day + "/" + month + "/" + year;
                                                strValue = cell.Value.ToString();
                                            }
                                            else
                                            {
                                                if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.TIME))
                                                {
                                                    DateTime datetime = DateTime.Parse(dr[dc.ColumnName].ToString());
                                                    String hora = datetime.ToString("hh");
                                                    String minuto = datetime.ToString("mm");
                                                    cell.Value = hora + ":" + minuto;
                                                    strValue = cell.Value.ToString();
                                                }
                                                else
                                                {
                                                    if (worksheet.columnFormat[cellIndex].Equals(ExcelFileCellFormat.DATETIME))
                                                    {
                                                        cell.Value = dr[dc.ColumnName].ToString();
                                                        strValue = cell.Value.ToString();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                            var border = cell.Style.Border;

                            if (contCol == 1)
                            {
                                border.Left.Style = ExcelBorderStyle.Thin;
                                border.Left.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            if (contCol < dt.Columns.Count)
                            {
                                border.Right.Style = ExcelBorderStyle.Thin;
                                border.Right.Color.SetColor(System.Drawing.Color.White);
                            }
                            else
                            {
                                border.Right.Style = ExcelBorderStyle.Thin;
                                border.Right.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            if (contRow == dt.Rows.Count)
                            {
                                border.Bottom.Style = ExcelBorderStyle.Thin;
                                border.Bottom.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            }

                            var font = cell.Style.Font;
                            font.Color.SetColor(System.Drawing.ColorTranslator.FromHtml("#766A87"));
                            font.Bold = false;

                            double cellSize = ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width;
                            double proposedCellSize = strValue.Trim().Length * 1.3;
                            if (cellSize <= proposedCellSize)
                            { ws.Cells[rowIndex, colIndex].Worksheet.Column(colIndex).Width = proposedCellSize; }

                            colIndex++;
                            contCol++;
                            cellIndex++;

                        }
                        contRow++;

                    }

                    //How to Add a Image using EP Plus
                    /*
                    string codigo_color = System.Configuration.ConfigurationManager.AppSettings["codigocolorcss"].ToString();
                    string tema = "entel-excel-";

                    if (codigo_color == "1")
                    {
                        tema = "nextel-excel-";
                    }
                    else if (codigo_color == "2")
                    {
                        tema = "entel-excel-";
                    }
                     */

                    //String logoNextelPath = HttpContext.Current.Server.MapPath("~") + "/images/logo/" + tema + "logo.png";
                    //String logoDescargaPath = HttpContext.Current.Server.MapPath("~") + "/images/logo/" + tema + "descarga.png";
                    //Bitmap imageNextel = new Bitmap(logoNextelPath);
                    //Bitmap imageDescarga = new Bitmap(logoDescargaPath);

                    //ExcelPicture pictureNextel = null;
                    //ExcelPicture pictureDescarga = null;

                    //if (imageNextel != null)
                    //{
                    //    pictureNextel = ws.Drawings.AddPicture("logoNextel", imageNextel);
                    //    pictureNextel.From.Column = initalCol - 1;
                    //    pictureNextel.From.Row = initialRow + contRow + 2;
                    //    pictureNextel.SetSize(imageNextel.Width - 20, imageNextel.Height);
                    //}
                    //if (imageDescarga != null)
                    //{
                    //    int imgRow = initialRow + contRow + 2;
                    //    int imgCol = initalCol + (dt.Columns.Count - 1);

                    //    int cellwidth = ExcelHelper.ColumnWidth2Pixel(ws, ws.Cells[imgRow, imgCol].Worksheet.Column(imgCol).Width);
                    //    int imagewidth = imageDescarga.Width;
                    //    int diff = cellwidth - imagewidth;
                    //    pictureDescarga = ws.Drawings.AddPicture("logoDescarga", imageDescarga);
                    //    pictureDescarga.SetPosition(imgRow, 0, imgCol - 1, diff);
                    //    pictureDescarga.SetSize(imageDescarga.Width, imageDescarga.Height);

                    //}
                    contWorksheet++;
                }

                // Generamos el archivo Excel a ser copiado en el servidor
                Byte[] bin = p.GetAsByteArray();
                DateTime date = DateTime.Now;
                String file = path + "/" + fileName + ".xlsx";
                File.WriteAllBytes(file, bin);
            }
        }

        public static void createExcelCSVFile(DataTable dt, String path, String fileName)
        {
            StringBuilder sb = new StringBuilder();
            if (dt.Columns.Count != 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    foreach (DataColumn column in dt.Columns)
                    {
                        sb.Append(row[column].ToString() + ',');
                    }

                    sb.Append("\r\n");
                }
            }

            String fileLocation = path + "/" + fileName + ".csv";
            System.IO.File.WriteAllText(fileLocation, sb.ToString());
        }
    }
}
