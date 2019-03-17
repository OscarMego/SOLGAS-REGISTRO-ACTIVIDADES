using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Model.functions;
using Model.bean;
using System.Data;
using System.Collections;
using System.IO;
using System.Web.Security;
using System.Data.OleDb;

namespace Model
{
  public  class CargaModel
    {

      public static DataTable getErrores(String spName)
      {
          ArrayList alParameters = new ArrayList();

         return SqlConnector.getDataTable(spName, alParameters);
      }

        public static FileCargaBean executeBC_XLS(string dataFilePath, string tmpTable, string Nombre, String[][] mapping, String spLogic)
        {
            FileCargaBean BE = new FileCargaBean();
            BE.archivo = Nombre;
            try
            {
                String extension = Path.GetExtension(dataFilePath);
                string tipoDriver = "Microsoft.Jet.OLEDB.4.0"; // Por defecto es el de 32 bits
                if (extension == ".xlsx")
                {
                    tipoDriver = "Microsoft.ACE.OLEDB.12.0";
                }
                String excel_conexion = "Provider=" + tipoDriver + ";data source=" + dataFilePath + ";Extended Properties='Excel 8.0;HDR=YES;IMEX=1'";
                DataTable sourceData = new DataTable();
                String campos = "";
                for (int i = 0; i < mapping.Length; i++)
                {
                    campos += mapping[i][0] + ",";
                }
                campos = campos.Remove(campos.Length - 1, 1);
                using (OleDbConnection conn =
                                   new OleDbConnection(excel_conexion))
                {
                    conn.Open();
                    OleDbCommand command = new OleDbCommand(
                                        @"SELECT " + campos + " FROM [" + Nombre + "$]", conn);
                    OleDbDataAdapter adapter = new OleDbDataAdapter(command);
                    adapter.Fill(sourceData);
                    conn.Close();
                }
                if (tmpTable == "dbo.TMP_Usuario")
                {
                    DataTable dtCloned = sourceData.Clone();
                    dtCloned.Columns["CLAVE"].DataType = typeof(String);
                    foreach (DataRow row in sourceData.Rows)
                    {
                        dtCloned.ImportRow(row);
                    }
                    sourceData = dtCloned;
                    foreach (DataRow dr in sourceData.Rows) // search whole table
                    {
                        dr["CLAVE"] = FormsAuthentication.HashPasswordForStoringInConfigFile(dr["CLAVE"].ToString(), "sha1");
                    }
                }
                SqlConnector.copyData(sourceData, mapping, tmpTable);

                DataTable dt = SqlConnector.getDataTable(spLogic);
                foreach (DataRow row in dt.Rows)
                {
                    BE.subidos = Int32.Parse(row[0].ToString());
                    BE.insertados = Int32.Parse(row[1].ToString());
                    BE.actualizados = Int32.Parse(row[2].ToString());
                    BE.errorData = (string)row[3];
                }
            }
            catch (Exception ex1)
            {
                if (ex1.ToString().Contains("Received an invalid column length from the bcp client for colid"))
                {
                    BE.errorExecute += "Uno de los registros excede la logitud de campo.";
                }
                else
                {
                    BE.errorExecute += ex1.Message;
                }
            }
            return BE;
        }
        public static FileCargaBean executeBC_XLS_instalacion(string Nombre, String spLogic)
        {
            FileCargaBean BE = new FileCargaBean();
            BE.archivo = Nombre;
            try
            {
                DataTable dt = SqlConnector.getDataTable(spLogic);
                foreach (DataRow row in dt.Rows)
                {
                    BE.subidos = Int32.Parse(row[0].ToString());
                    BE.insertados = Int32.Parse(row[1].ToString());
                    BE.actualizados = Int32.Parse(row[2].ToString());
                    BE.errorData = (string)row[3];
                }
            }
            catch (Exception ex1)
            {
                if (ex1.ToString().Contains("Received an invalid column length from the bcp client for colid"))
                {
                    BE.errorExecute += "Uno de los registros excede la logitud de campo.";
                }
                else
                {
                    BE.errorExecute += ex1.Message;
                }
            }
            return BE;
        }
    }
}
