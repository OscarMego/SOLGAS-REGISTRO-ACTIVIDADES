using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using Model.bean;
using Model;
using System.Web.Security;
using System.Configuration;
using System.Web;

namespace Controller
{
    public class CargaController
    {
        public const int STR_SIN_ERROR = 0; // sin error validacion Carga y sin errores en archivo
        public const int STR_ERROR_ARCHIVO = 1; // sin error validacion Carga y con errores en archivo
        public const int STR_ERROR_VALIDAR_CARGA = 2; // con error validacion Carga
        public static int MAX_LON_CARGA = 302; // numero que define la cantidad maxima que se puede definir en una linea del archivo de carga
        public static int MAX_LON_CLAVE_USUARIO = 20; // numero que define la cantidad maxima para la clave del usuario
        public static List<FileCargaBean> ejecutarArchivoXLS(String fileLocation, String DTSLocation, String tipo)
        {
            List<FileCargaBean> lista = new List<FileCargaBean>();
            lista = carga_XLS(fileLocation, DTSLocation);
            deleteDataFiles(fileLocation);
            return lista;
        }

        private static List<FileCargaBean> carga_XLS(String filesLocation, String DTSLocation)
        {
            List<String> arrArchivosCargados = new List<String>();
            String[] extensions;
            extensions = new String[] { "*.xls", "*.xlsx" };
            foreach (String extension in extensions)
            {
                String[] filesArr = Directory.GetFiles(filesLocation, extension, SearchOption.TopDirectoryOnly);
                foreach (String file in filesArr)
                    arrArchivosCargados.Add(file);
            }

            List<FileCargaBean> listaArchivos = new List<FileCargaBean>();
            FileCargaBean FileBean;

            if (arrArchivosCargados != null && arrArchivosCargados.Count > 0)
            {
                string archivoExcel = arrArchivosCargados[0];
                foreach (string arch in arrArchivosCargados)
                {
                    FileBean = cargarZonas(arch);
                    listaArchivos.Add(FileBean);

                    FileBean = cargarUsuarios(arch);
                    listaArchivos.Add(FileBean);

                    FileBean = cargarGeneral(arch);
                    listaArchivos.Add(FileBean);

                    FileBean = cargarClientes(arch);
                    listaArchivos.Add(FileBean);

                    FileBean = cargarContactos(arch);
                    listaArchivos.Add(FileBean);
                }
            }

            return listaArchivos;
        }

        public static void deleteDataFiles(String filesLocation)
        {
            DirectoryInfo dir = new DirectoryInfo(filesLocation);
            foreach (FileInfo file in dir.GetFiles())
            {
                if (file.Extension != ".dts" && file.Extension != ".scc")
                    file.Delete();
            }
        }
        private static FileCargaBean cargarZonas(string dataFilePath)
        {
            String[][] mapping = new string[2][];
            mapping[0] = new String[2];
            mapping[1] = new String[2];
            mapping[0][0] = "CODIGO";
            mapping[0][1] = "Codigo";
            mapping[1][0] = "NOMBRE";
            mapping[1][1] = "Nombre";

            return CargaModel.executeBC_XLS(dataFilePath, "dbo.TMP_Zona", "ZONAS", mapping, "USP_CARGAZONA");
        }
        private static FileCargaBean cargarUsuarios(string dataFilePath)
        {
            String[][] mapping = new string[8][];
            mapping[0] = new String[2];
            mapping[1] = new String[2];
            mapping[2] = new String[2];
            mapping[3] = new String[2];
            mapping[4] = new String[2];
            mapping[5] = new String[2];
            mapping[6] = new String[2];
            mapping[7] = new String[2];
            //mapping[8] = new String[2];

            mapping[0][0] = "CODIGO";
            mapping[0][1] = "Codigo";

            mapping[1][0] = "NOMBRES";
            mapping[1][1] = "Nombres";

            mapping[2][0] = "LOGIN";
            mapping[2][1] = "LoginUsuario";

            mapping[3][0] = "CLAVE";
            mapping[3][1] = "Clave";

            mapping[4][0] = "PERFIL";
            mapping[4][1] = "CodPerfil";

            //mapping[5][0] = "ZONA";
            //mapping[5][1] = "Zona";

            mapping[5][0] = "NEGOCIO";
            mapping[5][1] = "Negocio";

            mapping[6][0] = "CORREO";
            mapping[6][1] = "Email";

            mapping[7][0] = "COORDINADOR";
            mapping[7][1] = "Coordinador";

            return CargaModel.executeBC_XLS(dataFilePath, "dbo.TMP_Usuario", "USUARIOS", mapping, "USP_CARGAUSUARIO");
        }

