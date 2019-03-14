using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using business.functions;
using System.Data;
namespace Controller
{
    public class SubTipoActividadController
    {
        public static SubTipoActividadBean Get(SubTipoActividadBean item)
        {
            SubTipoActividadBean obj = null;
            DataTable dt = SubTipoActividadModel.Get(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new SubTipoActividadBean
                    {
                        IDSubTipoActividad = row["IDSubTipoActividad"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        IdSubTipoActividadPredecesora = Int64.Parse(row["IdSubTipoActividadPredecesora"].ToString()),
                        TiempoEtapa = int.Parse(row["MetaDiaria"].ToString()),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        idtipoactividad = int.Parse(row["idtipoactividad"].ToString())
                    };
                }
            }
            return obj;
        }
        public static Int32 Insert(SubTipoActividadBean item)
        {
            Int32 id = 0;
            try
            {
                //ConfiguracionOportunidadController.Validate(item);
                id = SubTipoActividadModel.Insert(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return id;
        }
        public static void Update(SubTipoActividadBean item)
        {
            try
            {
                //ConfiguracionOportunidadController.Validate(item);
                SubTipoActividadModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Activate(SubTipoActividadBean item)
        {
            SubTipoActividadModel.Activate(item);
        }
        public static PaginateConfiguracionOportunidadBean GetAllPaginate(SubTipoActividadBean item)
        {
            PaginateConfiguracionOportunidadBean result = new PaginateConfiguracionOportunidadBean();
            DataTable dt = SubTipoActividadModel.GetAllPaginate(item);
            List<SubTipoActividadBean> lobj = new List<SubTipoActividadBean>();
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    SubTipoActividadBean obj = new SubTipoActividadBean
                    {
                        IDSubTipoActividad = row["IDSubTipoActividad"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        tipoactividad = row["TipoActividad"].ToString()
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            result.lstResultados = lobj;
            result.totalrows = total;

            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }

        public static List<SubTipoActividadBean> GetAllByType(String Codigo)
        {
            DataTable dt= SubTipoActividadModel.GetAllByType(Codigo);
            List<SubTipoActividadBean> lobj = new List<SubTipoActividadBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {                  
                    SubTipoActividadBean obj = new SubTipoActividadBean
                    {
                        IDSubTipoActividad = row["IDSubTipoActividad"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        tipoactividad = row["idtipoactividad"].ToString()
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<SubTipoActividadBean> GetAll(String Codigo)
        {
            DataTable dt = SubTipoActividadModel.GetAll(Codigo);
            List<SubTipoActividadBean> lobj = new List<SubTipoActividadBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    SubTipoActividadBean obj = new SubTipoActividadBean
                    {
                        IDSubTipoActividad = row["IDSubTipoActividad"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        tipoactividad = row["idtipoactividad"].ToString()
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static string Validate(SubTipoActividadBean item)
        {
            string mensaje = "";
            DataTable dt = SubTipoActividadModel.Validate(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    mensaje += row["Mensaje"].ToString() + ", ";
                }
                mensaje = mensaje.Substring(0, mensaje.Length - 2);
                throw new Exception(mensaje);
            }
            return "";
        }
        public static List<SubTipoActividadDetBean> GetAllControl(SubTipoActividadBean item)
        {
            List<SubTipoActividadDetBean> lobj = new List<SubTipoActividadDetBean>();

            DataTable dt = SubTipoActividadModel.GetAllControl(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    SubTipoActividadDetBean obj = new SubTipoActividadDetBean
                    {

                        Index = (int.Parse(row["item"].ToString()) - 1).ToString(),
                        IdSubTipoActividadDetalle = row["IdSubTipoActividadDetalle"].ToString(),
                        DesSubTipoActividadDetPadre = row["DesSubTipoActividadDetPadre"].ToString(),
                        Etiqueta = row["Etiqueta"].ToString(),
                        IdTipoControl = row["IdTipoControl"].ToString(),
                        TipoControlDescrip = row["TipoControlDescrip"].ToString(),
                        MaxCaracter = row["MaxCaracter"].ToString(),
                        CodigoGeneral = row["CodigoGeneral"].ToString(),
                        DescripcionGeneral = row["DescripcionGeneral"].ToString(),
                        Obligatorio = row["Obligatorio"].ToString(),
                        Modificable = row["Modificable"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        Perfiles = row["Perfiles"].ToString(),
                        PerfilesDesc = row["PerfilesDesc"].ToString(),
                        CodigoTipoControl = row["TipoControlCodigo"].ToString(),
                        IDSubTipoActividad = row["IDSubTipoActividad"].ToString(),
                        IdSubTipoActividadDetPadre = row["IdSubTipoActividadDetPadre"].ToString(),
                        FlgPadre = row["FlgPadre"].ToString(),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static SubTipoActividadBean GetSubTipoActividadPredecesora(SubTipoActividadBean item)
        {
            SubTipoActividadBean obj = null;
            DataTable dt = SubTipoActividadModel.GetSubTipoActividadPredecesora(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new SubTipoActividadBean
                    {
                        IDSubTipoActividad = row["IDSubTipoActividad"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                    };
                }
            }
            return obj;
        }

        public static List<SubTipoActividadBean> GetSubTipoActividadPredecesoraAll(SubTipoActividadBean item)
        {
            List<SubTipoActividadBean> lobj = new List<SubTipoActividadBean>();

            DataTable dt = SubTipoActividadModel.GetSubTipoActividadPredecesoraAll(item);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    SubTipoActividadBean obj = new SubTipoActividadBean
                    {

                        IDSubTipoActividad = row["IDSubTipoActividad"].ToString(),
                        Descripcion = row["Descripcion"].ToString(),
                        IdSubTipoActividadPredecesora = long.Parse(row["IdSubTipoActividadPredecesora"].ToString()),

                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }
    }
}
