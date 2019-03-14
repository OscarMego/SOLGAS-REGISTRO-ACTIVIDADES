using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Configuration;
using System.Data.OracleClient;

namespace Model
{
    public class GeneralModel
    {
       public static String obtenerTemaActual()
       {
           WS.Service.Service loService = new WS.Service.Service();
           try
           {
               return loService.obtenerTemaActual();
           }
           finally
           {
               loService = null;
           }
       }
       public static DataTable getCultureIdioma()
       {
           ArrayList alParameters = new ArrayList();
           return SqlConnector.getDataTable("spS_AuxSelIdioma");

       }
       public static DataTable getCultureIdiomaOracle()
       {
           DataSet ds;
           ArrayList alParameters = new ArrayList();
           OracleParameter parameter;
           parameter = new OracleParameter("nexcursor", OracleType.Cursor);
           parameter.Direction = ParameterDirection.ReturnValue;
           alParameters.Add(parameter);
           var dato = OracleDAC.getPaquete() + ".spS_AuxSelIdioma";
           ds = OracleDAC.getDataset(dato, alParameters);
           if (ds != null)
           {
               if (ds.Tables[0].Rows.Count > 0)
               {
                   return ds.Tables[0];
               }
           }
           return null;
       }
    }
}
