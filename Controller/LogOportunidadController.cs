using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model.bean;
using Model;
namespace Controller
{
  public  class LogOportunidadController
    {
        public static Int32 Insert(LogOportunidadBean item)
        {
            try
            {
                return LogOportunidadModel.Insert(item);
            }
            catch (Exception ex)
            {   
                throw new Exception(ex.Message);
            }
        }
        public static List<LogOportunidadBean> getAll(String idOportunidad)
        {
            try
            {
                return LogOportunidadModel.GetAll(idOportunidad);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
