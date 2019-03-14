using System;
using System.Collections.Generic;
using System.Text;
using System.Globalization;
using System.Threading;
using System.Web.UI.WebControls;
using Model.bean;
using System.Web.UI.HtmlControls;
using System.Net.Mail;


namespace business.functions
{
    public class Utility
    {
        
        public static int calculateNumberOfPages(int totalNumberOfItems, int pageSize)
        {
            Int32 result = totalNumberOfItems % pageSize;
            if (result == 0)
                return totalNumberOfItems / pageSize;
            else
                return totalNumberOfItems / pageSize + 1;
        }

        public static string FormatDateTime(string inputDate,int tipo)
        {
            String resultado = inputDate;
            Thread.CurrentThread.CurrentCulture = new CultureInfo("fr-FR");
            DateTime dt = DateTime.Parse(inputDate);

            if (tipo == 1)
            {   resultado = dt.ToShortDateString(); }

            if (tipo == 2)
            {   resultado = dt.ToShortTimeString(); }

            return resultado;
        }

        public static DateTime stringToDateTime(String strFecha)
        {
            char[] splitter = { '/' };
            String[] arrfecha = strFecha.Split(splitter);
            String dia = arrfecha[0];
            String mes = arrfecha[1];
            String anho = arrfecha[2];

            DateTime fecha = new DateTime(Convert.ToInt32(anho), Convert.ToInt32(mes), Convert.ToInt32(dia));
            
            return fecha;
        }
        public static DateTime stringToDateTime_Hour(String strFecha,String strHour)
        {
            char[] splitter = { '/' };
            char[] spliHour = { ':' };
            String[] arrfecha = strFecha.Split(splitter);
            String dia = arrfecha[0];
            String mes = arrfecha[1];
            String anho = arrfecha[2];

            String[] arrHour = strHour.Split(spliHour);
            String hora = arrHour[0];
            String min = arrHour[1];
            String sec = arrHour[2];

            DateTime fecha = new DateTime(Convert.ToInt32(anho), Convert.ToInt32(mes), Convert.ToInt32(dia), Convert.ToInt32(hora), Convert.ToInt32(min), Convert.ToInt32(sec));

            return fecha;
        }

        public static string fechaSQL(string fecha)
        {
            char[] delim = { '/' };

            string[] arrFecha = fecha.Split(delim);

            return arrFecha[2] + arrFecha[1] + arrFecha[0];
        }

        public static bool esFechaValida(string fecha)
        {
            bool esValido = false;
            char[] delim = { '/' };
            string[] arrFecha;
            string anio;
            string mes;
            string dia;
            DateTime fecDateTime;

            try
            {
                arrFecha = fecha.Split(delim);
                anio = arrFecha[0];
                mes = arrFecha[1];
                dia = arrFecha[2];

                fecDateTime = new DateTime(int.Parse(anio), int.Parse(mes), int.Parse(dia));
                esValido = true;
            }
            catch
            {

            }

            return esValido;
        }

        public static string remplazarCS(string cadena)
        {
            cadena = cadena.Replace("&", "&amp;");
            cadena = cadena.Replace("" + (char)34 + "", "&quot;");
            cadena = cadena.Replace("$", "$$");
            cadena = cadena.Replace("<", "&lt;");
            cadena = cadena.Replace(">", "&gt;");
            cadena = cadena.Replace("'", "&#39;");
            cadena = cadena.Replace("¿", "&#191;");
            cadena = cadena.Replace("?", "&#63;");
            cadena = cadena.Replace("ÿ", "&#255;");

            return cadena;
        }

        public static Boolean isValid(int day, int month, int year)
        {
            if (!(month >= 1 && month <= 12)
            || !(day >= 1 && day <= 31)
            || !(year >= 1000 && year <= 9999)
            || (day == 31 &&
            (month == 4 /*april*/ || month == 6 /*june*/ ||
            month == 9 /*sept*/ || month == 11 /*nov*/ )) ||
            (month == 2 /*feb*/ && day > 29))
            {
                return false;
            }
            if (month == 2 && day == 29)
            { // if a year is divisible by 4 it is a leap year UNLESS it is also
                // divisible by 100 AND is not divisible by 400
                if (year % 4 > 0
                || ((year % 100 == 0) && (year % 400 > 0)))
                {
                    return false;
                }
            }
            return true;
        }

        public static Boolean validarFECHA(String fecha)
        {
            Boolean flag = true;
            try
            {
                string[] arrElementosFecha = fecha.Split('/');
                string day = arrElementosFecha[0];
                string month = arrElementosFecha[1];
                string year = arrElementosFecha[2];

                if (day != null && !day.Equals("") && month != null && !month.Equals("") && year != null && !year.Equals(""))
                    flag = isValid(int.Parse(day), int.Parse(month), int.Parse(year));
                else
                    flag = false;
            }
            catch (Exception )
            {

                flag = false;
            }
            return flag;
        }

        public static Boolean validarHORA(String horapara)
        {
            Boolean flag = true;
            try
            {
                string[] arrElementosFecha = horapara.Split(':');
                int hora = int.Parse(arrElementosFecha[0]);
                int minuto = int.Parse(arrElementosFecha[1]);


                if (hora >= 0 && hora < 24 && minuto >= 0 && minuto < 60)
                {
                    flag = true;
                }
                else
                {
                    flag = false;
                }
            }
            catch (Exception )
            {

                flag = false;
            }
            return flag;
        }
        
