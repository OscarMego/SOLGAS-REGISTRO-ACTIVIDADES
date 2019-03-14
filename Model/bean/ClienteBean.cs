using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
    public class ClienteBean
    {
        public int CLI_PK { get; set; }
        public String Razon_Social { get; set; }
        public String RUC { get; set; }

        public String Direccion { get; set; }
        public String Referencia { get; set; }

        public Int64 IdNegocio { get; set; }
        public String Negocio { get; set; }
        public Int64 IdRubro { get; set; }
        public Int64 IdRegion { get; set; }
        public Int64 IdOrganizacionVenta { get; set; }
        public Int64 IdCanal { get; set; }
        public Int64 IdTipo { get; set; }
        public String FlgHabilitado { get; set; }
        public String FlgHabilitadoDescrip
        {
            get
            {
                if (FlgHabilitado == "T") { return "SI"; }
                return "NO";
            }
        }
        public int page { get; set; }
        public int rows { get; set; }
        public List<ClienteInstalacionBean> lstClienteInstalacion { get; set; }
    }
    public class ClienteRequest
    {
        public String CLI_PK { get; set; }
        public String Razon_Social { get; set; }
        public String RUC { get; set; }
        public String Direccion { get; set; }
        public String Referencia { get; set; }
        public Int64 IdNegocio { get; set; }
        public Int64 IdRubro { get; set; }
        public Int64 IdRegion { get; set; }
        public Int64 IdOrganizacionVenta { get; set; }
        public Int64 IdCanal { get; set; }
        public Int64 IdTipo { get; set; }
        public ClienteRequest()
        {
            CLI_PK = "";
            Razon_Social = "";
            RUC = "";
            Direccion = "";
            Referencia = "";
            IdNegocio = 0;
            IdRubro = 0;
            IdRegion = 0;
            IdOrganizacionVenta = 0;
            IdCanal = 0;
            IdTipo = 0;
        }
    }
}
