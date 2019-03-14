using System;
using System.Collections.Generic;
using System.Text;

namespace Model.bean
{
    public class ReporteBean
    {
        public String tiempomuerto { get; set; }
        public String item { get; set; }
        public String pedido { get; set; }
        public String vendedor { get; set; }
        public String supervisor { get; set; }
        public String direccion { get; set; }
        public String fechaInicio { get; set; }
        public String fechaFin { get; set; }
        public String condicionVenta { get; set; }
        public String montoTotal { get; set; }
        public String latitud { get; set; }
        public String longitud { get; set; }

        public String tipo { get; set; }
        public String codigo { get; set; }
        public String codigoVendedor { get; set; }
        public String codigoCliente { get; set; }

        public String codigoProducto { get; set; }
        public String producto { get; set; }
        public String cantidad { get; set; }
        public String monto { get; set; }
        public String descuento { get; set; }

        public String cliente { get; set; }
        public String sucursal { get; set; }
        public String turno { get; set; }
        public String personal { get; set; }
        public String estado { get; set; }
        public String fecha { get; set; }
        public Int32 idasistencia { get; set; }
        public String congps { get; set; }
        public String codigoregistro { get; set; }
        public String confoto { get; set; }
        public String motivo { get; set; }
        public String fecharegistro { get; set; }

        public string congpsDisplay
        {
            get
            {
                if (congps == "F") return "display:none";
                else return "";

            }
        }
        public string confotoDisplay
        {
            get
            {
                if (confoto == "F") return "display:none";
                else return "";

            }
        }
        public ReporteBean()
        {
            cliente = "";
            sucursal = "";
            turno = "";
            personal = "";
            estado = "";
            fecha = "";
            idasistencia = -1;
            congps = "";
            confoto = "";
        }

    }
}
