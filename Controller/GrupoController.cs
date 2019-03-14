using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using business.functions;
using System.Data;
namespace Controller
{
    public class GrupoController
    {
        public static GrupoBean Get(GrupoBean item)
        {
            GrupoBean obj = new GrupoBean();
            DataTable dt = GrupoModel.Get(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new GrupoBean
                    {
                        IDGrupo = int.Parse(row["IDGrupo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        IdNivel = int.Parse(row["IdNivel"].ToString()),
                        CodigoPadreGrupo = row["CodigoPadreGrupo"].ToString(),
                        tipo = row["tipo"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                    };
                }
            }
            return obj;
        }
        public static Int32 Insert(GrupoBean item)
        {
            Int32 id = 0;
            try
            {
                GrupoController.Validate(item);
                id = GrupoModel.Insert(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return id;
        }
        public static void Update(GrupoBean item)
        {
            try
            {
                GrupoController.Validate(item);
                GrupoModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Activate(GrupoBean item)
        {
            GrupoModel.Activate(item);
        }
        public static PaginateGrupoBean GetAllPaginate(GrupoBean item)
        {
            List<GrupoBean> lobj = new List<GrupoBean>();
            DataTable dt = GrupoModel.GetAllPaginate(item);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    GrupoBean obj = new GrupoBean
                    {
                        IDGrupo = int.Parse(row["IDGrupo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        IdNivel = int.Parse(row["IdNivel"].ToString()),
                        Nivel = row["Nivel"].ToString(),
                        CodigoPadreGrupo = row["CodigoPadreGrupo"].ToString(),
                        PadreDescrip = row["PadreDescrip"].ToString(),
                        tipo = row["tipo"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                    };
                    lobj.Add(obj);
                }
            }
            PaginateGrupoBean pobj = new PaginateGrupoBean();
            pobj.lstResultados = lobj;
            pobj.totalrows = total;
            pobj.totalPages = Utility.calculateNumberOfPages(pobj.totalrows, item.rows);
            return pobj;
        }
        public static string Validate(GrupoBean item)
        {
            string mensaje = "";
            DataTable dt = GrupoModel.Validate(item);
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
        public static List<GrupoBean> GetPadres(GrupoBean item)
        {
            List<GrupoBean> result = new List<GrupoBean>();
            DataTable dt = GrupoModel.GetPadres(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    GrupoBean obj = new GrupoBean
                    {
                        IDGrupo = int.Parse(row["IDGrupo"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        IdNivel = int.Parse(row["IdNivel"].ToString()),
                        CodigoPadreGrupo = row["CodigoPadreGrupo"].ToString(),
                        tipo = row["tipo"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                    };
                    result.Add(obj);
                }
            }
            return result;
        }
    }
}
