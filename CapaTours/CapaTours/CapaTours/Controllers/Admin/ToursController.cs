using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Admin
{
    public class ToursController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        public ToursController(IHttpClientFactory httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        #region Listado

        [HttpGet]
        public IActionResult ListadoAdmin()
        {
            return View();
        }

        #endregion

        #region CrearTour

        [HttpGet]
        public IActionResult CrearTour()
        {
            return View();
        }
        #endregion

        #region Editar

        [HttpGet]
        public IActionResult EditarTour()
        {
            return View();
        }
        #endregion
    }
}
