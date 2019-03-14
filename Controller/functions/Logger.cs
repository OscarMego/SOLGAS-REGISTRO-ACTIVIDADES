using System;
using System.Collections.Generic;
using System.Web;
using System.Configuration;
using System.IO;

namespace Controller.functions
{
    public class Logger
    {
        public Logger()
        {
        }

        public static void log(Exception ex)
        {
            writeFile("E", ex.Source, ex);
        }

        public static void log(Exception ex, string message)
        {
            writeFile("E", message, ex);
        }

        public static void log(string message)
        {
            writeFile("V", message, null);   
        }

        private static void writeFile(string tipo, string message, Exception exc)
        {
            string LOG_ACTIVO = ConfigurationManager.AppSettings["LOG_ACTIVO"];
            if (LOG_ACTIVO == "1")
            {
                string ruta = ConfigurationManager.AppSettings["rutaLog"];
                string sYear = DateTime.Now.Year.ToString();
                string sMonth = DateTime.Now.Month.ToString();
                string sDay = DateTime.Now.Day.ToString();
                string logFile = ruta + sYear + sMonth + sDay + "Log.txt";
                logFile = HttpContext.Current.Server.MapPath("~") + logFile;
                StreamWriter sw = new StreamWriter(logFile, true);
                string sTiempo = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString() + ":" + DateTime.Now.Second.ToString();
                sw.WriteLine(sTiempo + "|" + tipo + "|" + message);

                if (exc != null)
                {
                    if (exc.InnerException != null)
                    {                        
                        sw.Write("InnerException.GetType(): ");
                        sw.WriteLine(exc.InnerException.GetType().ToString());
                        sw.Write("InnerException.Message: ");
                        sw.WriteLine(exc.InnerException.Message);
                        sw.Write("InnerException.Source: ");
                        sw.WriteLine(exc.InnerException.Source);
                        if (exc.InnerException.StackTrace != null)
                        {
                            sw.WriteLine("InnerException.StackTrace: ");
                            sw.WriteLine(exc.InnerException.StackTrace);
                        }
                    }
                    sw.Write("Exception.GetType(): ");
                    sw.WriteLine(exc.GetType().ToString());
                    sw.WriteLine("Exception.Message: " + exc.Message);
                    sw.WriteLine("Exception.Source: " + exc.Source);
                    sw.WriteLine("Exception.StackTrace: ");
                    if (exc.StackTrace != null)
                    {
                        sw.WriteLine(exc.StackTrace);
                    }
                }
                sw.Close();
            }
        }
    }
}
