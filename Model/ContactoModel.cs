using Model.bean;
using Model.functions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
namespace Model
{
    public class ContactoModel
    {
        public static Int32 Insert(ContactoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Telefono", SqlDbType.VarChar, 80);
            parameter.Value = item.Telefono;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Email", SqlDbType.VarChar, 80);
            parameter.Value = item.Email;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Cargo", SqlDbType.VarChar, 80);
            parameter.Value = item.Cargo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCliente", SqlDbType.BigInt);
            parameter.Value = item.IdCliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdClienteInstalacion", SqlDbType.BigInt);
            parameter.Value = item.IdClienteInstalacion;
            alParameters.Add(parameter);
            //parameter = new SqlParameter("@IdZona", SqlDbType.BigInt);
            //parameter.Value = item.IdZona;
            //alParameters.Add(parameter);

            int contacto = Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGRContacto", alParameters));
            item.IdContacto = contacto;
            return contacto;
        }
        public static void Update(ContactoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdContacto", SqlDbType.BigInt);
            parameter.Value = item.IdContacto;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 150);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Telefono", SqlDbType.VarChar, 80);
            parameter.Value = item.Telefono;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Email", SqlDbType.VarChar, 80);
            parameter.Value = item.Email;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Cargo", SqlDbType.VarChar, 80);
            parameter.Value = item.Cargo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCliente", SqlDbType.BigInt);
            parameter.Value = item.IdCliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdClienteInstalacion", SqlDbType.BigInt);
            parameter.Value = item.IdClienteInstalacion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdZona", SqlDbType.BigInt);
            parameter.Value = item.IdZona;
            alParameters.Add(parameter);

            SqlConnector.executeNonQuery("spS_ManUpdGRContacto", alParameters);
        }
        public static ContactoBean Get(ContactoBean item)
        {
            ContactoBean obj = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdContacto", SqlDbType.BigInt);
            parameter.Value = item.IdContacto;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRContacto", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new ContactoBean
                    {
                        IdContacto = Int64.Parse(row["IdContacto"].ToString()),
                        Nombre = row["Nombre"].ToString(),
                        Telefono = row["Telefono"].ToString(),
                        Email = row["Email"].ToString(),
                        Cargo = row["Cargo"].ToString(),
                        Cliente = row["Cliente"].ToString(),
                        IdCliente = Int64.Parse(row["IdCliente"].ToString()),
                        IdClienteInstalacion = Int64.Parse(row["IdClienteInstalacion"].ToString()),
                        IdZona = Int64.Parse(row["IdZona"].ToString()),
                        Flag = row["Flag"].ToString()
                    };
                }
            }
            return obj;
        }
        public static void Disabled(ContactoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdContacto", SqlDbType.BigInt);
            parameter.Value = item.IdContacto;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRContactoDisabled", alParameters);
        }
        public static void Activate(ContactoBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdContacto", SqlDbType.BigInt);
            parameter.Value = item.IdContacto;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRContactoActivate", alParameters);
        }
        public static List<ContactoBean> GetAll(ContactoBean item)
        {
            List<ContactoBean> lobj = new List<ContactoBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 10);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Telefono", SqlDbType.VarChar, 80);
            parameter.Value = item.Telefono;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Email", SqlDbType.VarChar, 80);
            parameter.Value = item.Email;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Cargo", SqlDbType.VarChar, 80);
            parameter.Value = item.Cargo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCliente", SqlDbType.BigInt);
            parameter.Value = item.IdCliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdZona", SqlDbType.BigInt);
            parameter.Value = item.IdZona;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Flag", SqlDbType.Char, 1);
            parameter.Value = item.Flag;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRContactoAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ContactoBean obj = new ContactoBean
                    {
                        IdContacto = Int64.Parse(row["IdContacto"].ToString()),
                        Nombre = row["Nombre"].ToString(),
                        Telefono = row["Telefono"].ToString(),
                        Email = row["Email"].ToString(),
                        Cargo = row["Cargo"].ToString(),
                        IdCliente = Int64.Parse(row["IdCliente"].ToString()),
                        IdZona = Int64.Parse(row["IdZona"].ToString()),
                        Flag = row["Flag"].ToString()
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<ContactoBean> GetContacts(ContactoBean item)
        {
            List<ContactoBean> lobj = new List<ContactoBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@idcliente", SqlDbType.Int);
            parameter.Value = item.IdCliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idzona", SqlDbType.Int);
            parameter.Value = item.IdZona;
            alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRContact", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ContactoBean obj = new ContactoBean
                    {
                        IdContacto = Int64.Parse(row["IdContacto"].ToString()),
                        Nombre = row["Nombre"].ToString(),
                        Telefono = row["Telefono"].ToString(),
                        Email = row["Email"].ToString(),
                        Cargo = row["Cargo"].ToString(),
                        IdCliente = Int64.Parse(row["IdCliente"].ToString()),
                        IdZona = Int64.Parse(row["IdZona"].ToString()),
                        Flag = row["Flag"].ToString()
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        public static DataTable GetClienteId(Int64 idClienteInstalacion)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdClienteInstalacion", SqlDbType.BigInt);
            parameter.Value = idClienteInstalacion;
            alParameters.Add(parameter);

            return SqlConnector.getDataTable("sps_SelGRClienteInstalacionGetClienteId", alParameters);

        }
        public static PaginateContactoBean GetAllPaginate(ContactoBean item)
        {
            List<ContactoBean> lobj = new List<ContactoBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Nombre", SqlDbType.VarChar, 10);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Telefono", SqlDbType.VarChar, 80);
            parameter.Value = item.Telefono;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Email", SqlDbType.VarChar, 80);
            parameter.Value = item.Email;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCliente", SqlDbType.BigInt);
            parameter.Value = item.IdCliente;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdClienteInstalacion", SqlDbType.BigInt);
            parameter.Value = item.IdClienteInstalacion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Cargo", SqlDbType.VarChar, 80);
            parameter.Value = item.Cargo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.Char, 1);
            parameter.Value = item.Flag;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRContactoAllPaginate", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    ContactoBean obj = new ContactoBean
                    {
                        IdContacto = Int64.Parse(row["IdContacto"].ToString()),
                        Nombre = row["Nombre"].ToString(),
                        Telefono = row["Telefono"].ToString(),
                        Email = row["Email"].ToString(),
                        Cargo = row["Cargo"].ToString(),
                        IdCliente = Int64.Parse(row["IdCliente"].ToString()),
                        IdClienteInstalacion = Int64.Parse(row["IdClienteInstalacion"].ToString()),
                        Cliente = row["Cliente"].ToString(),
                        ClienteInstalacion = row["ClienteInstalacion"].ToString(),
                        Flag = row["Flag"].ToString()
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return new PaginateContactoBean { lstResultados = lobj, totalrows = total };
        }
    }
}
