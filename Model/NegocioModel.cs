using Model.bean;
using Model.functions;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Model
{
   public class NegocioModel
    {
        public static List<NegocioBean> GetAll(NegocioBean item,string IDUSUARIO)
        {
            DataSet ds;

            List<NegocioBean> lobj = new List<NegocioBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;

            parameter = new SqlParameter("@codigo", SqlDbType.VarChar, 100);
            parameter.Value = item.Codigo;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@nombre", SqlDbType.VarChar, 100);
            parameter.Value = item.Nombre;
            alParameters.Add(parameter);
            parameter = new SqlParameter("@FiltroUsuario", SqlDbType.VarChar, 100);
            parameter.Value = IDUSUARIO;
            alParameters.Add(parameter);
            
            ds = SqlConnector.getDataset("spS_ManSelGRNegocioAll", alParameters);
            int total = 0;

            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    total = ds.Tables[0].Rows.Count;
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        NegocioBean obj = new NegocioBean
                        {
                            IdNegocio = int.Parse(row["IdNegocio"].ToString()),
                            Codigo= row["Codigo"].ToString(),
                            Nombre= row["Nombre"].ToString()
                        };
                        lobj.Add(obj);
                    }
                }
            }

            return lobj;
        }
    }
}