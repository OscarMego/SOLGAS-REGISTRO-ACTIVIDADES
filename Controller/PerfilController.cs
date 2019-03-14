using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using business.functions;
namespace Controller
{
    public class PerfilController
    {
        public static List<PerfilBean> GetAll(PerfilBean item)
        {
            return PerfilModel.GetAll(item);
        }
    }
}
