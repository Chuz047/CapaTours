using System.Text;
using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers
{
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public class ErrorController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly IHttpClientFactory _httpClient;

        public ErrorController(IConfiguration configuration, IHttpClientFactory httpClient)
        {
            _configuration = configuration;
            _httpClient = httpClient;
        }

        #region CapturarError
        public IActionResult CapturarError()
        {
            try
            {
                var ex = HttpContext.Features.Get<Microsoft.AspNetCore.Diagnostics.IExceptionHandlerFeature>()?.Error;


                var usuarioIdStr = HttpContext.Session.GetString("UsuarioID");
                long.TryParse(usuarioIdStr, out long usuarioIDSession);


                var client = _httpClient.CreateClient();
                var url = _configuration.GetSection("Variables:urlApi").Value + "Error/CapturarError";

                client.DefaultRequestHeaders.Add("UsuarioID", usuarioIDSession.ToString());
                client.DefaultRequestHeaders.Add("Origen", "CapturarError - Web");


                var contenidoVacio = new StringContent("", Encoding.UTF8, "application/json");
                var response = client.PostAsync(url, contenidoVacio).Result;
            }
            catch
            {
                // Silenciar si falla el reporte del error
            }


            return View("CapturarError");
        }
    }
    #endregion
}