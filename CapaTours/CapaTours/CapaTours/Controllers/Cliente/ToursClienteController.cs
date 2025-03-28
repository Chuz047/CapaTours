using CapaTours.Models;
using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Cliente
{

    [FiltroSeguridadSesion]
    public class ToursClienteController : Controller
    {
		private readonly IHttpClientFactory _httpClient;
		private readonly IConfiguration _configuration;
		public ToursClienteController(IHttpClientFactory httpClient, IConfiguration configuration)
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
