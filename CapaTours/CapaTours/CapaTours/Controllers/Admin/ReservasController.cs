using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Admin
{
    public class ReservasController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        public ReservasController(IHttpClientFactory httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        #region RealizarReserva

        [HttpGet]
        public IActionResult RealizarReserva()
        {
            return View();
        }

        #endregion

        #region Listado

        [HttpGet]
        public IActionResult ListadoAdmin()
        {
            return View();
        }

        #endregion
    }
}
