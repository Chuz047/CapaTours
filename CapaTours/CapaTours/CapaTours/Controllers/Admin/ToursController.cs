using System.Net.Http.Headers;
using System.Text.Json;
using CapaTours.Dependencias;
using CapaTours.Models;
using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Admin
{
    [FiltroSeguridadSesion]
    //[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public class ToursController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
        public ToursController(IHttpClientFactory httpClient, IConfiguration configuration, IUtilitarios utilitarios)
        {
            _httpClient = httpClient;
            _configuration = configuration;
            _utilitarios = utilitarios;
        }

        #region ListadoAdmin

        [HttpGet]
        public IActionResult ListadoAdmin()
        {
            var response = _utilitarios.ConsultarToursAdmin(0);

            if (response.IsSuccessStatusCode)
            {
                var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                if (result != null && result.Indicador)
                {
                    var datosResult = JsonSerializer.Deserialize<List<TourModel>>((JsonElement)result.Datos!);
                    return View(datosResult);
                }
                else
                    ViewBag.Msj = result!.Mensaje;
            }
            else
                ViewBag.Msj = "No se pudo completar su petición";

            return View(new List<TourModel>());
        }

        #endregion

        #region CrearTour

        [HttpGet]
        public IActionResult CrearTour()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CrearTour(TourModel model)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Tours/CrearTour";

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("Token"));
                var response = api.PostAsJsonAsync(url, model).Result;

                if (response.IsSuccessStatusCode)
                {
                    var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                    if (result != null && result.Indicador)
                        return RedirectToAction("ListadoAdmin", "Tours");
                    else
                        ViewBag.Msj = result!.Mensaje;
                }
                else
                    ViewBag.Msj = "No se pudo completar su petición";
            }

            return View();

        }

        #endregion

        #region EditarTour

        [HttpGet]
        public IActionResult EditarTour(long TourID)
        {
            var response = _utilitarios.ConsultarToursAdmin(TourID);

            if (response.IsSuccessStatusCode)
            {
                var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                if (result != null && result.Indicador)
                {
                    var datosResult = JsonSerializer.Deserialize<List<TourModel>>(result.Datos.ToString());

                    var tour = datosResult?.FirstOrDefault(t => t.TourID == TourID);

                    if (tour != null)
                    {
                        return View(tour);
                    }
                    else
                    {
                        ViewBag.Msj = "Tour no encontrado.";
                    }
                }
                else
                {
                    ViewBag.Msj = result!.Mensaje;
                }
            }
            else
            {
                ViewBag.Msj = "No se pudo completar su petición";
            }

            return View(new TourModel());
        }

        [HttpPost]
        public IActionResult EditarTour(TourModel model)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Tours/EditarTour";

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("Token"));
                var response = api.PutAsJsonAsync(url, model).Result;

                if (response.IsSuccessStatusCode)
                {
                    var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                    if (result != null && result.Indicador)
                        return RedirectToAction("ListadoAdmin", "Tours");
                    else
                        ViewBag.Msj = result!.Mensaje;
                }
                else
                    ViewBag.Msj = "No se pudo completar su petición";
            }

            return View();
        }

        #endregion

        #region Desactivar Tour

        [HttpPost]
        public IActionResult DesactivarTour(long TourID)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Tours/DesactivarTour";

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("Token"));
                var result = api.PutAsJsonAsync(url, TourID).Result;

                if (result.IsSuccessStatusCode)
                {
                    ViewBag.Mensaje = "El tour ha sido desactivado correctamente.";
                }
                else
                {
                    ViewBag.Mensaje = "Hubo un error al desactivar el tour.";
                }
            }

            return RedirectToAction("ListadoAdmin");
        }

        #endregion

        #region Activar Tour

        [HttpPost]
        public IActionResult ActivarTour(long TourID)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Tours/ActivarTour";

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("Token"));
                var result = api.PutAsJsonAsync(url, TourID).Result;

                if (result.IsSuccessStatusCode)
                {
                    ViewBag.Mensaje = "El tour ha sido activado correctamente.";
                }
                else
                {
                    ViewBag.Mensaje = "Hubo un error al activar el tour.";
                }
            }

            return RedirectToAction("ListadoAdmin");
        }


        #endregion

        #region AplicarDescuento

        #endregion
    }
}

