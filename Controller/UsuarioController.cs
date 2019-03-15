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
    public class UsuarioController
    {

        public static UsuarioBean validarUsuario(String login, String clave, String TipoAutenticacion)
        {
            UsuarioBean loBeanUsuario = new UsuarioBean();
            DataTable dt = UsuarioModel.validarUsuario(login, clave, TipoAutenticacion);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                //loBeanUsuario.IdResultado = row["Resultado"].ToString();
                loBeanUsuario.IdUsuario = int.Parse(row["id"].ToString());
                loBeanUsuario.Codigo = row["Codigo"].ToString();
                loBeanUsuario.Nombres = row["Nombre"].ToString();
                loBeanUsuario.IdCanal = int.Parse(row["IdCanal"].ToString());
                loBeanUsuario.NombreCanal = row["canal"].ToString();
                loBeanUsuario.IdPerfil = int.Parse(row["IdPerfil"].ToString());
                loBeanUsuario.NombrePerfil = row["perfil"].ToString();
                loBeanUsuario.Email = row["Email"].ToString();
                loBeanUsuario.FlgActiveDirectory = row["FlagAutenticacionAD"].ToString();
                

                dt = UsuarioModel.rolesUsuario(loBeanUsuario.IdPerfil);
                if (dt != null && dt.Rows.Count > 0)
                {
                    RolBean loRol;
                    loBeanUsuario.hashRol = new Dictionary<String, RolBean>();
                    foreach (DataRow dr in dt.Rows)
                    {
                        loRol = new RolBean();
                        loRol.IdMenu = dr["CodMenu"].ToString();
                        loRol.FlgCrear = dr["FlgCrear"].ToString();
                        loRol.FlgVer = dr["FlgVer"].ToString();
                        loRol.FlgEditar = dr["FlgEditar"].ToString();
                        loRol.FlgEliminar = dr["FlgEliminar"].ToString();
                        loBeanUsuario.hashRol.Add(loRol.IdMenu, loRol);
                    }
                }
            }

            return loBeanUsuario;
        }
    
        public static UsuarioBean infoUsuario(int id)
        {
            return UsuarioModel.Get(new UsuarioBean { IdUsuario = id });
        }
        public static UsuarioBean Get(UsuarioBean item)
        {
            return UsuarioModel.Get(item);
        }
        public static List<UsuarioBean> GetAll(UsuarioBean item)
        {
            return UsuarioModel.GetAll(item);
        }
        public static List<UsuarioBean> GetAllPorTipo(UsuarioBean item)
        {
            return UsuarioModel.GetAllPorTipo(item);
        }
        public static List<UsuarioBean> GetOportunidadUsuarioAll(UsuarioBean item)
        {
            return UsuarioModel.GetOportunidadUsuarioAll(item);
        }
        public static void Insert(UsuarioBean item)
        {
            try
            {
                UsuarioModel.Validate(item);
                UsuarioModel.Insert(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Update(UsuarioBean item)
        {
            try
            {
                UsuarioModel.Validate(item);
                UsuarioModel.Update(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static void Desactivate(UsuarioBean item)
        {
            UsuarioModel.Desactivate(item);
        }
        public static void Activate(UsuarioBean item)
        {
            UsuarioModel.Activate(item);
        }
        public static PaginateUsuarioBean GetAllPaginate(UsuarioBean item)
        {
            var result = UsuarioModel.GetAllPaginate(item);
            result.totalPages = Utility.calculateNumberOfPages(result.totalrows, item.rows);
            return result;
        }
        public static string Validate(UsuarioBean item)
        {
            return UsuarioModel.Validate(item);
        }
        public static List<UsuarioBean> GetVendedores(String Idusuario)
        {
            return UsuarioModel.GetVendedores(Idusuario);
        }

        public static string getUrlHome(int idPerfil) {
            return UsuarioModel.getUrlHome(idPerfil);
        }
    }

}
