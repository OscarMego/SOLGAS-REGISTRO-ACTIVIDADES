using Model.bean;
using Model.functions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Model
{
    public class DescargaModel
    {
        public static List<FotoBean> descargaTransaccionFoto(String fechaInicio, String fechaFin, String lsGrupo, String lsUsuario, String lsEstado, String lsPuntoInteres, String lsGeoCerca)
        {
            ArrayList allParameters = new ArrayList();

            SqlParameter parameter;

            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = fechaInicio;
            allParameters.Add(parameter);

            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = fechaFin;
            allParameters.Add(parameter);

            parameter = new SqlParameter("@IdGrupo", SqlDbType.VarChar, 2000);
            parameter.Value = lsGrupo;
            allParameters.Add(parameter);

            parameter = new SqlParameter("@IdUsuario", SqlDbType.VarChar, 2000);
            parameter.Value = lsUsuario;
            allParameters.Add(parameter);

            parameter = new SqlParameter("@IdEstado", SqlDbType.VarChar, 2000);
            parameter.Value = lsEstado;
            allParameters.Add(parameter);

            parameter = new SqlParameter("@FlagPuntoInteres", SqlDbType.VarChar, 200);
            parameter.Value = lsPuntoInteres;
            allParameters.Add(parameter);

            parameter = new SqlParameter("@FlagGeoCerca", SqlDbType.VarChar, 200);
            parameter.Value = lsGeoCerca;
            allParameters.Add(parameter);




            DataTable dt = SqlConnector.getDataTable("spS_RepSelVisitaActivas_Fotos", allParameters);
            List<FotoBean> loListaFoto = new List<FotoBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                FotoBean loFotoBean = null;
                foreach (DataRow row in dt.Rows)
                {
                    loFotoBean = new FotoBean();
                    loFotoBean.idFoto = row["idVisitaFoto"].ToString().Trim();
                    loFotoBean.titulo = row["NombreFoto"].ToString().Trim();
                    loFotoBean.foto = (Byte[])row["FotoVisita"];
                    //loFotoBean.codigoActividad = loSDR.GetValue(loSDR.GetOrdinal("ID_ACTIVIDAD")).ToString().Trim();
                    //loFotoBean.Descripcion = loSDR.GetValue(loSDR.GetOrdinal("CODIGO_EMPRESA")).ToString().Trim();
                    //loFotoBean.FechaFoto = loSDR.GetValue(loSDR.GetOrdinal("FECHA")).ToString().Trim();
                    loListaFoto.Add(loFotoBean);
                }
            }

            return loListaFoto;
        }

        public static List<FotoBean> descargaFotoVisita(String IdVisita)
        {
            ArrayList allParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdVisita", SqlDbType.VarChar, 10);
            parameter.Value = IdVisita;
            allParameters.Add(parameter);
            DataTable dt = SqlConnector.getDataTable("spS_RepSelVisitaInforView_Foto", allParameters);
            List<FotoBean> loListaFoto = new List<FotoBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                FotoBean loFotoBean = null;
                foreach (DataRow row in dt.Rows)
                {
                    loFotoBean = new FotoBean();
                    loFotoBean.idFoto = row["idVisitaFoto"].ToString().Trim();
                    loFotoBean.titulo = row["NombreFoto"].ToString().Trim();
                    loFotoBean.foto = (Byte[])row["FotoVisita"];
                    loListaFoto.Add(loFotoBean);
                }
            }
            return loListaFoto;
        }

        public static List<FotoBean> seleccionarFotos(String fechaInicio, String fechaFin)
        {
            ArrayList allParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@FechaInicio", SqlDbType.VarChar, 10);
            parameter.Value = fechaInicio;
            allParameters.Add(parameter);

            parameter = new SqlParameter("@FechaFin", SqlDbType.VarChar, 10);
            parameter.Value = fechaFin;
            allParameters.Add(parameter);

            DataTable dt = SqlConnector.getDataTable("spS_SelFotos", allParameters);
            List<FotoBean> loListaFoto = new List<FotoBean>();
            if (dt != null && dt.Rows.Count > 0)
            {
                FotoBean loFotoBean = null;
                foreach (DataRow row in dt.Rows)
                {
                    loFotoBean = new FotoBean();
                    loFotoBean.idFoto = row["IdFoto"].ToString().Trim();
                    loFotoBean.titulo = row["Titulo"].ToString().Trim();
                    loFotoBean.foto = (Byte[])row["Foto"];
                    loListaFoto.Add(loFotoBean);
                }
            }
            return loListaFoto;
        }
    }
}
