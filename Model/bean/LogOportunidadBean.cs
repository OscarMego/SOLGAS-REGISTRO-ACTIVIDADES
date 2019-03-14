using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class LogOportunidadBean
    {
        public LogOportunidadBean()
        {
            IdLogOportunidad = 0;
            IdOportunidad = 0;
            IdConfiguracionOportuniadaDetalle = 0;
            valorNuevo = "";
            valorAnterior = "";
            IdUsuario = 0;
            fechaModificacion = new DateTime();
        }

        public int IdLogOportunidad { get; set; }
        public int IdOportunidad { get; set; }
        public int IdConfiguracionOportuniadaDetalle { get; set; }
        public String valorNuevo { get; set; }
        public String valorAnterior { get; set; }
        public int IdUsuario { get; set; }
        public DateTime fechaModificacion { get; set; }
        public String nombreUsuario { get; set; }
        public String nombreCampo { get; set; }

    }
}
