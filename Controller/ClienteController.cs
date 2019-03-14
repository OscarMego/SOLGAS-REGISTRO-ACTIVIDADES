using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using business.functions;
using System.Data;
namespace Controller
{
    public class ClienteController
    {
        public static ClienteBean Get(ClienteBean item)
        {
            ClienteBean obj = new ClienteBean();
            DataTable dt = ClienteModel.Get(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new ClienteBean
                    {
                        CLI_PK = int.Parse(row["CLI_PK"].ToString()),
                        Razon_Social = row["Razon_Social"].ToString(),
                        RUC = row["RUC"].ToString(),
                        Direccion = row["Direccion"].ToString(),
                        Referencia = row["Referencia"].ToString(),
                        IdNegocio = Int64.Parse(row["IdNegocio"].ToString()),
                        Negocio = row["Negocio"].ToString(),
                        IdRubro = Int64.Parse(row["IdRubro"].ToString()),
                        IdRegion = Int64.Parse(row["IdRegion"].ToString()),
                        IdOrganizacionVenta = Int64.Parse(row["IdOrganizacionVenta"].ToString()),
                        IdCanal = Int64.Parse(row["IdCanal"].ToString()),
                        IdTipo = Int64.Parse(row["IdTipo"].ToString()),
                        FlgHabilitado = row["FlgHabilitado"].ToString()
                    };
                }
            }
            return obj;
        }
        public static Int32 Insert(ClienteBean item)
        {
            Int32 id = 0;
            try
            {
                ClienteController.Validate(item);
                id = ClienteModel.Insert(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return id;
        }
        public static void Update(ClienteBean item)
        {
            try
            {
                ClienteController.Validate(item);
                ClienteModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Activate(ClienteBean item)
        {
            ClienteModel.Activate(item);
        }
        public static PaginateClienteBean GetAllPaginate(ClienteBean item)
        {
            List<ClienteBean> lobj = new List<ClienteBean>();
            DataTable dt = ClienteModel.GetAllPaginate(item);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    ClienteBean obj = new ClienteBean
                    {
                        CLI_PK = int.Parse(row["CLI_PK"].ToString()),
                        Razon_Social = row["Razon_Social"].ToString(),
                        RUC = row["RUC"].ToString(),
                        Direccion = row["Direccion"].ToString(),
                        Referencia = row["Referencia"].ToString(),
                        IdNegocio = Int64.Parse(row["IdNegocio"].ToString()),
                        Negocio = row["Negocio"].ToString(),
                        
                        FlgHabilitado = row["FlgHabilitado"].ToString()
                    };
                    lobj.Add(obj);
                }
            }
            PaginateClienteBean pobj = new PaginateClienteBean();
            pobj.lstResultados = lobj;
            pobj.totalrows = total;
            pobj.totalPages = Utility.calculateNumberOfPages(pobj.totalrows, item.rows);
            return pobj;
        }
        public static List<ClienteBean> GetAll(ClienteBean item)
        {
            List<ClienteBean> lobj = new List<ClienteBean>();
            DataTable dt = ClienteModel.GetAll(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ClienteBean obj = new ClienteBean
                    {
                        CLI_PK = int.Parse(row["CLI_PK"].ToString()),
                        Razon_Social = row["Razon_Social"].ToString(),
                        RUC = row["RUC"].ToString(),
                        Direccion = row["Direccion"].ToString(),
                        Referencia = row["Referencia"].ToString(),
                        IdNegocio = Int64.Parse(row["IdNegocio"].ToString()),
                        Negocio = row["Negocio"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString()
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static string Validate(ClienteBean item)
        {
            string mensaje = "";
            DataTable dt = ClienteModel.Validate(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    mensaje += row["Mensaje"].ToString() + ", ";
                }
                mensaje = mensaje.Substring(0, mensaje.Length - 2);
                throw new Exception(mensaje);
            }
            return mensaje;
        }

        public static List<ClienteInstalacionBean> getAllInstalacion(string idCliente)
        {
            List<ClienteInstalacionBean> lobj = new List<ClienteInstalacionBean>();

            lobj = ClienteInstalacionModel.getAll(idCliente);
            
            return lobj;
        }
    }
}
