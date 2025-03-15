using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Admin
{
    public class ClientesController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        public ClientesController(IHttpClientFactory httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        #region Listado

        [HttpGet]
        public IActionResult Listado()
        {
            return View();
        }

        #endregion

        #region CrearCliente

        [HttpGet]
        public IActionResult CrearCliente()
        {
            return View();
        }
        #endregion

        #region EditarCliente

        [HttpGet]
        public IActionResult EditarCliente()
        {
            return View();
        }
        #endregion
    }
}
