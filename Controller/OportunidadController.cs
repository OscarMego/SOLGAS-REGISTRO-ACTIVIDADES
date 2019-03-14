using System;
using System.Collections.Generic;
using System.Text;
using Model.bean;
using Model;
using System.Data;
using business.functions;
using System.Web.Script.Serialization;
using System.Web;
using Controller.functions;

namespace Controller
{
    public class OportunidadController
    {
        public static PaginateOportunidadBean GetAllPaginate(OportunidadBean item)
        {
            var result = OportunidadModel.GetAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static PaginateOportunidadBean GetReporteAllPaginate(OportunidadBean item)
        {
            var result = OportunidadModel.GetReporteAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static PaginateOportunidadBean GetNotifiReporteAllPaginate(OportunidadBean item)
        {
            var result = OportunidadModel.GetNotifiReporteAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static DataTable GetReporteAllPaginateExcel(OportunidadBean item)
        {
            return OportunidadModel.GetReporteAllPaginateExcel(item);
        }
        public static OportunidadBean GetOportunidad(OportunidadBean item)
        {
            return OportunidadModel.GetOportunidad(item);
        }
        public static List<ComboBean> GetFotoActividad(string idFoto)
        {
            return OportunidadModel.GetFotoActividad(idFoto);
        }
        public static List<ComboBean> GetConfiguraOportunidad()
        {
            return OportunidadModel.GetConfiguraOportunidad();
        }
        public static List<OportunidadBean> GetConfiguracionOportunidades(String idCodConf, String IdOp, String UsuSession, String storeprocedure)
        {
            return OportunidadModel.GetConfiguracionOportunidades(idCodConf, IdOp, UsuSession, storeprocedure);
        }
        public static List<OportunidadBean> GetConfiguracionNewOportunidades(String idCodConf)
        {
            return OportunidadModel.GetConfiguracionNewOportunidades(idCodConf);
        }
        public static List<OportunidadBean> GetConfiguracionEtapa(String idEtapa, String IdOp, String UsuSession)
        {
            List<OportunidadBean> lobj = OportunidadModel.GetConfiguracionEtapa(idEtapa, IdOp, UsuSession);
            if (!String.IsNullOrEmpty(IdOp))
            {
                ClienteBean cli = ClienteModel.getClienteOportunidad(IdOp);

                foreach (OportunidadBean op in lobj)
                {
                    op.RazonSocial = cli.Razon_Social;
                    op.CodCliente = cli.CLI_PK.ToString();
                }
            }
            return lobj;
        }
        public static List<OportunidadBean> GetConfiguracionEtapaHistorial(String idEtapa, String IdOp, String UsuSession)
        {
            List<OportunidadBean> lobj = OportunidadModel.GetConfiguracionEtapaHistorial(idEtapa, IdOp, UsuSession);
            if (!String.IsNullOrEmpty(IdOp))
            {
                ClienteBean cli = ClienteModel.getClienteOportunidad(IdOp);

                foreach (OportunidadBean op in lobj)
                {
                    op.RazonSocial = cli.Razon_Social;
                    op.CodCliente = cli.CLI_PK.ToString();
                }
            }
            return lobj;
        }
        public static List<ComboBean> GetEtapas(String codigo)
        {
            return OportunidadModel.GetEtapas(codigo);
        }
        public static List<ComboBean> GetEstado()
        {
            return OportunidadModel.GetEstado();
        }
        public static List<ComboBean> GetGrupos(String codigo, String idpadre = null)
        {
            return OportunidadModel.GetGrupos(codigo, idpadre);
        }
        public static List<Combo> GetClientesZonaCan(String cliente, String idZona, String idCanal)
        {
            return OportunidadModel.GetClientesZonCan(cliente, idZona, idCanal);
        }
        public static List<Combo> GetClientesOpor(String cliente)
        {
            return OportunidadModel.GetClientesOpor(cliente);
        }
        public static Int32 Insert(OportunidadBean item, String idClienteInstalacion)
        {
            try
            {
                return OportunidadModel.Insert(item, idClienteInstalacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static Int32 InsertOportunidad(OportunidadBean item)
        {
            try
            {
                return OportunidadModel.InsertOportunidad(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static Int32 InsertEtapa(OportunidadBean item)
        {
            try
            {
                var valor = OportunidadModel.InsertEtapa(item);
                if (item.CambiaEtapa == "T")
                {
                    try
                    {
                        //OportunidadController.NotificarOportunidad(item.id);
                    }
                    catch (Exception ex)
                    {
                        Logger.log(ex, ex.Message);
                    }
                }
                return valor;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void InsertFoto(String idOportunidad, String idFoto, Byte[] foto)
        {
            OportunidadModel.InsertFoto(idOportunidad, idFoto, foto);
        }
        public static List<ComboBean> GetGenerales(String codigo, String idpadre = null)
        {
            return OportunidadModel.GetGenerales(codigo, idpadre);
        }
        public static void Update(OportunidadBean item)
        {
            try
            {
                //UsuarioModel.Validate(item);
                OportunidadModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static List<OportunidadBean> GetConfiguracionEtapaLista(String IdOp)
        {
            return OportunidadModel.GetConfiguracionEtapaLista(IdOp);
        }
        public static void Active(String id, String flag)
        {
            OportunidadModel.Active(id, flag);
        }
        public static void Cerrar(String id, String flag)
        {
            OportunidadModel.Cerrar(id, flag);
        }
        public static List<FotoBean> GetOportunidadEtapaFoto(String idOportunidad, String idEtapa)
        {
            return OportunidadModel.GetOportunidadEtapaFoto(idOportunidad, idEtapa);
        }
        public static void NotificarOportunidad(String IdOportunidad)
        {
            bool valida = false;
            List<BeanCorreos> lstCorreos = new List<BeanCorreos>();
            DataTable Data = OportunidadModel.GetUsuariosOportunidad(IdOportunidad);

            foreach (DataRow drow in Data.Rows)
            {
                BeanCorreos bCorreos = new BeanCorreos();
                bCorreos.tipo = drow["tipo"].ToString().Trim();
                bCorreos.asunto = drow["asunto"].ToString().Trim();
                bCorreos.msj = drow["mensaje"].ToString().Trim(); ;
                bCorreos.email = drow["Email"].ToString().Trim();

                lstCorreos.Add(bCorreos);
                valida = true;
            }

            if (valida)
            {
                //Enviar Correos electronicos
                DataTable dataCorreo = CorreoModel.SelConfiguracionCorreo();
                BeanConfiguracion bconfe = new BeanConfiguracion();
                foreach (DataRow drow in dataCorreo.Rows)
                {
                    bconfe.servidorCorreos = drow["ServidorCorreos"].ToString().Trim();
                    bconfe.puerto = Convert.ToInt32(drow["PuertoCorreo"].ToString());
                    bconfe.usuarioCorreo = drow["UsuarioCorreo"].ToString().Trim();
                    bconfe.contrasena = drow["Contrasena"].ToString().Trim();
                }

                CorreoController.EnviarCorreos(bconfe, lstCorreos);
            }
        }

        public static List<Combo> GetClientes(String cliente)
        {
            return OportunidadModel.GetClientes(cliente);
        }

        public static PaginateOportunidadBean GetReporteAllPaginateOportunidades(OportunidadBean item)
        {
            var result = OportunidadModel.GetReporteAllPaginateOportunidades(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static DataTable GetReporteAllPaginateOportunidadesExcel(OportunidadBean item)
        {
            return OportunidadModel.GetReporteAllPaginateOportunidadesExcel(item);
        }
    }
}
