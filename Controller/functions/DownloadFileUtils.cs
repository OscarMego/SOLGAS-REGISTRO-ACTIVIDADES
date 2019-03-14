using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;
using Ionic.Zip;
using Controller.functions.excel;
using System.Data;

namespace Controller.functions
{
    public class DownloadFileUtils
    {
        public static void generarZipConArchivoTexto(DataSet ds)
        {   DateTime date = DateTime.Now;
            String tempFolder = date.Date.ToString("yyyyMMdd") + date.Hour + date.Minute + date.Millisecond;
            String downloadPath = HttpContext.Current.Server.MapPath("~") + "\\downloads\\" + tempFolder;
            Directory.CreateDirectory(downloadPath);

            foreach (DataTable dt in ds.Tables)
            {
                String fileName = dt.TableName;
                TextFileUtils.createTextFile(dt, downloadPath, fileName);
            }

            String filename = "DESCARGA" + "_" + DateTime.Now.Day.ToString().Trim() + DateTime.Now.Month.ToString().Trim() + DateTime.Now.Year.ToString().Trim() + DateTime.Now.Hour.ToString().Trim() + DateTime.Now.Minute.ToString().Trim() + DateTime.Now.Second.ToString().Trim() + DateTime.Now.Millisecond.ToString().Trim() + ".zip";
            HttpContext context = HttpContext.Current;
            context.Response.Clear();
            context.Response.ContentType = "application/zip";
            context.Response.AddHeader("content-disposition", "filename=" + filename);

            DirectoryInfo diFiles = new DirectoryInfo(downloadPath);

            using (ZipFile zip = new ZipFile())
            {
                foreach (FileInfo fi in diFiles.GetFiles())
                {   zip.AddFile(downloadPath + "/" + fi.Name, ""); }

                zip.Save(context.Response.OutputStream);
            }

            // borrar archivos dentro del directorio virtual
            foreach (FileInfo file in diFiles.GetFiles())
            {   file.Delete();  }

            // borrar directorio virtual
            diFiles.Delete(true);

            context.Response.End();

        }

        public static void generarZipConArchivoCSV(DataSet ds)
        {   DateTime date = DateTime.Now;
            String tempFolder = date.Date.ToString("yyyyMMdd") + date.Hour + date.Minute + date.Millisecond;
            String downloadPath = HttpContext.Current.Server.MapPath("~") + "\\downloads\\" + tempFolder;
            Directory.CreateDirectory(downloadPath);

            foreach (DataTable dt in ds.Tables)
            {
                String fileName = dt.TableName + "_" + tempFolder;
                ExcelFileUtils.createExcelCSVFile(dt, downloadPath, fileName);
            }

            String filename = "Descarga_" + date.Date.ToString("yyyyMMdd") + "_" + date.Hour + date.Minute + date.Millisecond + ".zip";
            HttpContext context = HttpContext.Current;
            context.Response.Clear();
            context.Response.ContentType = "application/zip";
            context.Response.AddHeader("content-disposition", "filename=" + filename);

            DirectoryInfo diFiles = new DirectoryInfo(downloadPath);

            using (ZipFile zip = new ZipFile())
            {
                foreach (FileInfo fi in diFiles.GetFiles())
                {   zip.AddFile(downloadPath + "/" + fi.Name, "");  }

                zip.Save(context.Response.OutputStream);
            }

            // borrar archivos dentro del directorio virtual
            foreach (FileInfo file in diFiles.GetFiles())
            {   file.Delete();  }

            // borrar directorio virtual
            diFiles.Delete(true);

            context.Response.End();

        }

        public static void generarZipConArchivoExcel(ExcelFileSpreadsheet spreadsheet)
        {   DateTime date = DateTime.Now;
            String tempFolder = date.Date.ToString("yyyyMMdd") + date.Hour + date.Minute + date.Millisecond;
            String downloadPath = HttpContext.Current.Server.MapPath("~") + "\\downloads\\" + tempFolder;
            Directory.CreateDirectory(downloadPath);

            String fileName = "Descarga_" + date.Date.ToString("yyyyMMdd") + "_" + date.Hour + date.Minute + date.Millisecond;
            ExcelFileUtils.createExcelFile(spreadsheet, downloadPath, fileName);

            HttpContext context = HttpContext.Current;
            context.Response.Clear();
            context.Response.ContentType = "application/zip";
            context.Response.AddHeader("content-disposition", "filename=" + fileName + ".zip");

            DirectoryInfo diFiles = new DirectoryInfo(downloadPath);

            using (ZipFile zip = new ZipFile())
            {
                foreach (FileInfo fi in diFiles.GetFiles())
                { zip.AddFile(downloadPath + "/" + fi.Name, ""); }

                zip.Save(context.Response.OutputStream);
            }

            // borrar archivos dentro del directorio virtual
            foreach (FileInfo file in diFiles.GetFiles())
            { file.Delete(); }

            // borrar directorio virtual
            diFiles.Delete(true);

            context.Response.End();

        }
    }
}
