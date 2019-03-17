using Controller;
using Model.bean;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace View.Acciones.Carga
{
    public partial class CargaErrores : PageController
    {
        private char[] _separador = { '|' };
        protected override void initialize()
        {
            string json = new System.IO.StreamReader(Request.InputStream).ReadToEnd();

            Dictionary<string, string> dataJSON = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);
            if (dataJSON != null)
            {
                modalLabel.InnerText = dataJSON["codigo"].ToUpper();
                label2.InnerText = "Formato inválido del archivo " + dataJSON["codigo"] + ". Por favor, revíselo. SOLO SE MUESTRAN LOS 100 PRIMEROS";
                System.Data.DataTable dt = GeneralController.getErroresCarga(dataJSON["codigo"]);
                numerReg.Value = dt.Rows.Count.ToString();
                grilla.DataSource = dt;
                grilla.DataBind();
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            int cantColumnas = e.Row.Cells.Count - 1;

            if (e.Row.RowType == DataControlRowType.Header)
            {
                for (int i = 0; i <= cantColumnas; i++)
                {
                    e.Row.Cells[i].Text = IdiomaCultura.getMensajeEncodeHTML(e.Row.Cells[i].Text).ToUpper();
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                //_errores = _rowView["ERROR"].ToString();

                String _errores = e.Row.Cells[cantColumnas].Text;
                string[] _arrErrores = _errores.Split(_separador);
                StringBuilder _listaErrores = new StringBuilder();

                foreach (string error in _arrErrores)
                {
                    if (error != string.Empty)
                    {
                        _listaErrores.Append(error).Append("<br/>");
                    }
                }

                //la ultima columna es de los errores
                e.Row.Cells[e.Row.Cells.Count - 1].Style.Value = "text-align:left;";
                e.Row.Cells[e.Row.Cells.Count - 1].Text = _listaErrores.ToString();
                //rowView["ERROR"] = listaErrores.ToString();
                _listaErrores = null;
            }


        }
    }
}