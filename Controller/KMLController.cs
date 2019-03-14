using Controller.functions;
using Model.bean;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;

namespace Controller
{
    public class KMLController
    {
        public static List<FileCargaBean> ejecutarArchivoKML(String fileLocation)
        {
            List<FileCargaBean> lista = new List<FileCargaBean>();

            List<String> arrArchivosCargados = new List<String>();
            String[] extensions;
            //if (ConfigurationManager.AppSettings["DTSX"].Trim() == "1")
            extensions = new String[] { "*.kml" };
            //else
            //    extensions = new String[] { "*.xls" };

            foreach (String extension in extensions)
            {
                String[] filesArr = Directory.GetFiles(fileLocation, extension, SearchOption.TopDirectoryOnly);
                foreach (String file in filesArr)
                    arrArchivosCargados.Add(file);
            }

            //List<FileCargaBean> listaArchivos = new List<FileCargaBean>();
            FileCargaBean FileBean;

            String xml;

            foreach (String file in arrArchivosCargados)
            {
                FileBean = new FileCargaBean();
                try
                {
                    using (XmlSanitizingStream reader = new XmlSanitizingStream(new FileStream(file, FileMode.Open)))
                    {
                        xml = reader.ReadToEnd();
                    }

                    XmlDocument xmlDocument = new XmlDocument();

                    //xmlDocument.Load(file);
                    xmlDocument.LoadXml(xml);
                    xmlDocument.RemoveChild(xmlDocument.FirstChild);

                    int num1 = 0;
                    int num2 = 0;
                    int num3 = 0;
                    int num4 = 0;
                    XmlElement documentElement = xmlDocument.DocumentElement;
                    StringBuilder stringBuilder = new StringBuilder("<lp>");
                    foreach (XmlElement xmlElement in documentElement.FirstChild.ChildNodes)
                    {
                        if ("PLACEMARK".Equals(xmlElement.Name.ToUpper()))
                        {
                            ++num1;

                            string str = GeocercaController.registrarGeocercaAPartirDeXML(xmlElement.OuterXml);
                            if (str.Contains("|"))
                            {
                                string[] strArray = str.Split('|');
                                int result1 = 0;
                                int.TryParse(strArray[0].ToString(), out result1);
                                num3 += result1;
                                int result2 = 0;
                                int.TryParse(strArray[1].ToString(), out result2);
                                num4 += result2;
                                ++num2;
                            }
                        }
                    }
                    FileBean.archivo = file.Substring(file.LastIndexOf("\\") + 1, file.LastIndexOf(".") - file.LastIndexOf("\\") - 1);
                    FileBean.total = num2;//num2;
                    FileBean.subidos = num2;
                    FileBean.insertados = num3;
                    FileBean.actualizados = num4;

                }
                catch (Exception e)
                {
                    FileBean.errorExecute += e.Message;
                }
                lista.Add(FileBean);
            }

            deleteDataFiles(fileLocation);

            return lista;
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


        public string SanitizeXmlString(string xml)
        {
            if (xml == null)
            {
                throw new ArgumentNullException("xml");
            }

            StringBuilder buffer = new StringBuilder(xml.Length);

            foreach (char c in xml)
            {
                if (IsLegalXmlChar(c))
                {
                    buffer.Append(c);
                }
            }

            return buffer.ToString();
        }

        /// <summary>
        /// Whether a given character is allowed by XML 1.0.
        /// </summary>
        public bool IsLegalXmlChar(int character)
        {
            return
            (
                 character == 0x9 /* == '\t' == 9   */          ||
                 character == 0xA /* == '\n' == 10  */          ||
                 character == 0xD /* == '\r' == 13  */          ||
                (character >= 0x20 && character <= 0xD7FF) ||
                (character >= 0xE000 && character <= 0xFFFD) ||
                (character >= 0x10000 && character <= 0x10FFFF)
            );
        }

    }
}
