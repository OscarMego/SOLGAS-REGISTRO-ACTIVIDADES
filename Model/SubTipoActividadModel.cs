using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
namespace Model
{
    public class SubTipoActividadModel
    {
        public static Int32 Insert(SubTipoActividadBean item)
        {
            // Create a DataTable with the modified rows.  
            DataTable oDataTableLstCrtDin = new DataTable();
            oDataTableLstCrtDin = OportunidadModel.ConvertToDataTable(item.lstControlDinamico2);

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Descripcion", SqlDbType.VarChar, 100);
            parameter.Value = item.Descripcion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idtipoactividad", SqlDbType.Int);
            parameter.Value = item.idtipoactividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdSubTipoActividadPredecesora", SqlDbType.BigInt);
            if (item.IdSubTipoActividadPredecesora == 0)
            {
                parameter.Value = DBNull.Value;
            }
            else
            {
                parameter.Value = item.IdSubTipoActividadPredecesora;
            }
            
            alParameters.Add(parameter);
            parameter = new SqlParameter("@MetaDiaria", SqlDbType.Int);
            if (item.TiempoEtapa == 0)
            {
                parameter.Value = DBNull.Value;
            }
            else
            {
                parameter.Value = item.TiempoEtapa;
            }

            alParameters.Add(parameter);
            parameter = new SqlParameter("@lstCrt", SqlDbType.Structured);
            parameter.Value = oDataTableLstCrtDin;
            alParameters.Add(parameter);
            return Convert.ToInt32(SqlConnector.executeScalar("sps_ManInsGRSubTipoActividad", alParameters));
        }
        public static void Update(SubTipoActividadBean item)
        {
            // Create a DataTable with the modified rows.  
            DataTable oDataTableLstCrtDin = new DataTable();
            oDataTableLstCrtDin = OportunidadModel.ConvertToDataTable(item.lstControlDinamico2);

            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDSubTipoActividad", SqlDbType.VarChar, 100);
            parameter.Value = item.IDSubTipoActividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@codigo", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@TipoActividad", SqlDbType.Int);
            parameter.Value = item.idtipoactividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@IdSubTipoActividadPredecesora", SqlDbType.BigInt);
            parameter.Value = item.IdSubTipoActividadPredecesora;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@MetaDiaria", SqlDbType.Int);
            parameter.Value = item.TiempoEtapa;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Descripcion", SqlDbType.VarChar, 100);
            parameter.Value = item.Descripcion;
            alParameters.Add(parameter);


            parameter = new SqlParameter("@lstCrt", SqlDbType.Structured);
            parameter.Value = oDataTableLstCrtDin;
            alParameters.Add(parameter);

            SqlConnector.executeNonQuery("sps_ManUpdGRSubTipoActividad", alParameters);
        }
        public static DataTable Get(SubTipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDSubTipoActividad", SqlDbType.VarChar, 100);
            parameter.Value = item.IDSubTipoActividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@codigo", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Descripcion", SqlDbType.VarChar, 100);
            parameter.Value = item.Descripcion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@tipoactividad", SqlDbType.Int);
            parameter.Value = item.idtipoactividad;
            alParameters.Add(parameter);

            return SqlConnector.getDataTable("sps_SelGRSubTipoActividad", alParameters);

        }
        public static void Activate(SubTipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDSubTipoActividad", SqlDbType.VarChar, 20);
            parameter.Value = item.IDSubTipoActividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@flag", SqlDbType.VarChar, 20);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            SqlConnector.executeNonQuery("sps_ManUpdGRSubTipoAtividadActive", alParameters);
        }
        public static DataTable GetAllPaginate(SubTipoActividadBean item)
        {
            List<SubTipoActividadBean> lobj = new List<SubTipoActividadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Descripcion", SqlDbType.VarChar, 100);
            parameter.Value = item.Descripcion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FlgHabilitado", SqlDbType.Char, 1);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@TipoActividad", SqlDbType.VarChar, 50);
            parameter.Value = item.idtipoactividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@page", SqlDbType.Int);
            parameter.Value = item.page;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@rows", SqlDbType.Int);
            parameter.Value = item.rows;
            alParameters.Add(parameter);
            return SqlConnector.getDataTable("spS_ManSelGRSubTipoActividadPaginate", alParameters);

        }

        public static DataTable GetAllByType(String Codigo, String idusuario)
        {
            List<SubTipoActividadBean> lobj = new List<SubTipoActividadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.BigInt);
            parameter.Value = Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@idusuario", SqlDbType.BigInt);
            parameter.Value = idusuario;
            alParameters.Add(parameter);
            return SqlConnector.getDataTable("spS_ManSelGRSubTipoActividadByType", alParameters);

        }

        public static DataTable GetAll(String Codigo)
        {
            List<SubTipoActividadBean> lobj = new List<SubTipoActividadBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@Codigo", SqlDbType.BigInt);
            parameter.Value = Codigo;
            alParameters.Add(parameter);
            return SqlConnector.getDataTable("spS_ManSelGRSubTipoActividadAll", alParameters);

        }

        public static DataTable Validate(SubTipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDSubTipoActividad", SqlDbType.VarChar, 200);
            parameter.Value = item.IDSubTipoActividad;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@Codigo", SqlDbType.VarChar, 200);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            return SqlConnector.getDataTable("spS_ManSelGRSubTipoActividadValida", alParameters);
        }
        public static DataTable GetAllControl(SubTipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IDSubTipoActividad", SqlDbType.VarChar, 15);
            parameter.Value = item.IDSubTipoActividad;
            alParameters.Add(parameter);

            return SqlConnector.getDataTable("spS_ManSelSubTipoActividadDetAll", alParameters);
        }

        public static DataTable GetSubTipoActividadPredecesora(SubTipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdTipoActividad", SqlDbType.Int);
            parameter.Value = item.idtipoactividad;
            alParameters.Add(parameter);

            return SqlConnector.getDataTable("sps_SelGRSubTipoActividadPredecesora", alParameters);

        }

        public static DataTable GetSubTipoActividadPredecesoraAll(SubTipoActividadBean item)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;
            parameter = new SqlParameter("@IdTipoActividad", SqlDbType.Int);
            parameter.Value = item.idtipoactividad;
            alParameters.Add(parameter);

            return SqlConnector.getDataTable("sps_SelGRSubTipoActividadPredecesoraAll", alParameters);

        }

    }
}
