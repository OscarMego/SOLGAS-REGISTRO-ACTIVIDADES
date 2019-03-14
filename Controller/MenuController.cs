using System;
using System.Collections.Generic;
using System.Text;
using Model.bean;
using Model;
using System.Data;
using business.functions;
using System.Web.Script.Serialization;

namespace Controller
{
    public class MenuController
    {
        public static List<MenuBean> subObtenerDatosMenu(Int32 piIdPerfil)
        {
            List<MenuBean> loLstMenuBean = new List<MenuBean>();
            try
            {
                DataTable loDatatable = MenuModel.fnObtenerDatosMenu(piIdPerfil);           
                MenuBean loMenuBean;
                if (loDatatable != null && loDatatable.Rows.Count > 0)
                {
                    foreach (DataRow row in loDatatable.Rows)
                    {
                        loMenuBean = new MenuBean();
                        loMenuBean.IdMenu = row["idMenu"].ToString();
                        loMenuBean.IdMenuPadre = row["IdMenuPadre"].ToString();
                        loMenuBean.Descripcion = row["Descripcion"].ToString();
                        loMenuBean.UrlImagen = row["UrlImagen"].ToString();
                        loMenuBean.Url = row["Url"].ToString();
                        loMenuBean.Codigo = row["Codigo"].ToString();
                        loLstMenuBean.Add(loMenuBean);
                    }
                }
            }
            catch (Exception )
            {
                // GUARDAR EN LOG
            }
            return loLstMenuBean;

        }

        //public static List<ManualBean> subObtenerDatosManuales(Int32 piIdSupervisor)
        //{
        //    List<ManualBean> loLstManualBean = new List<ManualBean>();
        //    try
        //    {
        //        DataTable loDatatable = MenuModel.fnObtenerDatosManuales(piIdSupervisor);
        //        ManualBean loManualBean;
        //        if (loDatatable != null && loDatatable.Rows.Count > 0)
        //        {
        //            foreach (DataRow row in loDatatable.Rows)
        //            {
        //                loManualBean = new ManualBean();
        //                loManualBean.IdManual = row["IdManual"].ToString();
        //                loManualBean.Descripcion = row["Descripcion"].ToString();
        //                loManualBean.Url = row["Url"].ToString();
        //                loManualBean.Formato = row["Formato"].ToString();
        //                loManualBean.Codigo = row["CodManual"].ToString();
        //                loLstManualBean.Add(loManualBean);
        //            }
        //        }
        //    }
        //    catch (Exception )
        //    {
        //        // GUARDAR EN LOG
        //    }
        //    return loLstManualBean;

        //}

    }
}
