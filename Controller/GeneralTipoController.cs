using business.functions;
using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Controller
{
    public class GeneralTipoController
    {
        public static GeneralTipoBean Get(GeneralTipoBean item)
        {
            return GeneralTipoModel.Get(item);
        }
        public static void Insert(GeneralTipoBean item)
        {
            try
            {
                if (GeneralTipoModel.Insert(item) == -1)
                {
                    throw new Exception("El código y el tipo ingresado ya existe");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Update(GeneralTipoBean item)
        {
            try
            {
                if (GeneralTipoModel.Update(item) == -1)
                {
                    throw new Exception("El código y el tipo ingresado ya existe");
                }
                    
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Disabled(GeneralTipoBean item)
        {
            GeneralTipoModel.Disabled(item);
        }
        public static void Activate(GeneralTipoBean item)
        {
            GeneralTipoModel.Activate(item);
        }
        public static PaginateGeneralTipoBean GetAllPaginate(GeneralTipoBean item)
        {
            var result = GeneralTipoModel.GetAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static List<GeneralTipoBean> GetAll(GeneralTipoBean item)
        {
            return GeneralTipoModel.GetAll(item);
        }
        //public static List<GeneralTipoBean> getClienteGeneralTipo(String idCLiente)
        //{
        //    return GeneralTipoModel.getClienteZonas(idCLiente);

        //}
    }
}
