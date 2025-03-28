using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Cliente
{
    public class ReservasClienteController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        public ReservasClienteController(IHttpClientFactory httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        #region Listado

        [HttpGet]
        public IActionResult ListadoCliente()
        {
            return View();
        }

        #endregion


        [HttpGet]
        public IActionResult PagarReserva()
        {
            return View();
        }
    }
}
