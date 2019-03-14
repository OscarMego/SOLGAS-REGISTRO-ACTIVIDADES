using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Configuration;
namespace Model
{
    public class UsuarioModel
    {
        public static Int32 Insert(UsuarioBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombres", SqlDbType.VarChar, 80);
            parameter.Value = item.Nombres;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@LoginUsuario", SqlDbType.VarChar, 10);
            parameter.Value = item.LoginUsuario;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Email", SqlDbType.VarChar, 300);
            parameter.Value = item.Email;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@clave", SqlDbType.VarChar, 300);
            parameter.Value = item.clave;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@vendedores", SqlDbType.VarChar, 4000);
            parameter.Value = item.Vendedores;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdPerfil", SqlDbType.BigInt);
            parameter.Value = item.IdPerfil;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCanal", SqlDbType.BigInt);
            parameter.Value = item.IdCanal;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@VerificaAD", SqlDbType.VarChar, 100);
            parameter.Value = item.FlgActiveDirectory;
            alParameters.Add(parameter);

            return Convert.ToInt32(SqlConnector.executeScalar("spS_ManInsGRUsuario", alParameters));
        }
        public static void Update(UsuarioBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdUsuario", SqlDbType.BigInt);
            parameter.Value = item.IdUsuario;
            alParameters.Add(parameter);
            //parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            //parameter.Value = item.Codigo;
            //alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombres", SqlDbType.VarChar, 80);
            parameter.Value = item.Nombres;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@LoginUsuario", SqlDbType.VarChar, 10);
            parameter.Value = item.LoginUsuario;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Email", SqlDbType.VarChar, 300);
            parameter.Value = item.Email;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@clave", SqlDbType.VarChar, 300);
            parameter.Value = item.clave;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@vendedores", SqlDbType.VarChar, 4000);
            parameter.Value = item.Vendedores;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdPerfil", SqlDbType.BigInt);
            parameter.Value = item.IdPerfil;
            alParameters.Add(parameter);
            
            parameter = new SqlParameter("@IdCanal", SqlDbType.BigInt);
            parameter.Value = item.IdCanal;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@EditPass", SqlDbType.VarChar, 1);
            parameter.Value = item.EditPass;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@VerificaAD", SqlDbType.Char, 1);
            parameter.Value = item.FlgActiveDirectory;
            alParameters.Add(parameter);


            SqlConnector.executeNonQuery("spS_ManUpdGRUsuario", alParameters);
        }
        public static UsuarioBean Get(UsuarioBean item)
        {
            UsuarioBean obj = null;
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdUsuario", SqlDbType.BigInt);
            parameter.Value = item.IdUsuario;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRUsuario", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new UsuarioBean
                    {
                        IdUsuario = int.Parse(row["IdUsuario"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombres = row["Nombres"].ToString(),
                        LoginUsuario = row["LoginUsuario"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        clave = row["clave"].ToString(),
                        Email = row["Email"].ToString(),
                        IdPerfil = int.Parse(row["IdPerfil"].ToString()),
                        IdCanal = int.Parse(row["IdCanal"].ToString()),
                        FlgActiveDirectory = row["FlagAutenticacionAD"].ToString()

                    };
                }
            }
            return obj;
        }
        public static void Desactivate(UsuarioBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdUsuario", SqlDbType.BigInt);
            parameter.Value = item.IdUsuario;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRUsuarioDesactivate", alParameters);
        }
        public static void Activate(UsuarioBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdUsuario", SqlDbType.BigInt);
            parameter.Value = item.IdUsuario;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("spS_ManUpdGRUsuarioActivate", alParameters);
        }

        public static List<UsuarioBean> GetAll(UsuarioBean item)
        {
            List<UsuarioBean> lobj = new List<UsuarioBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombres", SqlDbType.VarChar, 80);
            parameter.Value = item.Nombres;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@LoginUsuario", SqlDbType.VarChar, 10);
            parameter.Value = item.LoginUsuario;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@clave", SqlDbType.VarChar, 300);
            parameter.Value = item.clave;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdPerfil", SqlDbType.BigInt);
            parameter.Value = item.IdPerfil;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCanal", SqlDbType.BigInt);
            parameter.Value = item.IdCanal;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRUsuarioAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    UsuarioBean obj = new UsuarioBean
                    {
                        IdUsuario = int.Parse(row["IdUsuario"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombres = row["Nombres"].ToString(),
                        LoginUsuario = row["LoginUsuario"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        clave = row["clave"].ToString(),
                        IdPerfil = int.Parse(row["IdPerfil"].ToString()),
                        IdCanal = int.Parse(row["IdCanal"].ToString()),
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static List<UsuarioBean> GetOportunidadUsuarioAll(UsuarioBean item)
        {
            List<UsuarioBean> lobj = new List<UsuarioBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombres", SqlDbType.VarChar, 80);
            parameter.Value = item.Nombres;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@LoginUsuario", SqlDbType.VarChar, 10);
            parameter.Value = item.LoginUsuario;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@clave", SqlDbType.VarChar, 300);
            parameter.Value = item.clave;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdPerfil", SqlDbType.BigInt);
            parameter.Value = item.IdPerfil;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@coordinadores", SqlDbType.VarChar, 2000);
            parameter.Value = item.Coordinadores;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGROportunidadUsuarioAll", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    UsuarioBean obj = new UsuarioBean
                    {
                        IdUsuario = int.Parse(row["IdUsuario"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombres = row["Nombres"].ToString(),
                        LoginUsuario = row["LoginUsuario"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        clave = row["clave"].ToString(),
                        IdPerfil = int.Parse(row["IdPerfil"].ToString())
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static PaginateUsuarioBean GetAllPaginate(UsuarioBean item)
        {
            List<UsuarioBean> lobj = new List<UsuarioBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 10);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Nombres", SqlDbType.VarChar, 200);
            parameter.Value = item.Nombres;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@LoginUsuario", SqlDbType.VarChar, 10);
            parameter.Value = item.LoginUsuario;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdCanal", SqlDbType.BigInt);
            parameter.Value = item.IdCanal;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdPerfil", SqlDbType.BigInt);
            parameter.Value = item.IdPerfil;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRUsuarioAllPaginate", alParameters);
            int total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    total = int.Parse(row["total"].ToString());
                    UsuarioBean obj = new UsuarioBean
                    {
                        item = int.Parse(row["item"].ToString()),
                        IdUsuario = int.Parse(row["IdUsuario"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombres = row["Nombres"].ToString(),
                        LoginUsuario = row["LoginUsuario"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        clave = row["clave"].ToString(),
                        Email = row["Email"].ToString(),
                        NombreCanal = row["NombreCanal"].ToString(),
                        IdCanal = int.Parse(row["IdCanal"].ToString()),
                        NombrePerfil = row["NombrePerfil"].ToString(),
                        IdPerfil= int.Parse(row["IdPerfil"].ToString())
                    }
                    ;
                    lobj.Add(obj);
                }
            }
            return new PaginateUsuarioBean { lstResultados = lobj, totalrows = total }
           ;
        }
        public static string Validate(UsuarioBean item)
        {
            string mensaje = "";
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdUsuario", SqlDbType.BigInt);
            parameter.Value = item.IdUsuario;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 50);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@LoginUsuario", SqlDbType.VarChar, 50);
            parameter.Value = item.LoginUsuario;
            alParameters.Add(parameter);

            //parameter = new SqlParameter("@Correo", SqlDbType.VarChar, 50);
            //parameter.Value = item.Email;
            //alParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_ManSelGRUsuarioValida", alParameters);
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

        public static DataTable validarUsuario(String lgn, String pwd, String TipoAutenticacion)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 100);
            parameter.Value = lgn;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@Clave", SqlDbType.VarChar, 50);
            parameter.Value = pwd;
            alParameters.Add(parameter);

            parameter = new SqlParameter("@TipoAutenticacion", SqlDbType.VarChar, 50);
            parameter.Value = TipoAutenticacion;
            alParameters.Add(parameter);

            return SqlConnector.getDataTable("spS_Login", alParameters);
        }

        public static DataTable rolesUsuario(Int32 idSupervisor)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter = new SqlParameter("@IdPerfil", SqlDbType.Int);
            parameter.Value = idSupervisor;
            alParameters.Add(parameter);

            return SqlConnector.getDataTable("spS_TraSelPerfilMenu", alParameters);
        }
        public static List<UsuarioBean> GetVendedores(String Idusuario)
        {
            List<UsuarioBean> lobj = new List<UsuarioBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter = new SqlParameter();
            parameter = new SqlParameter("@Coordinador", SqlDbType.VarChar, 50);
            parameter.Value = Idusuario;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_ManSelUsuarioVendedores", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    UsuarioBean obj = new UsuarioBean
                    {
                        IdUsuario = int.Parse(row["IdUsuario"].ToString()),
                        Codigo = row["Codigo"].ToString(),
                        Nombres = row["Nombres"].ToString(),
                        LoginUsuario = row["LoginUsuario"].ToString(),
                        FlgHabilitado = row["FlgHabilitado"].ToString(),
                        Email = row["Email"].ToString(),
                        Seleccion = row["Sel"].ToString(),
                        IdPerfil = int.Parse(row["IdPerfil"].ToString())
                    };
                    lobj.Add(obj);
                }
            }
            return lobj;
        }

        public static string getUrlHome(int idPerfil)
        {
            string urlHome = "";
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDPERFIL", SqlDbType.BigInt);
            parameter.Value = idPerfil;
            alParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_SelPantallaInicio", alParameters);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    urlHome = row["Url"].ToString();
                }
            }
            return urlHome;
        }

    }
}
