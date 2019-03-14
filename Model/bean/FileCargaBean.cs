using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class FileCargaBean
    {
        public String archivo { get; set; }
        public Int32 insertados { get; set; }
        public Int32 actualizados { get; set; }
        public Int32 subidos { get; set; }
        public Int32 total { get; set; }
        public String estado { get; set; }
        public String errorData { get; set; }
        public String errorExecute { get; set; }

        public string EstadoToHTML
        {
            get
            {
                if (errorExecute != string.Empty)
                {
                    return "<a idC='" + archivo + "' class='btnError' style ='color:#8C0000'>Error en el archivo</a>";

                }
                else if (errorData != string.Empty)
                {

                    return "<a class='btnData' cod='" + archivo + "' style ='color:#FF8000'>Error en datos</a>";

                }
                else
                {
                    return "<a idC='" + archivo + "' style ='color:#4B6F3F'>Ejecución exitosa</a>";

                }
            }
        }



        public FileCargaBean()
        {
            archivo = "";
            insertados = 0;
            actualizados = 0;
            subidos = 0;
            total = 0;
            estado = "";
            errorData = "";
            errorExecute = "";

        }
    }
}
