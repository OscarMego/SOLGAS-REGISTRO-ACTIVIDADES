using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.OracleClient;
namespace Model.functions
{
    public class OracleDAC
    {
        public static string getPaquete()
        {
            return ((object)ConfigurationManager.AppSettings["package"]).ToString();
        }
        public static DataSet getDataset(string spName, ArrayList alParametros)
        {
            OracleConnection connection = OracleDAC.getConnection();
            OracleCommand command = OracleDAC.getCommand(connection, spName, alParametros);
            command.CommandType = CommandType.StoredProcedure;
            OracleDataAdapter oracleDataAdapter = new OracleDataAdapter(command);
            DataSet dataSet = new DataSet();
            ((DataAdapter)oracleDataAdapter).Fill(dataSet);
            OracleDAC.closeConnection(connection);
            return dataSet;
        }

        public static DataSet getDataset(string sql)
        {
            OracleConnection connection = OracleDAC.getConnection();
            OracleCommand command = OracleDAC.getCommand(connection, sql);
            command.CommandType = CommandType.Text;
            OracleDataAdapter oracleDataAdapter = new OracleDataAdapter(command);
            DataSet dataSet = new DataSet();
            ((DataAdapter)oracleDataAdapter).Fill(dataSet);
            OracleDAC.closeConnection(connection);
            return dataSet;
        }

        public static object executeScalar(string sql, ArrayList alParametros)
        {
            OracleConnection connection = OracleDAC.getConnection();
            OracleCommand command = OracleDAC.getCommand(connection, sql, alParametros);
            command.CommandType = CommandType.Text;
            object obj = command.ExecuteScalar();
            OracleDAC.closeConnection(connection);
            return obj;
        }

        public static void executeNonQuery(string spName, ArrayList alParametros)
        {
            OracleConnection connection = OracleDAC.getConnection();
            OracleCommand command = OracleDAC.getCommand(connection, spName, alParametros);
            command.CommandType = CommandType.StoredProcedure;
            command.ExecuteNonQuery();
            OracleDAC.closeConnection(connection);
        }

        private static OracleConnection getConnection()
        {
            OracleConnection oracleConnection = new OracleConnection(OracleDAC.getConnectionString());
            oracleConnection.Open();
            return oracleConnection;
        }

        private static string getConnectionString()
        {
            ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["SqlServices"];
            return ConfigurationManager.ConnectionStrings["oraService"].ConnectionString;
        }

        private static OracleCommand getCommand(OracleConnection conn, string spName, ArrayList alParametros)
        {
            OracleCommand oracleCommand = new OracleCommand(spName, conn);
            foreach (OracleParameter oracleParameter in alParametros)
                oracleCommand.Parameters.Add(oracleParameter);
            return oracleCommand;
        }

        private static OracleCommand getCommand(OracleConnection conn, string sql)
        {
            return new OracleCommand(sql, conn);
        }

        private static void closeConnection(OracleConnection conn)
        {
            conn.Close();
        }
    }
}