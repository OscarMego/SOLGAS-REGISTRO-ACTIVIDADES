using Model.bean;
using Model.functions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class ClienteInstalacionModel
    {
        public static List<ClienteInstalacionBean> getClienteInstalacion(String idCLiente)
        {
            List<ClienteInstalacionBean> lobj = new List<ClienteInstalacionBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter = new SqlParameter();
            parameter = new SqlParameter("@idCliente", SqlDbType.VarChar, 20);
            parameter.Value = idCLiente;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelClienteInstalacion", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ClienteInstalacionBean obj = new ClienteInstalacionBean
                    {
                        IDClienteInstalacion = row["IDClienteInstalacion"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        Habilitado = row["sel"].ToString(),
                        CodInstalacion= row["CodInstalacion"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static List<ClienteInstalacionBean> getAll(string idCliente)
        {
            List<ClienteInstalacionBean> lobj = new List<ClienteInstalacionBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idcliente", SqlDbType.VarChar, 50);
            parameter.Value = idCliente;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRClienteInstalacionAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ClienteInstalacionBean obj = new ClienteInstalacionBean
                    {
                        Index = row["Index"].ToString(),
                        IDClienteInstalacion = row["IDClienteInstalacion"].ToString(),
                        IDCliente = row["IDCliente"].ToString(),
                        IDUsuario = row["IDUsuario"].ToString(),
                        Usuario = row["Usuario"].ToString(),
                        CodInstalacion = row["CodInstalacion"].ToString(),
                        IDZona = row["IDZona"].ToString(),
                        Zona = row["Zona"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        Direccion = row["Direccion"].ToString(),
                        Referencia = row["Referencia"].ToString(),
                        Habilitado = row["Habilitado"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
    }
}
