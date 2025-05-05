using System.Net.Mail;
using System.Net;

public static class UtilidadesCorreo
{
    public static bool EnviarCorreo(string destino, string asunto, string cuerpo)
    {
        try
        {
            var remitente = "capatourscr@gmail.com";
            var clave = "uyho rhbg dueg twnf";

            var smtp = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                Credentials = new NetworkCredential(remitente, clave),
                EnableSsl = true
            };

            var mail = new MailMessage(remitente, destino, asunto, cuerpo);
            smtp.Send(mail);

            return true;
        }
        catch (Exception ex)
        {
            
            Console.WriteLine($"Error al enviar correo: {ex.Message}");
            return false;
        }
    }
}


