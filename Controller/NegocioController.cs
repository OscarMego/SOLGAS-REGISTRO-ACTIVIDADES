using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Controller
{
    public class NegocioController
    {
        public static List<NegocioBean> GetAll(NegocioBean item,String IDUSUARIO)
        {
            return NegocioModel.GetAll(item, IDUSUARIO);
        }
    }
}
