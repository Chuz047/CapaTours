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

		public IActionResult Inicio()
		{
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
