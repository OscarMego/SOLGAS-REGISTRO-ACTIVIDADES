
using ICSharpCode.SharpZipLib.Zip;
using Model;
using Model.bean;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;

namespace Controller
{
    public class DescargaController
    {
        public DescargaController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static Byte[] subDescargaFoto(List<FotoBean> loListFoto)
        {
            MemoryStream stream = new MemoryStream();
            ZipOutputStream oZipStream = new ZipOutputStream(stream);

            //string mensaje = IdiomaCultura.getMensaje(IdiomaCultura.WEB_DESCARGA_EXITOSA);//"Descarga Existosa";  

            foreach (FotoBean loFotoDato in loListFoto)
            {
                //ZipEntry entry = new ZipEntry(loFotoDato.nombreArchivo);
                ZipEntry entry = new ZipEntry(loFotoDato.titulo);
                entry.Size = loFotoDato.foto.Length;
                oZipStream.PutNextEntry(entry);
                oZipStream.Write(loFotoDato.foto, 0, loFotoDato.foto.Length);
                oZipStream.CloseEntry();
            }

            oZipStream.Finish();
            oZipStream.Close();
            return stream.ToArray();
        }
        //public static long descargaFotoCount(String cuenta, String campania, String fecinicio, String fecfin, String actividad, String equipo, String usuario, String pdv)
        //{
        //    int cantidad = 0;

        //    cantidad = DescargaDAL.descargaFotoCount(cuenta, campania, fecinicio, fecfin, actividad, equipo, usuario, pdv);

        //    return cantidad;
        //}

        public static List<FotoBean> descargaTransaccionFoto(String fechaInicio, String fechaFin, String lsGrupo, String lsUsuario, String lsEstado, String lsPuntoInteres, String lsGeoCerca)
        {
            return DescargaModel.descargaTransaccionFoto(fechaInicio, fechaFin, lsGrupo, lsUsuario, lsEstado, lsPuntoInteres, lsGeoCerca);
        }
        public static List<FotoBean> descargaFotoVisita(String IdVisita)
        {
            return DescargaModel.descargaFotoVisita(IdVisita);
        }

        public static List<FotoBean> seleccionarFotoDescargar(String fechaInicio, String fechaFin)
        {
            return DescargaModel.seleccionarFotos(fechaInicio, fechaFin);
        }

        public static int getLimiteMaximoDescargaFotos()
        {
            int iLimiteMaximoDescargaFotos = 100;
            if (ConfigurationManager.AppSettings["LIM_MAX_FOTOS_DESCARGA"] != null
                && !ConfigurationManager.AppSettings["LIM_MAX_FOTOS_DESCARGA"].ToString().Equals(""))
                iLimiteMaximoDescargaFotos = int.Parse(ConfigurationManager.AppSettings["LIM_MAX_FOTOS_DESCARGA"]);
            return iLimiteMaximoDescargaFotos;
        }
    }
}