        private static FileCargaBean cargarGeneral(string dataFilePath)
        {
            String[][] mapping = new string[3][];
            mapping[0] = new String[2];
            mapping[1] = new String[2];
            mapping[2] = new String[2];
            mapping[0][0] = "CODIGO";
            mapping[0][1] = "Codigo";
            mapping[1][0] = "NOMBRE";
            mapping[1][1] = "Nombre";
            mapping[2][0] = "TIPO";
            mapping[2][1] = "Tipo";
            return CargaModel.executeBC_XLS(dataFilePath, "dbo.TMP_General", "GENERALES", mapping, "USP_CARGAGENERAL");
        }
        private static FileCargaBean cargarClientes(string dataFilePath)
        {
            String[][] mapping = new string[16][];
            mapping[0] = new String[2];
            mapping[1] = new String[2];
            mapping[2] = new String[2];
            mapping[3] = new String[2];
            mapping[4] = new String[2];
            mapping[5] = new String[2];
            mapping[6] = new String[2];
            mapping[7] = new String[2];
            mapping[8] = new String[2];
            mapping[9] = new String[2];
            mapping[10] = new String[2];
            mapping[11] = new String[2];
            mapping[12] = new String[2];
            mapping[13] = new String[2];
            mapping[14] = new String[2];
            mapping[15] = new String[2];

            mapping[0][0] = "RAZON_SOCIAL";
            mapping[0][1] = "Razon_Social";

            mapping[1][0] = "RUC";
            mapping[1][1] = "RUC";

            mapping[2][0] = "DIRECCION";
            mapping[2][1] = "Direccion";

            mapping[3][0] = "REFERENCIA";
            mapping[3][1] = "Referencia";

            mapping[4][0] = "NEGOCIO";
            mapping[4][1] = "CodNegocio";

            mapping[5][0] = "RUBRO";
            mapping[5][1] = "Rubro";

            mapping[6][0] = "REGION";
            mapping[6][1] = "Region";

            mapping[7][0] = "ORGANIZACION_VENTA";
            mapping[7][1] = "Organizacion_venta";

            mapping[8][0] = "CANAL";
            mapping[8][1] = "Canal";

            mapping[9][0] = "TIPO";
            mapping[9][1] = "Tipo";

            mapping[10][0] = "CODIGO_INSTALACION";
            mapping[10][1] = "CodInstalacion";

            mapping[11][0] = "DESCRIPCION";
            mapping[11][1] = "Descripcion";

            mapping[12][0] = "DIRECCION_I";
            mapping[12][1] = "Direccion_i";

            mapping[13][0] = "REFERENCIA_I";
            mapping[13][1] = "Referencia_i";

            mapping[14][0] = "USUARIO";
            mapping[14][1] = "Usuario";

            mapping[15][0] = "ZONA";
            mapping[15][1] = "Zona";

            return CargaModel.executeBC_XLS(dataFilePath, "dbo.TMP_Cliente", "CLIENTES", mapping, "USP_CARGACLIENTES");
        }


        private static FileCargaBean cargarContactos(string dataFilePath)
        {
            String[][] mapping = new string[6][];
            mapping[0] = new String[2];
            mapping[1] = new String[2];
            mapping[2] = new String[2];
            mapping[3] = new String[2];
            mapping[4] = new String[2];
            mapping[5] = new String[2];
            //mapping[6] = new String[2];

            mapping[0][0] = "NOMBRES";
            mapping[0][1] = "Nombres";

            mapping[1][0] = "TELEFONO";
            mapping[1][1] = "Telefono";

            mapping[2][0] = "EMAIL";
            mapping[2][1] = "Email";

            mapping[3][0] = "CARGO";
            mapping[3][1] = "Cargo";

            mapping[4][0] = "RUC_CLIENTE";
            mapping[4][1] = "Ruc_Cliente";

            mapping[5][0] = "COD_INSTALACION";
            mapping[5][1] = "CodInstalacion";

            //mapping[6][0] = "COD_ZONA";
            //mapping[6][1] = "CodZona";
            return CargaModel.executeBC_XLS(dataFilePath, "dbo.TMP_Contacto", "CONTACTOS", mapping, "USP_CARGACONTACTOS");
        }
    }
}
