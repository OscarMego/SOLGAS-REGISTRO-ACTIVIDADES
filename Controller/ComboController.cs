using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model.bean;
using System.Data;
using Model;
using business.functions;
using System.Configuration;

namespace Controller
{
    public class ComboController
    {

        public static void llenar(List<ComboBean> obj,DataRowCollection dr) {
            foreach (DataRow row in dr)
                {
                    var bean = new ComboBean();
                    bean.Codigo = row["IdGrupo"].ToString();
                    bean.Nombre = row["Descripcion"].ToString();
                    obj.Add(bean);
                }
        }
        #region COMBO MULTISELECT
        public static List<ComboBean> ComboPV(String flag)
        {
            List<ComboBean> list = new List<ComboBean>();
            DataTable dt = ComboModel.ComboPV(flag);

            //bean = new ComboBean();
            //bean.CODIGO = "0";
            //bean.NOMBRE = ".: TODOS :.";
            //list.Add(bean);

            if (dt != null && dt.Rows.Count > 0)
            {
                llenar(list, dt.Rows);
            }
            return list;
        }

        public static List<ComboBean> ComboUsuario(String flag, int IdSupervisor)
        {
            List<ComboBean> list = new List<ComboBean>();
            ComboBean bean;
            DataTable dt = ComboModel.ComboUsuario(flag, IdSupervisor);

            //bean = new ComboBean();
            //bean.CODIGO = "0";
            //bean.NOMBRE = ".: TODOS :.";
            //list.Add(bean);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    bean = new ComboBean();
                    bean.Codigo = row["CODIGO"].ToString();
                    bean.Nombre = row["NOMBRE"].ToString();
                    list.Add(bean);
                }
            }
            return list;
        }
        public static List<ComboBean> ComboEstadoVisita()
        {
            List<ComboBean> list = new List<ComboBean>();
            ComboBean bean;
            DataTable dt = ComboModel.ComboEstadoVisita();

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    bean = new ComboBean();
                    bean.Codigo = row["CODIGO"].ToString();
                    bean.Nombre = row["NOMBRE"].ToString();
                    list.Add(bean);
                }
            }
            return list;
        }
        #endregion
                                                           
        
    }
}
