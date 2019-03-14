using business.functions;
using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Controller
{
    public class TipoActividadController
    {
        public static TipoActividadBean Get(TipoActividadBean item)
        {
            return TipoActividadModel.Get(item);
        }
        public static void Insert(TipoActividadBean item)
        {
            try
            {
                if (TipoActividadModel.Insert(item) == -1)
                {
                    throw new Exception("El código ingresado ya existe");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Update(TipoActividadBean item)
        {
            try
            {
                TipoActividadModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Disabled(TipoActividadBean item)
        {
            TipoActividadModel.Disabled(item);
        }
        public static void Activate(TipoActividadBean item)
        {
            TipoActividadModel.Activate(item);
        }
        public static PaginateTipoActividadBean GetAllPaginate(TipoActividadBean item)
        {
            var result = TipoActividadModel.GetAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static List<TipoActividadBean> GetAll(TipoActividadBean item)
        {
            return TipoActividadModel.GetAll(item);
        }

        public static List<TipoActividadBean> GetReporteDashboard(string idUsuario)
        {
            return TipoActividadModel.GetReporteDashboard(idUsuario);
        }
    }
}
