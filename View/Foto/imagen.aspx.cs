using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Model.bean;
using System.Drawing;

public partial class Foto_imagen : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Int32 pagactual = Convert.ToInt32(Request.QueryString["item"].ToString());
            byte[] imageData = null;
            MemoryStream ms = null;
            List<FotoBean> lfoto=(List<FotoBean>)Session["FotosLista"];
            imageData = lfoto[pagactual].foto;

            if (imageData != null)
            {
                ms = new MemoryStream(imageData);

                System.Drawing.Image loDrawImage = System.Drawing.Image.FromStream(ms);

                //-------------------------------------------
                //Decirle al Image que pinte en la pagina
                //-------------------------------------------

                System.Drawing.Image thumbnail = new Bitmap(500, 379);
                System.Drawing.Graphics graphic = System.Drawing.Graphics.FromImage(thumbnail);
                graphic.DrawImage(loDrawImage, 0, 0, 500, 379);
                Response.ContentType = "image/jpeg";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Random r = new Random(DateTime.Now.Millisecond);
                Response.AddHeader("PDV", r.Next(1000, 9999).ToString());
                thumbnail.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);

                //loDrawImage.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
        }
    }
}