using CapaTours.Models;
using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Cliente
{
    [FiltroSeguridadSesion]
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
        public IActionResult CrearResenna(long reservaID, long tourID, long usuarioID)
        {
            var model = new ResennaModel
            {
                ReservaID = reservaID,
                TourID = tourID,
                UsuarioID = usuarioID
            };

            return View(model);
        }

        [HttpPost]
        public async Task<IActionResult> CrearResenna(ResennaModel model)
        {
            if (ModelState.IsValid)
            {
                using (var api = _httpClient.CreateClient())
                {
                    var url = _configuration.GetSection("Variables:urlApi").Value + "ResennasCliente/CrearResenna";

                    var response = await api.PostAsJsonAsync(url, model);

                    if (response.IsSuccessStatusCode)
                    {
                        var result = await response.Content.ReadFromJsonAsync<RespuestaModel>();
                        if (result != null && result.Indicador)
                        {
                            TempData["SuccessMessage"] = "Su reseña ha sido agregada correctamente.";
                            return RedirectToAction("ListadoCliente", "ReservasCliente");
                        }
                        else
                        {
                            ViewBag.Msj = result?.Mensaje ?? "No se pudo completar su petición";
                        }
                    }
                    else
                    {
                        ViewBag.Msj = "Error al procesar la solicitud.";
                    }
                }
            }

            return View(model);
        }

        #endregion

	}
}
