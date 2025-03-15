using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Cliente
{
    public class ResennasController : Controller
    {
		private readonly IHttpClientFactory _httpClient;
		private readonly IConfiguration _configuration;
		public ResennasController(IHttpClientFactory httpClient, IConfiguration configuration)
		{
			_httpClient = httpClient;
			_configuration = configuration;
		}

		#region CrearResenna

		[HttpGet]
		public IActionResult CrearResenna()
		{
			return View();
		}

		#endregion

		#region Listado

		[HttpGet]
		public IActionResult Listado()
		{
			return View();
		}

		#endregion

		#region EditarResenna

		[HttpGet]
		public IActionResult EditarResenna()
		{
			return View();
		}

		#endregion
	}
}
