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
    public class GrupoDetalleController
    {

        public static GrupoDetalleBean Get(GrupoDetalleBean item)
        {
            GrupoDetalleBean obj = new GrupoDetalleBean();
            DataTable dt = GeneralDetalleModel.Get(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new GrupoDetalleBean
                    {
                        IdGrupoDetalle = int.Parse(row["IdGrupoDetalle"].ToString()),
                        IdGrupo = int.Parse(row["IdGrupo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        Grupo = row["Grupo"].ToString(),
                        IdCodigoDetallePadre = row["IdCodigoDetallePadre"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                    };
                }
            }
            return obj;
        }
        public static Int32 Insert(GrupoDetalleBean item)
        {
            Int32 id = 0;
            try
            {
                //GeneralDetalleController.Validate(item);
                id = GeneralDetalleModel.Insert(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return id;
        }
        public static void Update(GrupoDetalleBean item)
        {
            try
            {
                GrupoDetalleController.Validate(item);
                GeneralDetalleModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Activate(GrupoDetalleBean item)
        {
            GeneralDetalleModel.Activate(item);
        }
        public static PaginateGrupoDetalleBean GetAllPaginate(GrupoDetalleBean item)
        {
            List<GrupoDetalleBean> lobj = new List<GrupoDetalleBean>();
            DataTable dt = GeneralDetalleModel.GetAllPaginate(item);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    GrupoDetalleBean obj = new GrupoDetalleBean
                    {
                        IdGrupoDetalle = int.Parse(row["IdGrupoDetalle"].ToString()),
                        IdGrupo = int.Parse(row["IdGrupo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        Grupo = row["Grupo"].ToString(),
                        Padre = row["Padre"].ToString(),
                        DetallePadre = row["DetallePadre"].ToString(),
                        IdCodigoDetallePadre = row["IdCodigoDetallePadre"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            PaginateGrupoDetalleBean pobj = new PaginateGrupoDetalleBean();
            pobj.lstResultados = lobj;
            pobj.totalrows = total;
            pobj.totalPages = Utility.calculateNumberOfPages(pobj.totalrows, item.rows);
            return pobj;
        }
        public static string Validate(GrupoDetalleBean item)
        {
            string mensaje = "";
            DataTable dt = GeneralDetalleModel.Validate(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    mensaje += row["Mensaje"].ToString() + ", ";
                }
                mensaje = mensaje.Substring(0, mensaje.Length - 2);
                throw new Exception(mensaje);
            }
            return mensaje;
        }
        public static List<GrupoDetalleBean> GetAllPadre(GrupoDetalleBean item)
        {
            List<GrupoDetalleBean> lobj = new List<GrupoDetalleBean>();
            DataTable dt = GeneralDetalleModel.GetAllPadre(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    GrupoDetalleBean obj = new GrupoDetalleBean
                    {
                        IdGrupoDetalle = int.Parse(row["IdGrupoDetalle"].ToString()),
                        IdGrupo = int.Parse(row["IdGrupo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        Grupo = row["Grupo"].ToString(),
                        Selecc = row["Selecc"].ToString(),
                        IdCodigoDetallePadre = row["IdCodigoDetallePadre"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
        //public static List<GrupoDetalleBean> GetGroup(String idTipo, String codigoPadre)
        //{
        //    List<GrupoDetalleBean> lobj = new List<GrupoDetalleBean>();
        //    DataTable dt = GeneralDetalleModel.GetGroup(idTipo, codigoPadre);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            GrupoDetalleBean obj = new GrupoDetalleBean
        //            {
        //                IdGrupoDetalle = int.Parse(row["IdGrupoDetalle"].ToString()),
        //                IdGrupo = int.Parse(row["IdGrupo"].ToString()),
        //                Codigo = row["Codigo"].ToString(),
        //                Nombre = row["Nombre"].ToString(),
        //                IdCodigoDetallePadre = row["IdCodigoDetallePadre"].ToString(),
        //                FlgHabilitado = row["FlgHabilitado"].ToString(),
        //            };
        //            lobj.Add(obj);
        //        }
        //    }
        //    return lobj;
        //}
    }
}
