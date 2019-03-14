using business.functions;
using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Controller
{
    public class ZonaController
    {
        public static ZonaBean Get(ZonaBean item)
        {
            return ZonaModel.Get(item);
        }
        public static void Insert(ZonaBean item)
        {
            try
            {
                if (ZonaModel.Insert(item) == -1)
                {
                    throw new Exception("El código ingresado ya existe");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Update(ZonaBean item)
        {
            try
            {
                ZonaModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Disabled(ZonaBean item)
        {
            ZonaModel.Disabled(item);
        }
        public static void Activate(ZonaBean item)
        {
            ZonaModel.Activate(item);
        }
        public static PaginateZonaBean GetAllPaginate(ZonaBean item)
        {
            var result = ZonaModel.GetAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static List<ZonaBean> GetAll(ZonaBean item)
        {
            return ZonaModel.GetAll(item);
        }
        public static List<ZonaBean> getClienteZonas(String idCLiente)
        {
            return ZonaModel.getClienteZonas(idCLiente);

        }
    }
}
