using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Model.functions;
using System.Collections;
using Model.bean;
using System.Data.SqlClient;

namespace Model
{
    public class ComboModel
    {
        #region COMBO MULTISELECT
        public static DataTable ComboPV(String flag)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameterv = new SqlParameter("@FLAG", SqlDbType.VarChar, 50);
            parameterv.Value = flag;
            alParameters.Add(parameterv);
            return SqlConnector.getDataTable("spS_ComboGrupo", alParameters);
        }
        public static DataTable ComboUsuario(String Grupo, int IdSupervisor)
        {
            ArrayList alParameters = new ArrayList();
            SqlParameter parameterv = new SqlParameter("@GRUPO", SqlDbType.VarChar, 8000);
            parameterv.Value = Grupo;
            alParameters.Add(parameterv);
            parameterv = new SqlParameter("@IDSUPERVISOR", SqlDbType.Int);
            parameterv.Value = IdSupervisor;
            alParameters.Add(parameterv);
            return SqlConnector.getDataTable("spS_ComboUsuario", alParameters);
        }
        public static DataTable ComboEstadoVisita()
        {
            ArrayList alParameters = new ArrayList();
            return SqlConnector.getDataTable("sps_ComboEstadoVisita", alParameters);
        }

        #endregion
                                  
    }
}