        public static void crearLog(string mensaje)
        {
            //StreamWriter sw = new StreamWriter(Server.MapPath("log/log.txt"), true);
            //sw.WriteLine(DateTime.Now + " "+ mensaje + "\n");
            //sw.Flush();
            //sw.Close();
        }

        
        /*public static string getBrowser(Page page)
        {
            string version7 = "UP.Browser/7";
            string agente = page.Request.ServerVariables["HTTP_USER_AGENT"];

            string browser = "4";

            if (agente.IndexOf(version7) > 0)
                browser = "7";

            return browser;
        }

        public static string getContentType(Page page)
        {
            string content = "text/vnd.wap.wml";

            if (getBrowser(page) == "7")
                content = "application/vnd.wap.xhtml+xml";

            return content;
        }

        public static string getFormatFecha(Page page)
        {
            string format = " format=\"NN/NN/NNNN\" ";

            if (getBrowser(page) == "7")
                format = " style=\"-wap-input-format: NN\\/NN\\/NNNN\" ";

            return format;
        }

        public static string getFormatFechaInvertida(Page page)
        {
            string format = " format=\"NNNN/NN/NN\" ";

            if (getBrowser(page) == "7")
                format = " style=\"-wap-input-format:NNNN\\/NN\\/NN\" ";

            return format;
        }

        public static string getFormatN(Page page)
        {
            string format = " format=\"N*\" ";

            if (getBrowser(page) == "7")
                format = " format=\"*N\" ";

            return format;
        }
        */
        public static string linea()
        { return "-------------------<br/>"; }

        /***
         * AUTHOR: DSB Mobile
         * Convierte la hora de la página aspx a una compatible con la consulta sql del reporte
         */
        public static string horaRepoteSQL(string hora)
        {
            String newDate = DateTime.Now.ToString("HH:mm");
            try
            {
                int hour = 0;
                int minute = 0;
                String ToD = "AM";

                string[] a_hora = hora.Split(':');
                hour = int.Parse(a_hora[0]);

                string[] a_min = a_hora[1].Split(' ');
                minute = int.Parse(a_min[0]);
                ToD = a_min[1];

                int year = DateTime.Now.Year;
                int month = DateTime.Now.Month;
                int day = DateTime.Now.Day;
                if (ToD.ToUpper() == "PM") hour = (hour % 12) + 12;

                newDate = new DateTime(year, month, day, hour, minute, 0).ToString("HH:mm");
            }
            catch (Exception )
            {

            }
            return newDate;
        }

        public static void CargarColores(DropDownList ddl)
        {
            List<ParejaBean> loListaColores = new List<ParejaBean>();
            loListaColores.Add(new ParejaBean("FF0000", "Rojo"));
            loListaColores.Add(new ParejaBean("F74C9C", "Rosado"));
            loListaColores.Add(new ParejaBean("7F00FF", "Morado"));
            loListaColores.Add(new ParejaBean("0000FF", "Azul"));
            loListaColores.Add(new ParejaBean("56FFFF", "Celeste"));
            loListaColores.Add(new ParejaBean("56FF56", "Verde"));
            loListaColores.Add(new ParejaBean("FFFF00", "Amarillo"));
            loListaColores.Add(new ParejaBean("000000", "Negro"));

            ddl.DataSource = loListaColores;
            ddl.DataTextField = "Valor";
            ddl.DataValueField = "Clave";

            ddl.DataBind();
            ddl.Items.Insert(0, ".: SELECCIONE :.");
            ddl.Items[0].Value = "";
        }
        public static void ComboNuevo<T>(DropDownList ddl, List<T> data, string DataValueField, string DataTextField)
        {
            ddl.DataSource = data;
            ddl.DataValueField = DataValueField;
            ddl.DataTextField = DataTextField;

            ddl.DataBind();
            ddl.Items.Insert(0, ".: SELECCIONE :.");
            ddl.Items[0].Value = "";
        }
        public static void ComboBuscar<T>(DropDownList ddl, List<T> data, string DataValueField, string DataTextField)
        {
            ddl.DataSource = data;
            ddl.DataValueField = DataValueField;
            ddl.DataTextField = DataTextField;

            ddl.DataBind();
            ddl.Items.Insert(0, ".: TODOS :.");
            ddl.Items[0].Value = "";
        }

        public static void ComboSeleccionar<T>(DropDownList ddl, List<T> data, string DataValueField, string DataTextField)
        {
            ddl.DataSource = data;
            ddl.DataValueField = DataValueField;
            ddl.DataTextField = DataTextField;

            ddl.DataBind();
            ddl.Items.Insert(0, "Seleccione");
            ddl.Items[0].Value = "";
        }

        public static void ConfiguraPaginacion(Label lbltpagina,HtmlAnchor linkpagina,Label lbltfilas,
            HtmlAnchor linkPaginaAnterior, HtmlAnchor linkPaginaSiguiente,
            String totalpage,String pagina,String totalrows,
            DropDownList ddlMostrar,String filas
            ){
                lbltpagina.Text = totalpage;
                linkpagina.InnerText = pagina;
                lbltfilas.Text = totalrows;

                if (Int32.Parse(pagina) == 1)
                {
                    linkPaginaAnterior.Attributes.Remove("class");
                    linkPaginaAnterior.Attributes.Add("class", "pagina-disabled");
                }

                if (Int32.Parse(pagina) == Int32.Parse(totalpage))
                {
                    linkPaginaSiguiente.Attributes.Remove("class");
                    linkPaginaSiguiente.Attributes.Add("class", "pagina-disabled");
                }

                List<ListItem> eMostrar = new List<ListItem>{
                        new ListItem{ Text="10",Value="10"},
                        new ListItem{ Text="20",Value="20"},
                        new ListItem{ Text="30",Value="30"},
                    };
                ddlMostrar.DataSource = eMostrar;
                ddlMostrar.DataValueField = "Value";
                ddlMostrar.DataTextField = "Text";
                ddlMostrar.DataBind();
                ddlMostrar.SelectedValue = filas;
        }
    }
}
