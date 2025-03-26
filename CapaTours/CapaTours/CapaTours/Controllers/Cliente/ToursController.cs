using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Cliente
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

        #region Inicio

        [HttpGet]
        public IActionResult Inicio()
        {
            if (HttpContext.Session.GetString("Token") == null)
                return RedirectToAction("Login", "Autenticacion");

            return View();
        }

        #endregion

        #region ListadoCliente

        public IActionResult ListadoCliente()
		{
			return View();
		}

		#endregion

		#region DetallesTour

		public IActionResult DetallesTour()
		{
			return View();
		}

		#endregion
	}
}
