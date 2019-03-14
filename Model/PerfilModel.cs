using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Data.OracleClient;
namespace Model
{
    public class PerfilModel
    {
        public static List<PerfilBean> GetAll(PerfilBean item)
        {
            DataSet ds;

            List<PerfilBean> lobj = new List<PerfilBean>();
            ArrayList alParameters = new ArrayList();
            SqlParameter parameter;

            parameter = new SqlParameter("Descripcion", SqlDbType.VarChar, 100);
            parameter.Value = item.Descripcion;
            alParameters.Add(parameter);
            parameter = new SqlParameter("FlgHabilitado", SqlDbType.VarChar, 10);
            parameter.Value = item.FlgHabilitado;
            alParameters.Add(parameter);

            ds = SqlConnector.getDataset("spS_ManSelGRPerfilAll", alParameters);
            int total = 0;
 
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    total = ds.Tables[0].Rows.Count;
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        PerfilBean obj = new PerfilBean
                        {
                            IdPerfil = int.Parse(row["IdPerfil"].ToString()),
                            Descripcion = row["Descripcion"].ToString(),
                            FlgHabilitado = row["FlgHabilitado"].ToString()
                        };
                        lobj.Add(obj);
                    }
                }
            }

            return lobj;
        }

    }
}
