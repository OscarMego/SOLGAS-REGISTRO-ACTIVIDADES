using business.functions;
using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Controller
{
    public class ContactoController
    {
        public static ContactoBean Get(ContactoBean item)
        {
            return ContactoModel.Get(item);
        }
        public static void Insert(ContactoBean item)
        {
            try
            {
                if (ContactoModel.Insert(item) == -1)
                {
                    throw new Exception("El código ingresado ya existe");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Update(ContactoBean item)
        {
            try
            {
                ContactoModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Disabled(ContactoBean item)
        {
            ContactoModel.Disabled(item);
        }
        public static void Activate(ContactoBean item)
        {
            ContactoModel.Activate(item);
        }
        public static PaginateContactoBean GetAllPaginate(ContactoBean item)
        {
            var result = ContactoModel.GetAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static List<ContactoBean> GetAll(ContactoBean item)
        {
            return ContactoModel.GetAll(item);
        }

        public static ContactoBean GetClienteId(Int64 idClienteInstalacion)
        {
            ContactoBean obj = null;
            DataTable dt = ContactoModel.GetClienteId(idClienteInstalacion);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new ContactoBean
                    {
                        IdCliente = long.Parse(row["IDCliente"].ToString()),
                    };
                }
            }
            return obj;
        }

        public static List<ContactoBean> GetContacts(ContactoBean item)
        {
            return ContactoModel.GetContacts(item);
        }
    }
}
