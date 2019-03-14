using System;
using System.Collections.Generic;
using System.Text;
using Model.bean;
using Model;
using System.Data;
using business.functions;
using System.Web.Script.Serialization;
using System.Web;

namespace Controller
{
    public class EtapaController
    {
        
        public static EtapaBean Get(EtapaBean item)
        {
            return EtapaModel.Get(item);
        }
        public static EtapaBean GetDetalle(EtapaBean item)
        {
            return EtapaModel.GetDetalle(item);
        }
        public static List<EtapaBean> GetAll(EtapaBean item)
        {
            return EtapaModel.GetAll(item);
        }
        public static List<EtapaBean> ObtenerEtapaPredecesora(String Codigo, EtapaBean item)
        {
            return EtapaModel.ObtenerEtapaPredecesora(Codigo, item);
        }
        public static List<TipoControlBean> ObtenerTipoControl(TipoControlBean item)
        {
            return EtapaModel.ObtenerTipoControl(item);
        }
        public static List<GrupoBean> ObtenerGrupo(GrupoBean item)
        {
            return EtapaModel.ObtenerGrupo(item);
        }
               
        public static int Insert(EtapaBean item)
        {
            try
            {
                EtapaModel.Validate(item);
                return EtapaModel.Insert(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void InsertDetalle(List<EtapaBean> item)
        {
            try {
                //EtapaModel.ValidateDetalle(item);
                EtapaModel.InsertDetalle(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public static void Update(EtapaBean item)
        {
            try
            {
                //EtapaModel.Validate(item);
                EtapaModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Desactivate(EtapaBean item)
        {
            EtapaModel.Desactivate(item);
        }
        public static void Activate(EtapaBean item)
        {
            EtapaModel.Activate(item);
        }
        public static PaginateEtapaBean GetAllPaginate(EtapaBean item)
        {
            var result = EtapaModel.GetAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static string Validate(EtapaBean item)
        {
            return EtapaModel.Validate(item);
        }
        public static List<PerfilBean> GetEtapaPerfilModifica(String idEtapaDetalle)
        {
            List<PerfilBean> lper = new List<PerfilBean>();
            DataTable dt = EtapaModel.GetEtapaPerfilModifica(idEtapaDetalle);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    PerfilBean Perfiles;
                    Perfiles = new PerfilBean
                    {
                        IdPerfil = int.Parse(row["IdPerfilModifica"].ToString())
                    };
                }
            }
            return lper;
        }
    }
}
