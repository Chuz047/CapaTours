using CapaTours.Dependencias;
using CapaTours.Models;
using CapaToursAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace CapaTours.Controllers.Admin
{
    public class ClientesController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
        public ClientesController(IHttpClientFactory httpClient, IConfiguration configuration, IUtilitarios utilitarios)
        {
            _httpClient = httpClient;
            _configuration = configuration;
            _utilitarios = utilitarios;
        }

        #region ListadoAdmin

        [HttpGet]
        public IActionResult ListadoAdmin()
        {
            var response = _utilitarios.ConsultarClientesAdmin(0);

            if (response.IsSuccessStatusCode)
            {
                var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                if (result != null && result.Indicador)
                {
                    var datosResult = JsonSerializer.Deserialize<List<UsuarioModel>>((JsonElement)result.Datos!);
                    return View(datosResult);
                }
                else
                    ViewBag.Msj = result!.Mensaje;
            }
            else
                ViewBag.Msj = "No se pudo completar su petición";

            return View(new List<UsuarioModel>());
        }

        #endregion

        #region Editar

        [HttpGet]
        public IActionResult EditarCliente()
        {
            return View();
        }
        #endregion
    }
}
