using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Descarga_Foto : PageController
{
    protected override void initialize()
    {
        if (Session["lgn_id"] == null || !fnValidarPerfilMenu("SPR", Model.Enumerados.FlagPermisoPerfil.VER))
        {
            Session.Clear();
            String lsScript = "parent.document.location.href = '../../default.aspx?acc=SES';";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", lsScript, true);
        }
        else
        {
            txtFecini.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtFecfin.Text = DateTime.Now.ToString("dd/MM/yyyy");
        }
    }
}
