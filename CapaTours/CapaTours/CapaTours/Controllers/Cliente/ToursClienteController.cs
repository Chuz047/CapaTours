using CapaTours.Models;
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

        #region ListadoCliente

        public async Task<IActionResult> ListadoCliente()
        {
            List<TourModel> tours = new List<TourModel>();

            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Tours/ListadoAdmin"; 
                var response = await api.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadFromJsonAsync<RespuestaModel>();

                    if (result != null && result.Indicador)
                    {
                        
                        tours = JsonSerializer.Deserialize<List<TourModel>>(result.Datos.ToString());

                       
                        tours = tours.Where(t => t.Estado == true).ToList();
                    }
                }
            }

            return View(tours); 
        }

        #endregion

        #region DetallesTour

        public async Task<IActionResult> DetallesTour(long id)
        {
            TourModel tour = null;

            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + $"Tours/ListadoAdmin?TourID={id}";
                var response = await api.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadFromJsonAsync<RespuestaModel>();

                    if (result != null && result.Indicador)
                    {
                        var tours = JsonSerializer.Deserialize<List<TourModel>>(result.Datos.ToString());
                        tour = tours?.FirstOrDefault();
                    }
                }
            }

            if (tour == null)
            {
                ViewBag.Msj = "No se encontraron detalles para este tour.";
                return View();
            }

            return View(tour);
        }

        #endregion
    }
}



