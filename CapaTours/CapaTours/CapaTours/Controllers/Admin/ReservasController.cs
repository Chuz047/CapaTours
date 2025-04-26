using CapaTours.Models;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

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

        #region Listado

        [HttpGet]
        public async Task<IActionResult> ListadoAdmin()
        {
            List<ReservaAdminModel> reservas = new();

            using (var cliente = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Reservas/ListadoAdmin";
                var response = await cliente.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadFromJsonAsync<RespuestaModel>();

                    if (result != null && result.Indicador && result.Datos != null)
                    {
                        reservas = JsonSerializer.Deserialize<List<ReservaAdminModel>>(result.Datos.ToString() ?? "");
                    }
                    else
                    {
                        ViewBag.Msj = result?.Mensaje ?? "No se encontraron reservas.";
                    }
                }
                else
                {
                    ViewBag.Msj = "No se pudo obtener la información de reservas.";
                }
            }

            return View(reservas);
        }


        #endregion

        [HttpGet]
        public async Task<IActionResult> AnularReserva(long reservaID)
        {
            using (var cliente = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + $"Reservas/AnularReserva?reservaID={reservaID}";
                var response = await cliente.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    TempData["mensaje"] = "Reserva anulada correctamente.";
                }
                else
                {
                    TempData["error"] = "Error al anular la reserva.";
                }
            }

            return RedirectToAction("ListadoAdmin");
        }


    }
}
