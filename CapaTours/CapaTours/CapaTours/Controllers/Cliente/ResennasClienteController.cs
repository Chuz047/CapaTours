using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Cliente
{
    public class ResennasClienteController : Controller
    {
		private readonly IHttpClientFactory _httpClient;
		private readonly IConfiguration _configuration;
		public ResennasClienteController(IHttpClientFactory httpClient, IConfiguration configuration)
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
		public IActionResult ListadoCliente()
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
