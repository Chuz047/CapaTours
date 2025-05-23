﻿using CapaTours.Models;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Net.Http.Json;
using System.Text.Json;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Linq;

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

        #region Listado

        public async Task<IActionResult> ListadoCliente()
        {
            List<TourModel> tours = new List<TourModel>();

            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "ToursCliente/ListadoCliente";
                var response = await api.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadFromJsonAsync<RespuestaModel>();

                    if (result != null && result.Indicador)
                    {
                        tours = JsonSerializer.Deserialize<List<TourModel>>(result.Datos.ToString());
                        tours = tours?.Where(t => t.Estado == true).ToList();
                    }
                }
            }

            return View(tours);
        }

        #endregion

        #region DetallesTour

        public async Task<IActionResult> DetallesTour(long id)
        {
            if (id <= 0)
            {
                TempData["error"] = "ID de tour inválido.";
                return RedirectToAction("ListadoCliente");
            }

            TourModel? tour = null;

            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + $"ToursCliente/ListadoCliente?TourID={id}";
                var response = await api.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadFromJsonAsync<RespuestaModel>();

                    if (result != null && result.Indicador && result.Datos != null)
                    {
                        tour = JsonSerializer.Deserialize<TourModel>(result.Datos.ToString());

                        if (tour != null && tour.Resennas == null)
                        {
                            tour.Resennas = tour.Resennas ?? new List<ResennaModel>();
                        }
                    }
                }
            }

            if (tour == null)
            {
                TempData["error"] = "No se encontraron detalles para este tour.";
                return RedirectToAction("ListadoCliente");
            }

            string? usuarioIdStr = HttpContext.Session.GetString("UsuarioID");

            if (string.IsNullOrEmpty(usuarioIdStr) || !long.TryParse(usuarioIdStr, out long usuarioID))
            {
                TempData["error"] = "Debe iniciar sesión.";
                return RedirectToAction("Login", "Autenticacion");
            }

            ViewBag.UsuarioID = usuarioID;

            return View(tour);
        }

        #endregion

        #region ReservarTour

        [HttpPost]
        public async Task<IActionResult> ReservarTour(long TourID, long UsuarioID, int CantidadPersonas)
        {
            try
            {
                if (UsuarioID == 0 || TourID == 0 || CantidadPersonas <= 0)
                {
                    TempData["error"] = "Datos inválidos en la reserva.";
                    return RedirectToAction("DetallesTour", new { id = TourID });
                }

                using (var cliente = _httpClient.CreateClient())
                {
                    var url = _configuration.GetSection("Variables:urlApi").Value + "ReservasCliente/ReservarTour";

                    var body = new
                    {
                        TourID = TourID,
                        UsuarioID = UsuarioID,
                        CantidadPersonas = CantidadPersonas
                    };

                    var response = await cliente.PostAsJsonAsync(url, body);
                    var contenido = await response.Content.ReadAsStringAsync();

                    if (response.IsSuccessStatusCode)
                    {
                        TempData["mensaje"] = "Reserva realizada con éxito.";
                        return RedirectToAction("DetallesTour", new { id = TourID });
                    }
                    else
                    {
                        TempData["error"] = $"Lo sentimos, actualmente no hay capacidad suficiente para reservar.";
                        return RedirectToAction("DetallesTour", new { id = TourID });
                    }
                }
            }
            catch (Exception ex)
            {
                TempData["error"] = $"Excepción al reservar: {ex.Message}";
                return RedirectToAction("DetallesTour", new { id = TourID });
            }
        }

        #endregion
    }

}