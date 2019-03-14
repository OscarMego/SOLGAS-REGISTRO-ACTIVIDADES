using Model.bean;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;

namespace Controller
{
    public class CorreoController
    {
        
        public static void EnviarCorreos(BeanConfiguracion psConfi, List<BeanCorreos> psCorreos)
        {
            MailMessage objMail = new MailMessage();

            objMail.From = new MailAddress(psConfi.usuarioCorreo, "", System.Text.Encoding.UTF8); //remitente      
            String usuario = "";
            foreach (BeanCorreos correo in psCorreos)
            {
                if (correo.tipo=="V")
                {
                    objMail.To.Add(correo.email);
                    usuario = "Estimado <br>";
                }
                else
                {
                    objMail.CC.Add(correo.email);
                }
                
            }
            
            objMail.Subject = psCorreos[0].asunto;
            objMail.SubjectEncoding = System.Text.Encoding.UTF8;
            objMail.Body = usuario + psCorreos[0].msj;
            objMail.IsBodyHtml = true;

            SmtpClient SmtpMail = new SmtpClient();
            SmtpMail.Host = psConfi.servidorCorreos;
            //SmtpMail.Host = "aspmx.l.google.com";
            if (psConfi.puerto != 0)
                SmtpMail.Port = psConfi.puerto;

            //SmtpMail.Credentials = new System.Net.NetworkCredential(psConfi.usuarioCorreo, psConfi.contrasena);
            SmtpMail.UseDefaultCredentials = true;
            SmtpMail.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

            //if (ConfigurationManager.AppSettings["SMTP_TIMEOUT"] != null) {
            //   SmtpMail.Timeout = Int32.Parse(ConfigurationManager.AppSettings["SMTP_TIMEOUT"]);
            //}


            try
            {
                SmtpMail.Send(objMail);
            }
            catch (Exception merr)
            {
                throw;
            }
        }

    }
}
