using System.Data;
using System.Net.Http.Headers;
using System.Text.Json;
using CapaTours.Dependencias;
using CapaTours.Models;
using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Cliente
{
    public class ReservasClienteController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
       
        public ReservasClienteController(IHttpClientFactory httpClient, IConfiguration configuration, IUtilitarios utilitarios)
        {
            _httpClient = httpClient;
            _configuration = configuration;
            _utilitarios = utilitarios;
            
        }

        #region Listado de Reservas del Cliente

        [HttpGet]
        public async Task<IActionResult> ListadoCliente()
        {
            string? usuarioIdStr = HttpContext.Session.GetString("UsuarioID");

            if (string.IsNullOrEmpty(usuarioIdStr) || !long.TryParse(usuarioIdStr, out long usuarioID))
            {
                TempData["error"] = "Debe iniciar sesión para ver sus reservas.";
                return RedirectToAction("Login", "Autenticacion");
            }

            List<ReservaModel> reservas = new();

            using (var cliente = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + $"ReservasCliente/ListadoCliente?usuarioID={usuarioID}";
                var response = await cliente.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadFromJsonAsync<RespuestaModel>();

                    if (result != null && result.Indicador && result.Datos != null)
                    {
                        reservas = JsonSerializer.Deserialize<List<ReservaModel>>(result.Datos.ToString() ?? "")!;
                    }
                }
            }

            return View(reservas);
        }

        #endregion

        [HttpGet]
        public IActionResult PagarReserva(long ReservaID)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "ReservasCliente/PagarReserva?ReservaID=" + ReservaID;
                var response = api.GetAsync(url).Result;

                if (response.IsSuccessStatusCode)
                {
                    var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                    if (result != null && result.Indicador)
                    {
                        var reserva = ((JsonElement)result.Datos).Deserialize<ReservaModel>();

                        if (reserva != null && reserva.ReservaID == ReservaID)
                        {
                            var pagoModel = new PagoModel
                            {
                                ReservaID = reserva.ReservaID,
                                NombreTour = reserva.NombreTour,
                                Precio = reserva.Precio,
                                FechaInicio = reserva.FechaInicio,
                                FechaFin = reserva.FechaFin,
                                CantidadPersonas = reserva.CantidadPersonas,
                                Nombre = reserva.Nombre,
                                Correo = reserva.Correo
                            };

                            return View(pagoModel);
                        }
                        else
                        {
                            ViewBag.Msj = "Reserva no encontrada.";
                        }
                    }
                    else
                    {
                        ViewBag.Msj = result?.Mensaje;
                    }
                }
                else
                {
                    ViewBag.Msj = "No se pudo completar su petición";
                }

                return View(new PagoModel());
            }
        }

        [HttpPost]
        public async Task<IActionResult> PagarReserva(PagoModel model, IFormFile Comprobante)
        {

            if (Comprobante != null && Comprobante.Length > 0)
            {
                model.Comprobante = await GuardarImagenServicio(Comprobante);
            }

            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "ReservasCliente/PagarReserva";

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("Token"));
                var response = await api.PostAsJsonAsync(url, model);

                if (response.IsSuccessStatusCode)
                {
                    var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                    if (result != null && result.Indicador)
                    {
                        ViewBag.PagoExitoso = true;
                        return View("PagarReserva", model);
                    }
                    else
                        ViewBag.Msj = "No se pudo completar su petición";
                }
            }

            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> AnularReserva(long reservaID)
        {
            using (var cliente = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + $"ReservasCliente/AnularReserva?reservaID={reservaID}";
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

            return RedirectToAction("ListadoCliente", "ReservasCliente");
        }

        private async Task<string> GuardarImagenServicio(IFormFile imagen)
        {
            var rutaRelativa = Path.Combine("img", "comprobantes");

            var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", rutaRelativa);

            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }

            var uniqueFileName = $"{Guid.NewGuid()}{Path.GetExtension(imagen.FileName)}";
            var filePath = Path.Combine(uploadsFolder, uniqueFileName);

            using (var fileStream = new FileStream(filePath, FileMode.Create))
            {
                await imagen.CopyToAsync(fileStream);
            }

            return $"/img/comprobantes/{uniqueFileName}";
        }


    }
}


